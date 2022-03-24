import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:dgi/Services/CategoryService.dart';
import 'package:dgi/Services/ItemService.dart';
import 'package:dgi/model/category.dart';
import 'package:dgi/model/item.dart';
import 'package:dgi/screens/take_picture_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Utility/CustomWidgetBuilder.dart';

class AssetsCapture extends StatefulWidget {
  int assetLocationId;

  AssetsCapture({Key? key, required this.assetLocationId}) : super(key: key);

  @override
  State<AssetsCapture> createState() => _AssetsCaptureState();
}

class _AssetsCaptureState extends State<AssetsCapture> {
  List<Category> categories = [];
  String? value;
  String? imagePath;
  var descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final categoryService = CategoryService();
  final itemService = ItemService();
  int quantity = 1;
  List<Item> items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initCategories();
    getItems();
  }

  @override
  Widget build(BuildContext context) {
    final dSize = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          height: dSize.height - 24,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: dSize.height * 0.15,
                padding: EdgeInsets.symmetric(vertical: dSize.height * 0.015),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Color(0xFF26BB9B),
                          Color(0xFF00B0BD),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        stops: [0, 1])),
                child: Column(
                  children: [
                    const Text(
                      'DGI ASSETS TRACKING',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontFamily: 'Montserrat'),
                    ),
                    SizedBox(
                      height: dSize.height * 0.035,
                    ),
                    Row(
                      children: [
                        Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 25),
                            decoration: const BoxDecoration(
                              color: Color(0xFFFFA227),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12),
                                  bottomRight: Radius.circular(12)),
                            ),
                            child: Text.rich(
                              TextSpan(
                                  style: TextStyle(
                                      fontSize: dSize.height * 0.028,
                                      color: Colors.white,
                                      fontFamily: 'Montserrat'),
                                  children: const <InlineSpan>[
                                    TextSpan(
                                      text: 'ASSETS ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: 'CAPTURE',
                                    ),
                                  ]),
                            )),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(dSize.height * 0.016),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        dropdownMenu('CATEGORY', dSize,
                            categories.map((e) => e.name).toList()),
                        Row(
                          children: [
                            const Text('ITEM DESC'),
                            Spacer(),
                            Container(
                              width: dSize.width * 0.4,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color(0xFF00B0BD), width: 2.0),
                              ),
                              child: TextFormField(
                                controller: descriptionController,
                                decoration: InputDecoration(
                                  constraints: BoxConstraints(
                                      maxHeight: dSize.height * 0.045),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('QUANTITY'),
                            Spacer(),
                            SizedBox(
                              width: dSize.width * 0.4,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (quantity > 1) {
                                        setState(() {
                                          quantity--;
                                        });
                                      }
                                    },
                                    child: const CircleAvatar(
                                      backgroundColor: Color(0xFFFFA227),
                                      foregroundColor: Colors.white,
                                      radius: 12,
                                      child: Icon(Icons.remove),
                                    ),
                                  ),
                                  SizedBox(
                                    width: dSize.width * 0.0159,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: dSize.height * 0.004,
                                        horizontal: dSize.width * 0.06),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xFF00B0BD),
                                            width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Text(
                                      quantity.toString(),
                                      style: TextStyle(
                                          color: Color(0xFF0F6671),
                                          fontSize: dSize.width * 0.04,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    width: dSize.width * 0.0159,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        quantity++;
                                      });
                                    },
                                    child: const CircleAvatar(
                                      backgroundColor: Color(0xFF00B0BD),
                                      foregroundColor: Colors.white,
                                      radius: 12,
                                      child: Icon(Icons.add),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text('PHOTO'),
                            Spacer(),
                            InkWell(
                              child: SizedBox(
                                width: dSize.width * 0.4,
                                child: Image.asset(
                                  'assets/icons/0-16.jpg',
                                  height: dSize.height * 0.055,
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                              onTap: () async {
                                _showCamera();
                              },
                            ),
                            imagePath != null
                                ? SizedBox(
                                    width: dSize.width * 0.4,
                                    child: Image.file(
                                      File(imagePath!),
                                      height: dSize.height * 0.055,
                                      alignment: Alignment.centerLeft,
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                        buildAddButton(),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      height: dSize.height * 0.3,
                      child: ListView(
                        children: [
                          Table(
                              border: TableBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              children: _getListings()),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        'ITEM TOTAL     000',
                        style: TextStyle(
                            color: Color(0xFF0F6671),
                            fontWeight: FontWeight.bold),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // InkWell(
                    //   onTap: ()=>Navigator.of(context).push(
                    //       MaterialPageRoute(
                    //           builder: (context) => AssetsCounter())),
                    //   child: Container(
                    //     padding: EdgeInsets.all(5),
                    //     alignment: Alignment.center,
                    //     decoration: BoxDecoration(
                    //         color: Color(0xFF00B0BD),
                    //         borderRadius: BorderRadius.circular(5)
                    //     ),
                    //     child: Icon(Icons.arrow_forward_ios, color: Colors.white,),
                    //   ),
                    // ),
                    CustomWidgetBuilder.buildArrow(
                        context,
                        Icon(Icons.arrow_back_ios_rounded),
                        () => Navigator.of(context).pop()),
                  ],
                ),
              ),
              Container(
                  width: double.infinity,
                  height: dSize.height * 0.07,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Color(0xFF26BB9B),
                            Color(0xFF00B0BD),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: [0, 1])),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'USER NAME : MO GAMAL',
                        style: TextStyle(
                            color: Colors.white, fontSize: dSize.width * 0.037),
                      ),
                      Text(
                        'PDA NO : 1023088',
                        style: TextStyle(
                            color: Colors.white, fontSize: dSize.width * 0.037),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    ));
  }

  TableRow buildRow(List<dynamic> cells, {bool isHeader = false}) => TableRow(
        decoration: BoxDecoration(
            color: isHeader
                ? Color(0xFFFFA227)
                : cells[0] % 2 == 0
                    ? Colors.grey[200]
                    : Colors.grey[300],
            borderRadius: isHeader
                ? BorderRadius.circular(10)
                : BorderRadius.circular(0)),
        children: cells
            .map((cell) => Padding(
                  padding: EdgeInsets.all(8.0),
                  child: cell.runtimeType == String || cell.runtimeType == int
                      ? Text(
                          '$cell',
                          style: TextStyle(
                              color:
                                  isHeader ? Colors.white : Color(0xFF0F6671),
                              fontWeight: isHeader
                                  ? FontWeight.bold
                                  : FontWeight.normal),
                        )
                      : cell,
                ))
            .toList(),
      );


  initCategories() async {
    categoryService.retrieve().then((result) => {
          setState(() {
            categories = result;
          })
        });
  }

  _showCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TakePicturePage(camera: camera)));
    setState(() {
      imagePath = result;
    });
  }

  buildAddButton() {
    return InkWell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'ADD ',
            style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF0F6671),
                fontWeight: FontWeight.bold),
          ),
          Icon(
            Icons.add,
            size: 17,
            color: Color(0xFF00B0BD),
          ),
        ],
      ),
      onTap: () {
        saveItem();
      },
    );
  }

  void saveItem() async {
    File file = File(imagePath!);
    print('image: $file');
    final Uint8List bytes = file.readAsBytesSync();
    print('byte: ${imagePath}');
    String base64Image = base64Encode(bytes);
    print('base64Image: $base64Image');
    // print('base6: ${base64Decode(items[0].image)}');

    // print('base6jjjj: ${Image.memory(base64Decode(items[0].image))}');
    String description = descriptionController.text;
    int? categoryId =
        categories.firstWhere((element) => element.name == value).id;
    itemService.insert(Item(
      assetLocationId: widget.assetLocationId,
      categoryId: categoryId,
      description: description,
      image: base64Image,
      quantity: quantity,
    ));
    getItems();
  }

  void getItems() async {
    itemService.retrieve().then((value) => {
          setState(() {
            items = value;
          })
        });
  }

  List<TableRow> _getListings() {
    List<TableRow> listings = <TableRow>[];
    int i = 0;
    for (i = 0; i < items.length; i++) {
      if (i == 0) {
        listings.add(
          buildRow(['No', 'TYPE', 'DESC', 'QNT', 'PHOTO'], isHeader: true),
        );
      }
      listings.add(
        buildRow(
          [
            i + 1,
            'TYPE',
            items[i].description,
            items[i].quantity.toString(),
            Image.memory(
              base64Decode(items[i].image),
              height: 30,
            )
          ],
        ),
      );
    }
    return listings;
  }

  dropdownMenu(String title, Size dSize, List<String> values) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, color: Color(0xFF0F6671)),
        ),
        Spacer(),
        Container(
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Color(0xFF00B0BD), width: 2))),
          width: dSize.width * 0.4,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              iconSize: 30,
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Color(0xFF00B0BD),
              ),
              isExpanded: true,
              items: values.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style:
                        const TextStyle(color: Color(0xFF0F6671), fontSize: 20),
                  ),
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  value = val;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
