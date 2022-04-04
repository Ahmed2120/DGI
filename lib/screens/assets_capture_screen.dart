import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:dgi/Services/CategoryService.dart';
import 'package:dgi/Services/CaptureDetailsService.dart';
import 'package:dgi/Services/ItemService.dart';
import 'package:dgi/Services/MainCategoryService.dart';
import 'package:dgi/Services/ServerService.dart';
import 'package:dgi/Utility/footer.dart';
import 'package:dgi/model/category.dart';
import 'package:dgi/model/CaptureDetails.dart';
import 'package:dgi/model/item.dart';
import 'package:dgi/model/mainCategory.dart';
import 'package:dgi/screens/take_picture_page.dart';
import 'package:flutter/material.dart';
import '../Utility/CustomWidgetBuilder.dart';

class AssetsCapture extends StatefulWidget {
  final assetLocationId;

  AssetsCapture({Key? key, required this.assetLocationId}) : super(key: key);

  @override
  State<AssetsCapture> createState() => _AssetsCaptureState();
}

class _AssetsCaptureState extends State<AssetsCapture> {
  String? category;
  String?mainCategory;
  String?item;
  String? imagePath;

  List<Category> categories = [];
  List<MainCategory> mainCategories=[];
  List<Item> items=[];
  List<Category> allCategories = [];
  List<Item> allItems=[];

  var descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final categoryService = CategoryService();
  final captureDetailsService = CaptureDetailsService();
  final mainCategoryService = MainCategoryService();
  final serverService = ServerService();
  final itemService = ItemService();
  int quantity = 1;
  List<CaptureDetails> captureDetails = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
    getItems();
  }
  changeCategory(value){
    setState(() {
      category = value;
      Category selected = categories.firstWhere((element) => element.name==category);
      items = allItems.where((element) => element.categoryId==selected.id).toList();
      if(items.isNotEmpty)
      changeItem(items[0].name);
    });
  }
  changeMainCategory(value){
    setState(() {
      mainCategory = value;
      MainCategory selected = mainCategories.firstWhere((element) => element.name==mainCategory);
      categories = allCategories.where((element) => element.mainCategoryId==selected.id).toList();
      changeCategory(categories[0].name);
    });
  }
  changeItem(value){
    setState(() {
      item = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dSize = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          height: dSize.height,
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
                height: dSize.height * 0.37,
                padding: EdgeInsets.symmetric(horizontal: dSize.height * 0.016),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      dropdownMenu('MAIN CATEGORY', dSize,
                          mainCategories.map((e) => e.name).toList(),changeMainCategory,mainCategory),
                      dropdownMenu('CATEGORY', dSize,
                          categories.map((e) => e.name).toList(),changeCategory,category),
                      dropdownMenu('ITEM', dSize,
                          items.map((e) => e.name).toList(),changeItem,item),
                      SizedBox(height:dSize.height * 0.01 ,),
                      Row(
                        children: [
                          CustomWidgetBuilder.buildText('ITEM DESC', dSize),
                          Spacer(),
                          Container(
                            width: dSize.width * 0.5,
                            child: TextFormField(
                              controller: descriptionController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder( borderSide: BorderSide(color: Color(0xFF00B0BD), width: 2)),
                                focusedBorder: OutlineInputBorder( borderSide: BorderSide(color: Color(0xFF00B0BD), width: 2)),
                                contentPadding: EdgeInsets.all(dSize.height <= 430 ? dSize.height * 0.009 : 7),
                                isDense: true,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          CustomWidgetBuilder.buildText('QUANTITY', dSize),
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
                                    radius: 10,
                                    child: Icon(Icons.remove, size: 20,),
                                  ),
                                ),
                                SizedBox(
                                  width: dSize.width * 0.0159,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: dSize.height * 0.001,
                                      horizontal: 22.919),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xFF00B0BD),
                                          width: dSize.height >= 430 ? 1.5 : 0.5),
                                      borderRadius:
                                          BorderRadius.circular(15)),
                                  child: Text(
                                    quantity.toString(),
                                    style: TextStyle(
                                        color: Color(0xFF0F6671),
                                        fontSize: 15.28,
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
                                    radius: 10,
                                    child: Icon(Icons.add, size: 20),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          CustomWidgetBuilder.buildText('PHOTO', dSize),
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
                      height: dSize.height < 600 ? dSize.height * 0.36 : dSize.height * 0.39,
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
                        'ITEM TOTAL     ${captureDetails.length}',
                        style: TextStyle(
                          fontSize: dSize.width <= 500 ? dSize.width * 0.02 : 12,
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

  initMainCategories() async {
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
                fontSize: 11,
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
      bool itemExist = false;
      captureDetails.forEach((element) {if(element.itemId == items.firstWhere((element) => element.name == item).id) itemExist = true;});
      if(itemExist) {
        _showErrorDialog('Item Already Exist');
      }else{
    File file = File(imagePath!);
    final Uint8List bytes = file.readAsBytesSync();
    String base64Image = base64Encode(bytes);
    String description = descriptionController.text;
    int? itemId =
        items.firstWhere((element) => element.name == item).id;
    captureDetailsService.insert(CaptureDetails(
      assetLocationId: widget.assetLocationId,
      itemId: itemId,
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
    }}}
  }

  void getItems() async {
    captureDetailsService.retrieve().then((value) => {
          setState(() {
            captureDetails = value;
          })
        });
  }

  List<TableRow> _getListings() {
    List<TableRow> listings = <TableRow>[];
    int i = 0;
      listings.add(
        CustomWidgetBuilder.buildRow(['No', 'TYPE', 'DESC', 'QNT', 'PHOTO'], isHeader: true),
      );
    for (i = 0; i < captureDetails.length; i++) {
      listings.add(
        CustomWidgetBuilder.buildRow(
          [
            i + 1,
            items.firstWhere((element) => element.id==captureDetails[i].itemId).name,
            captureDetails[i].description,
            captureDetails[i].quantity.toString(),
            Image.memory(
              base64Decode(captureDetails[i].image),
              height: 40,
              fit: BoxFit.fill,
            )
          ],
        ),
      );
    }
    return listings;
  }

  dropdownMenu(String title, Size dSize, List<String> values,Function onChange,String? value) {
    return Row(
      children: [
        CustomWidgetBuilder.buildText(title, dSize),
        Spacer(),
        Container(
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Color(0xFF00B0BD), width: 2))),
          width: dSize.width * 0.5,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              iconSize: 20,
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Color(0xFF00B0BD),
              ),
              isDense: true,
              isExpanded: true,
              items: values.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style:
                        const TextStyle(color: Color(0xFF0F6671), fontSize: 15),
                  ),
                );
              }).toList(),
              onChanged: (val)=>{
                onChange(val)
              }
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

  void initData()async {
    mainCategories = await mainCategoryService.retrieve();
    allCategories = await categoryService.retrieve();
    allItems = await itemService.retrieve();
    setState(() {
      mainCategory = mainCategories[0].name;
      categories = allCategories.where((element) => element.mainCategoryId==mainCategories[0].id).toList();
      category = categories[0].name;
      items = allItems.where((element) => element.categoryId==categories[0].id).toList();
      item = items[0].name;
    });
  }
}
