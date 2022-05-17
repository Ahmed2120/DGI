import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:dgi/Services/AssetService.dart';
import 'package:dgi/Services/DepartmentService.dart';
import 'package:dgi/Utility/footer.dart';
import 'package:dgi/model/asset.dart';
import 'package:dgi/model/category.dart';
import 'package:dgi/model/department.dart';
import 'package:dgi/model/floor.dart';
import 'package:dgi/model/sectionType.dart';
import 'package:dgi/screens/take_picture_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../Services/FloorService.dart';
import '../Services/SectionTypeService.dart';
import '../Utility/CustomWidgetBuilder.dart';

class AssetsDetails extends StatefulWidget {
  //Category category;

  AssetsDetails({Key? key}) : super(key: key);

  @override
  State<AssetsDetails> createState() => _AssetsDetailsState();
}

class _AssetsDetailsState extends State<AssetsDetails> {
  Asset? asset;
  final assetService = AssetService();
  final sectionTypeService = SectionTypeService();
  final departmentService = DepartmentService();
  final floorService = FloorService();
  List<Asset> assets = [];
  List<Asset> allAssets = [];
  List<SectionType> allSections = [];
  List<Department> allDepartments = [];
  List<Floor> allFloors = [];
  String? _section;
  String? _department;
  String? _floor;

  TextEditingController serialController = TextEditingController();
  String? imagePath;
  bool error = false;

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getItems();
  }

  @override
  Widget build(BuildContext context) {
    final dSize = MediaQuery.of(context).size;
    final bottomPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          height: dSize.height - bottomPadding,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: dSize.height * 0.172,
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
                                vertical: 2, horizontal: 25),
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
                                  ),
                                  children: const <InlineSpan>[
                                    TextSpan(
                                      text: 'ASSETS ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: 'VERIFICATION',
                                    ),
                                  ]),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: dSize.height * 0.011,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: dSize.height * 0.007),
                      width: double.infinity,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'ASSETS TOTAL : ' + allAssets.length.toString(),
                            style: TextStyle(
                                color: const Color(0xFF0F6671),
                                fontSize: dSize.width * 0.031),
                          ),
                          Text(
                            'REMAIN : ' +
                                allAssets
                                    .where((element) => element.isVerified == 2 || element.isVerified == null)
                                    .toList()
                                    .length
                                    .toString(),
                            style: TextStyle(
                                color: const Color(0xFF0F6671),
                                fontSize: dSize.width * 0.037),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: SizedBox(
                  height: dSize.height * 0.676,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CustomWidgetBuilder.buildText('BARCODE', dSize),
                            const Spacer(),
                            InkWell(
                              onTap: () => scanBarcodeNormal(),
                              // onTap: ()=>getItemData('00502100231007'),
                              child: Container(
                                padding: EdgeInsets.all(dSize.height * 0.007),
                                width: dSize.width * 0.5,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xFF00B0BD),
                                      width: 2.0),
                                ),
                                child: const Text(
                                  'Tap to scan barcode',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (error)
                          const Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "There is no item found with this barcode",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomWidgetBuilder.buildText(
                                    'ASSET DETAILS', dSize),
                              ],
                            ),
                            // SizedBox(
                            //   height: dSize.height * 0.01,
                            // ),
                            Container(
                                width: 200,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xFF00B0BD),
                                      width: 2.0),
                                ),
                                height: 100,
                                child: asset == null
                                    ? Image.asset(
                                        'assets/icons/img.png',
                                        fit: BoxFit.cover,
                                        width: 300,
                                      )
                                    : InkWell(
                                        onTap: () => _showCamera(),
                                        child: Image.memory(
                                          base64Decode(imagePath!),
                                          width: 300,
                                          height: 100,
                                        ),
                                      )),
                          ],
                        ),
                        SizedBox(
                          height: dSize.height * 0.01,
                        ),
                        Row(
                          children: [
                            CustomWidgetBuilder.buildText('SERIAL NO', dSize),
                            const Spacer(),
                            Container(
                              width: dSize.width * 0.5,
                              child: TextFormField(
                                controller: serialController,
                                style: TextStyle(
                                    fontSize: dSize.height <= 500
                                        ? 10
                                        : dSize.height * 0.02),
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFF00B0BD), width: 2)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFF00B0BD), width: 2)),
                                  disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFF00B0BD), width: 2)),
                                  contentPadding: EdgeInsets.all(
                                      dSize.height <= 600
                                          ? dSize.height * 0.015
                                          : 6),
                                  isDense: true,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CustomWidgetBuilder.buildText('SECTION', dSize),
                            const Spacer(),
                            Container(
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Color(0xFF00B0BD), width: 2))),
                              width: dSize.width * 0.5,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _section,
                                  iconSize: 20,
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Color(0xFF00B0BD),
                                  ),
                                  isDense: true,
                                  isExpanded: true,
                                  items: allSections
                                      .map((e) => e.name)
                                      .map((String item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                            color: Color(0xFF0F6671),
                                            fontSize: 15),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      _section = val;
                                    });
                                    print(val);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CustomWidgetBuilder.buildText('DEPARTMENT', dSize),
                            const Spacer(),
                            Container(
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Color(0xFF00B0BD), width: 2))),
                              width: dSize.width * 0.5,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _department,
                                  iconSize: 20,
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Color(0xFF00B0BD),
                                  ),
                                  isDense: true,
                                  isExpanded: true,
                                  items: allDepartments
                                      .map((e) => e.name)
                                      .map((String item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                            color: Color(0xFF0F6671),
                                            fontSize: 15),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      _department = val;
                                    });
                                    print(val);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CustomWidgetBuilder.buildText('FLOOR', dSize),
                            const Spacer(),
                            Container(
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Color(0xFF00B0BD), width: 2))),
                              width: dSize.width * 0.5,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _floor,
                                  iconSize: 20,
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Color(0xFF00B0BD),
                                  ),
                                  isDense: true,
                                  isExpanded: true,
                                  items: allFloors
                                      .map((e) => e.name)
                                      .map((String item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                            color: Color(0xFF0F6671),
                                            fontSize: 15),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      _floor = val;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ElevatedButton(
                                  child: const Text('UPDATE'),
                                  onPressed: () => editAsset(),
                                  style: ElevatedButton.styleFrom(
                                      primary: const Color(0xFF00B0BD),
                                      minimumSize: const Size(5, 30)),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              child: const Text('DONE'),
                              onPressed: () => updateItem(),
                              style: ElevatedButton.styleFrom(
                                  primary: const Color(0xFF00B0BD),
                                  minimumSize: const Size(5, 30)),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                height: dSize.height * 0.2,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: ListView(
                                    children: [
                                      Table(
                                          border: TableBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          children: _getListings()),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomWidgetBuilder.buildArrow(
                        context,
                        dSize,
                        const Icon(Icons.arrow_back_ios_rounded),
                        () => Navigator.of(context).pop()),
                  ],
                ),
              ),
              const Footer()
            ],
          ),
        ),
      ),
    ));
  }

  List<TableRow> _getListings() {
    List<TableRow> listings = <TableRow>[];
    int i = 0;
    listings.add(
      CustomWidgetBuilder.buildRow(['No', 'DESC', 'PHOTO'],
          isHeader: true),
    );
    for (i = 0; i < assets.length; i++) {
      listings.add(
        CustomWidgetBuilder.buildRow(
          [
            i + 1,
            //widget.category.name,
            assets[i].description,
            Image.memory(
              base64Decode(assets[i].image),
              height: 30,
            )
          ],
        ),
      );
    }
    return listings;
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      getItemData(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  void getItemData(String barcodeScanRes) async {
    List<Asset> assets = await assetService.select(barcodeScanRes);
    allSections = await sectionTypeService.retrieve();
    allDepartments = await departmentService.retrieve();
    allFloors = await floorService.retrieve();
    setState(() {
      if (assets.isNotEmpty) {
        error = false;
        asset = assets[0];
        imagePath = asset?.image;

        if (asset?.sectionId != null) {
          _section = allSections
              .firstWhere((element) => element.id == asset?.sectionId)
              .name;
        }
        if (asset?.departmentId != null) {
          _department = allDepartments
              .firstWhere((element) => element.id == asset?.departmentId)
              .name;
        }
        if (allAssets[0].floorId != null) {
          _floor = allFloors
              .firstWhere((element) => element.id == asset?.floorId)
              .name;
        }
        if(asset != null && asset?.serialnumber != null){
          serialController.text = asset!.serialnumber==null?'': asset!.serialnumber!;
        }
      } else {
        error = true;
      }
    });
  }

  getItems() async {
    assets = await assetService.getAllVerifiedItems();
    allAssets = await assetService.retrieve();
    setState(() {});
  }

  updateItem() async{
    if (asset != null) {
      asset!.isVerified = 1;
      await assetService.update(asset!);
      asset = null;
      serialController.text="";
      getItems();
    }
  }

  editAsset() {
    if (imagePath != null) {
      asset?.image = imagePath!;
    }
    if (serialController.text.isNotEmpty) {
      asset?.serialnumber = serialController.text;
    }
    if (_section != null) {
      asset?.sectionId =
          allSections.firstWhere((element) => element.name == _section).id;
    }
    if (_department != null) {
      asset?.departmentId = allDepartments
          .firstWhere((element) => element.name == _department)
          .id;
    }
    if (_floor != null) {
      asset?.floorId =
          allFloors.firstWhere((element) => element.name == _floor).id;
    }
    assetService.update(asset!);
  }

  _showCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TakePicturePage(camera: camera)));
    setState(() {
      File file = File(result!);
      final Uint8List bytes = file.readAsBytesSync();
      String base64Image = base64Encode(bytes);
      imagePath = base64Image;
    });
  }
}
