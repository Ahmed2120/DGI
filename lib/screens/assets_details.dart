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

import '../Services/BrandService.dart';
import '../Services/DescriptionService.dart';
import '../Services/FloorService.dart';
import '../Services/SectionTypeService.dart';
import '../Utility/CustomWidgetBuilder.dart';
import '../language.dart';
import '../model/brand.dart';
import '../model/description.dart';
import 'home_page.dart';

class AssetsDetails extends StatefulWidget {
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
  final brandService = BrandService();
  final descriptionService = DescriptionService();

  final _barcodeController = TextEditingController();

  List<Asset> assets = [];
  List<Asset> allAssets = [];
  List<SectionType> allSections = [];
  List<SectionType> sectionsPerFloor = [];
  List<Department> allDepartments = [];
  List<Floor> allFloors = [];
  List<Description> allDescriptions = [];
  List<Brand> allBrands = [];
  String? _section;
  String? _department;
  String? _floor;
  String? _brand;
  String? _description;
  String? defaultImage;

  TextEditingController serialController = TextEditingController();
  String? imagePath;
  bool error = false;

  final GlobalKey<FormState> _formKey = GlobalKey();

  final lang = Language();

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
    return Directionality(
      textDirection: Language.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
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
                            color: Colors.white,),
                      ),
                      SizedBox(
                        height: Language.isEn ? dSize.height * 0.03 : dSize.height * 0.012,
                      ),
                      Row(
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 25),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFA227),
                                borderRadius: Language.isEn ? const BorderRadius.only(
                                    topRight: Radius.circular(12),
                                    bottomRight: Radius.circular(12)) : const BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    bottomLeft: Radius.circular(12)),
                              ),
                              child: Text.rich(
                                TextSpan(
                                    style: TextStyle(
                                      fontSize: dSize.height * 0.028,
                                      color: Colors.white,
                                    ),
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: lang.getTxt('verification_header_title'),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: lang.getTxt('verification_header_subTitle'),
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
                              '${lang.getTxt('assets_total')} : ' + allAssets.length.toString(),
                              style: TextStyle(
                                  color: const Color(0xFF0F6671),
                                  fontSize: dSize.width * 0.031),
                            ),
                            Text(
                              '${lang.getTxt('remain')} : ' +
                                  allAssets
                                      .where((element) =>
                                          element.isVerified == 0 ||
                                          element.isVerified == null)
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: dSize.height * 0.016),
                  height: dSize.height < 600
                      ? dSize.height * 0.55
                      : dSize.height * 0.49,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            InkWell(
                                // onTap: ()=>getItemData(_barcodeController.text),
                                child: Container(
                                  child: CustomWidgetBuilder.buildText(lang.getTxt('barcode'), dSize, color: Colors.white),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF00B0BD),
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                )),
                            const Spacer(),
                            InkWell(
                                    onTap: () => scanBarcodeNormal(),
                                    // onTap: () => getItemData('090203010104735'),
                                    child: Container(
                                      padding: EdgeInsets.all(7),
                                      width: dSize.width * 0.5,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xFF00B0BD),
                                            width: 2.0),
                                      ),
                                      child: Text(lang.getTxt('tab_barcode'), textAlign: TextAlign.center,),
                                    ),
                                  ),
                            // Container(
                            //   width: dSize.width * 0.5,
                            //   child: TextFormField(
                            //     controller: _barcodeController,
                            //     style: TextStyle(fontSize: dSize.height <= 500 ? 10 : dSize.height * 0.02),
                            //     decoration: InputDecoration(
                            //       enabledBorder: const OutlineInputBorder(
                            //           borderSide: BorderSide(
                            //               color: Color(0xFF00B0BD), width: 2)),
                            //       focusedBorder: const OutlineInputBorder(
                            //           borderSide: BorderSide(
                            //               color: Color(0xFF00B0BD), width: 2)),
                            //       contentPadding: EdgeInsets.all(
                            //           dSize.height <= 600
                            //               ? dSize.height * 0.015
                            //               : 6),
                            //       isDense: true,
                            //       border: InputBorder.none,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        if (error)
                          Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              lang.getTxt('no_item_found'),
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
                                    lang.getTxt('asset_details'), dSize),
                              ],
                            ),
                            Container(
                                width: 200,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xFF00B0BD), width: 2.0),
                                ),
                                height: 100,
                                child: asset == null || imagePath == null
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomWidgetBuilder.buildText(asset?.itemName?? "", dSize),
                          ],
                        ),
                        Row(
                          children: [
                            CustomWidgetBuilder.buildText(lang.getTxt('serial'), dSize),
                            const Spacer(),
                            Container(
                              width: dSize.width * 0.5,
                              child: TextFormField(
                                controller: serialController,
                                style: TextStyle(
                                    fontSize: dSize.height <= 500
                                        ? 10
                                        : dSize.height * 0.02),
                                enabled: asset != null ? true : false,
                                decoration: InputDecoration(
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFF00B0BD), width: 2)),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFF00B0BD), width: 2)),
                                  disabledBorder: const OutlineInputBorder(
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
                            CustomWidgetBuilder.buildText(lang.getTxt('brand'), dSize),
                            const Spacer(),
                            Container(
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Color(0xFF00B0BD), width: 2))),
                              width: dSize.width * 0.5,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _brand,
                                  iconSize: 20,
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Color(0xFF00B0BD),
                                  ),
                                  isDense: true,
                                  isExpanded: true,
                                  items: allBrands
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
                                      _brand = val;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CustomWidgetBuilder.buildText(lang.getTxt('floor'), dSize),
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
                                    getSectionsByFloor();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CustomWidgetBuilder.buildText(lang.getTxt('section'), dSize),
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
                                  items: sectionsPerFloor
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              child: Text(lang.getTxt('done'),),
                              onPressed: (asset == null || _floor == null || _section == null) ? null : () =>  updateItem(),
                              style: ElevatedButton.styleFrom(
                                  primary: const Color(0xFF00B0BD),
                                  minimumSize: const Size(5, 30)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        height: dSize.height < 600
                            ? dSize.height * 0.2
                            : dSize.height * 0.21,
                        child: ClipRRect(
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
                    ],
                  ),
                ),
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
                Footer()
              ],
            ),
          ),
        ),
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomePage()));
          },
          backgroundColor: Colors.orangeAccent,
          child: Icon(
            Icons.home,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  List<TableRow> _getListings() {
    List<TableRow> listings = <TableRow>[];
    int i = 0;
    listings.add(
      CustomWidgetBuilder.buildRow([lang.getTxt('no'), lang.getTxt('desc_table'), lang.getTxt('photo')], isHeader: true),
    );
    for (i = 0; i < assets.length; i++) {
      listings.add(
        CustomWidgetBuilder.buildRow(
          [
            i + 1,
            assets[i].description,
            assets[i] == null || assets[i]!.image == null
                ? Image.asset(
              'assets/icons/img.png',
              fit: BoxFit.cover,
              width: 300,
            )
                : Image.memory(
              base64Decode(assets[i].image!),
              width: 300,
              height: 100,
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
    allBrands = await brandService.retrieve();
    allDescriptions = await descriptionService.retrieve();
    setState(() {
      if (assets.isNotEmpty) {
        error = false;
        asset = assets[0];
        imagePath = asset?.itemImage ?? asset?.image;
        try {
          if (asset?.departmentId != null) {
            _department = allDepartments
                .firstWhere((element) => element.id == asset?.departmentId)
                .name;
          }
          if (allAssets[0].floorId != null) {
            _floor = allFloors
                .firstWhere((element) => element.id == asset?.floorId)
                .name;
            getSectionsByFloor();
          }
          if (asset?.brandId != null) {
            _brand = allBrands
                .firstWhere((element) => element.id == asset?.brandId)
                .name;
          }
        } catch (e) {
          print(e);
          CustomWidgetBuilder.showMessageDialog(context, e.toString(), false);
        }
      } else {
        error = true;
        resetForm();
      }
    });
  }

  getSectionsByFloor(){
      final floorId = allFloors
          .firstWhere((element) => element.name == _floor)
          .id;
print('floorId ${floorId}');
      sectionsPerFloor = allSections.where((sec) => sec.floorId == floorId).toList();
      if(sectionsPerFloor.isEmpty) return;
      for(int i = 0; i<sectionsPerFloor.length; i++) {
        if(sectionsPerFloor[i].id == asset?.sectionId) {
          setState(() {
            _section = sectionsPerFloor[i].name;
          });
        }
      }
      setState(() {});
  }

  getItems() async {
    assets = await assetService.getAllVerifiedItems();
    allAssets = await assetService.retrieve();
    rootBundle.load('assets/icons/img.png').then((value) {
      defaultImage = base64.encode(Uint8List.view(value.buffer));
    });
    print(defaultImage);
    setState(() {});
  }

  updateItem() {
    if (asset != null) {
      editAsset();
      asset!.isVerified = 1;
      assetService.update(asset!);
      asset = null;
      getItems();
    }
  }

  editAsset() async{
    if (imagePath != null) {
      asset?.image = imagePath!;
    } else if(imagePath == null){
asset?.image = defaultImage;
      print('asset3: $asset');
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
      getSectionsByFloor();
    }
    if (_brand != null) {
      asset?.brandId =
          allBrands.firstWhere((element) => element.name == _brand).id;
    }
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(lang.getTxt('update_asset')), duration: Duration(milliseconds: 1000),));
    print(asset);
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

  resetForm(){
    setState(() {
      asset = null;
      _section = null;
      _floor = null;
      sectionsPerFloor = [];
      allFloors = [];
    });
  }

  getDefultImage() async{
    print('asset1: $asset');
    print('asset1: $asset');
    print('asset2: $asset');

  }
}
