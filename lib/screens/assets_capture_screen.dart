import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:dgi/Services/CategoryService.dart';
import 'package:dgi/Services/ItemService.dart';
import 'package:dgi/Utility/footer.dart';
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
  String? category;
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
    print('width: ${dSize.height * 0.007}');
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          height: dSize.height - 24,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: dSize.height * 0.122,
                padding: EdgeInsets.symmetric(vertical: dSize.height * 0.007),
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
                    Text(
                      'DGI ASSETS TRACKING',
                      style: TextStyle(
                          fontSize: dSize.height * 0.027,
                          color: Colors.white,
                          fontFamily: 'Montserrat'),
                    ),
                    SizedBox(
                      height: dSize.height * 0.03,
                    ),
                    Row(
                      children: [
                        Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(
                                vertical: dSize.height * 0.004, horizontal: 25),
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
              Container(
                height: dSize.height * 0.32,
                padding: EdgeInsets.symmetric(horizontal: dSize.height * 0.016),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      dropdownMenu('CATEGORY', dSize,
                          categories.map((e) => e.name).toList()),
                      Row(
                        children: [
                          buildText('ITEM DESC', dSize),
                          Spacer(),
                          Container(
                            width: dSize.width * 0.5,
                            child: TextFormField(
                              controller: descriptionController,
                              decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder( borderSide: BorderSide(color: Color(0xFF00B0BD), width: 2)),
                                focusedBorder: OutlineInputBorder( borderSide: BorderSide(color: Color(0xFF00B0BD), width: 2)),
                                contentPadding: EdgeInsets.all(8),
                                isDense: true,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          buildText('QUANTITY', dSize),
                          Spacer(),
                          SizedBox(
                            width: dSize.width * 0.5,
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
                          buildText('PHOTO', dSize),
                          Spacer(),
                          InkWell(
                            child: SizedBox(
                              width: dSize.width * 0.5,
                              child: imagePath == null ?
                              Image.asset(
                                'assets/icons/0-16.jpg',
                                height: dSize.height * 0.055,
                                alignment: Alignment.centerLeft,
                              ) : Image.file(
                                File(imagePath!),
                                height: dSize.height * 0.055,
                                alignment: Alignment.bottomLeft,
                              ),
                            ),
                            onTap: () async {
                              _showCamera();
                            },
                          ),
                        ],
                      ),
                      buildAddButton(),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      height: dSize.height * 0.36,
                      child:ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: ListView(
                          children: [
                            Table(
                                border: TableBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                children: _getListings()),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        'ITEM TOTAL     ${items.length}',
                        style: TextStyle(
                          fontSize: dSize.width * 0.03,
                            color: Color(0xFF0F6671),
                            fontWeight: FontWeight.bold),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomWidgetBuilder.buildArrow(
                        context,
                        dSize,
                        Icon(Icons.arrow_back_ios_rounded),
                        () => Navigator.of(context).pop()),
                  ],
                ),
              ),
              Footer()
            ],
          ),
        ),
      ),
    ));
  }

  initCategories() async {
    categoryService.retrieve().then((result) => {
          setState(() {
            categories = result;
            category = categories[0].name;
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
    if(descriptionController.text.isEmpty || imagePath == null)
      _showErrorDialog('Fill in the empty fields');
    else{
    File file = File(imagePath!);
    final Uint8List bytes = file.readAsBytesSync();
    String base64Image = base64Encode(bytes);
    String description = descriptionController.text;
    int? categoryId =
        categories.firstWhere((element) => element.name == category).id;
    itemService.insert(Item(
      assetLocationId: widget.assetLocationId,
      categoryId: categoryId,
      description: description,
      image: base64Image,
      quantity: quantity,
    ));
    getItems();
    resetForm();
    // delete file to avoid cash overload
    try {
      file.deleteSync();
    }catch(ex){
      print(ex);
    }}
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
      listings.add(
        CustomWidgetBuilder.buildRow(['No', 'TYPE', 'DESC', 'QNT', 'PHOTO'], isHeader: true),
      );
    for (i = 0; i < items.length; i++) {
      listings.add(
        CustomWidgetBuilder.buildRow(
          [
            i + 1,
            categories.firstWhere((element) => element.id==items[i].categoryId).name,
            items[i].description,
            items[i].quantity.toString(),
            Image.memory(
              base64Decode(items[i].image),
              height: 40,
              fit: BoxFit.fill,
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
        buildText(title, dSize),
        Spacer(),
        Container(
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Color(0xFF00B0BD), width: 2))),
          width: dSize.width * 0.5,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: category,
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
                  category = val;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Text buildText(String title, dSize) {
    return Text(
      title,
      style: TextStyle(
          fontSize: dSize.width * 0.03,
          color: Color(0xFF0F6671),
          fontWeight: FontWeight.bold),
    );
  }

  void resetForm() {
    quantity =1;
    imagePath=null;
    descriptionController.text="";
  }

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('An error Occurred'),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ));
  }
}
