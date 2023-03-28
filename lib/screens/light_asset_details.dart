import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:dgi/Services/AssetService.dart';
import 'package:dgi/Services/DepartmentService.dart';
import 'package:dgi/Utility/footer.dart';
import 'package:dgi/model/asset.dart';
import 'package:dgi/model/assetBarcode.dart';
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
import '../Services/lightVerificaion_service.dart';
import '../Utility/CustomWidgetBuilder.dart';
import '../language.dart';
import '../model/brand.dart';
import '../model/description.dart';
import 'home_page.dart';

class LightAssetsDetails extends StatefulWidget {
  LightAssetsDetails({Key? key}) : super(key: key);

  @override
  State<LightAssetsDetails> createState() => _LightAssetsDetailsState();
}

class _LightAssetsDetailsState extends State<LightAssetsDetails> {
  Asset? asset;
  AssetBarcode? assetBarcode;
  final assetService = AssetService();
  final sectionTypeService = SectionTypeService();
  final departmentService = DepartmentService();
  final floorService = FloorService();
  final brandService = BrandService();
  final descriptionService = DescriptionService();
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
  bool _isLoading = false;

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
    return _isLoading ? CustomWidgetBuilder.buildSpanner() : Scaffold(
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
                    ],
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: dSize.height * 0.016),
                    // height: dSize.height < 600
                    //     ? dSize.height * 0.65
                    //     : dSize.height * 0.59,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                CustomWidgetBuilder.buildText(lang.getTxt('barcode'), dSize),
                                const Spacer(),
                                InkWell(
                                  // onTap: () => scanBarcodeNormal(),
                                  onTap: ()=>getItemData('090101010100001'),
                                  child: Container(
                                    padding: EdgeInsets.all(dSize.height * 0.007),
                                    width: dSize.width * 0.5,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xFF00B0BD), width: 2.0),
                                    ),
                                    child: Text(
                                      lang.getTxt('tab_barcode'),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (error)
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Text(
                                  lang.getTxt('no_item_found'),
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          Expanded(
                            flex: 7,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CustomWidgetBuilder.buildText(
                                        lang.getTxt('asset_details'), dSize),
                                  ],
                                ),
                                Expanded(
                                  child: Container(
                                      width: 300,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xFF00B0BD), width: 2.0),
                                      ),
                                      height: 300,
                                      child: assetBarcode == null || assetBarcode!.imageInBase64 == null
                                          ? Image.asset(
                                        'assets/icons/img.png',
                                        fit: BoxFit.cover,
                                        width: 300,
                                      )
                                          : Image.memory(
                                            base64Decode(imagePath!),
                                            width: 300,
                                            height: 100,
                                          )),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomWidgetBuilder.buildText(asset?.itemName?? "", dSize),
                            ],
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomWidgetBuilder.buildTextFormField(dSize, 'SECTION',
                                    assetBarcode?.sectionName, false),
                                CustomWidgetBuilder.buildTextFormField(dSize, 'FLOOR',
                                    assetBarcode?.floorName, false),
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
                Footer()
              ],
            ),
          ),
        ),
      ),
    );
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
    try{
      setState(() => _isLoading = true);
    final lightVerificationService = LightVerificationService();
    assetBarcode = await lightVerificationService.getAssetByBarcode(barcodeScanRes);
    if(assetBarcode != null){
      imagePath = assetBarcode?.imageInBase64;
    }
      setState(() => _isLoading = false);
    }catch(e){
      if(!mounted) return;
      CustomWidgetBuilder.showMessageDialog(context, e.toString(), false);
      setState(() => _isLoading = false);
    }
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
