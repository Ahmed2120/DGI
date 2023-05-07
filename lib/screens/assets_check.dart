import 'dart:convert';

import 'package:dgi/Services/AssetService.dart';
import 'package:dgi/Utility/footer.dart';
import 'package:dgi/model/asset.dart';
import 'package:dgi/model/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../Services/SectionTypeService.dart';
import '../Utility/CustomWidgetBuilder.dart';
import '../language.dart';
import '../model/sectionType.dart';
import 'home_page.dart';

class AssetsCheck extends StatefulWidget {
  AssetsCheck({Key? key}) : super(key: key);

  @override
  State<AssetsCheck> createState() => _AssetsCheckState();
}

class _AssetsCheckState extends State<AssetsCheck> {
  Asset? asset;
  final assetService = AssetService();
  final sectionTypeService = SectionTypeService();

  List<Asset> assets = [];
  List<Asset> allAssets = [];
  List<SectionType> allSections = [];
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _barcodeController = TextEditingController();

  String? imagePath;
  String? _section;
  bool error = false;

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
    print('dffd: ${dSize.height * 0.033}');
    return Directionality(
      textDirection: Language.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
          body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
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
                              padding: EdgeInsets.symmetric(
                                  vertical: dSize.height * 0.004, horizontal: 25),
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
                                        text: lang.getTxt('counter_header_title'),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: lang.getTxt('counter_header_subTitle'),
                                      ),
                                    ]),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: dSize.height * 0.011,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: dSize.height * 0.007),
                        width: double.infinity,
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              '${lang.getTxt('assets_total')} : '+allAssets.length.toString(),
                              style: TextStyle(
                                  color: const Color(0xFF0F6671),
                                  fontSize: dSize.width * 0.031),
                            ),
                            Text(
                              '${lang.getTxt('remain')} : '+allAssets.where((element) => element.isCounted==0 || element.isCounted==null).toList().length.toString(),
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
                    height: dSize.height * 0.67,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                // onTap: ()=>getItemData(_barcodeController.text),
                                  child: Container(
                                  child: buildText(lang.getTxt('barcode'), dSize, color: Colors.white),
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
                              SizedBox(
                                width: dSize.width * 0.03,
                              ),
                              Column(
                                children: [
                                  InkWell(
                                      onTap: () => updateItem(false),
                                      child: checkContainer(dSize, false)),
                                  SizedBox(
                                    height: dSize.height * 0.01,
                                  ),
                                  InkWell(
                                      onTap: () => updateItem(true),
                                      child: checkContainer(dSize, true)),
                                ],
                              ),
                            ],
                          ),
                          if (error)
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                lang.getTxt('no_item_found'),
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          SizedBox(
                            height: dSize.height * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: dSize.width * 0.577,
                                  // alignment: Alignment.centerRight,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xFF00B0BD),
                                        width: 2.0),
                                  ),
                                  height: 100,
                                  child: asset == null || imagePath == null
                                      ? Image.asset(
                                          'assets/icons/img.png',
                                          fit: BoxFit.cover,
                                          width: dSize.width * 0.577,
                                        )
                                      : Image.memory(
                                          base64Decode(imagePath!),
                                    width: 300,
                                    height: 100,
                                        )),
                            ],
                          ),
                          SizedBox(
                            height: dSize.height * 0.01,
                          ),
                          CustomWidgetBuilder.buildTextFormField(
                              dSize,
                              lang.getTxt('asset_desc'),
                              asset?.itemName?? "",false),
                          SizedBox(
                            height: dSize.height * 0.01,
                          ),
                          CustomWidgetBuilder.buildTextFormField(
                              dSize,
                              lang.getTxt('section'),
                              _section?? "",false),
                          SizedBox(
                            height: dSize.height * 0.01,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(child: SizedBox(
                                  height: dSize.height * 0.26,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: ListView(
                                      children: [
                                        Table(
                                          border: TableBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          children: _getListings(dSize),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                                Padding(
                                  padding: EdgeInsets.all(dSize.height * 0.007),
                                  child: Text(
                                    'CLICK THE ASSETS FOR MORE DETAILS',
                                    style: TextStyle(
                                        color: const Color(0xFF00B0BD),
                                        fontSize: dSize.width * 0.03),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        buildText(allAssets.length.toString(), dSize),
                                        buildText(lang.getTxt('assets_total'), dSize),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        buildText(allAssets.where((element) => element.isVerified==1).toList().length.toString(), dSize),
                                        checkContainer(dSize, true),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        buildText(allAssets.where((element) => element.isVerified==0).toList().length.toString(), dSize),
                                        checkContainer(dSize, false),
                                      ],
                                    ),
                                  ],
                                )
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
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
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
                .push(MaterialPageRoute(builder: (context) => const HomePage()));
          },
          backgroundColor: Colors.orangeAccent,
          child: const Icon(
            Icons.home,
            color: Colors.white,
          ),
        ),),
    );
  }

  Container checkContainer(Size dSize, bool isCorrect) {
    Icon icon = isCorrect ? const Icon(Icons.check) : const Icon(Icons.close);
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: dSize.height * 0.0001, horizontal: dSize.width * 0.009),
      decoration: BoxDecoration(
          color: isCorrect ? const Color(0xFF00B0BD) : const Color(0xFFFFA227),
          borderRadius: BorderRadius.circular(15)),
      child: Icon(
        icon.icon,
        color: Colors.white,
        size: 15,
      ),
    );
  }

  Text buildText(String title, dSize, {Color? color}) {
    return Text(
      title,
      style: TextStyle(
          fontSize: dSize.width * 0.03,
          color: color ?? const Color(0xFF0F6671),
          fontWeight: FontWeight.bold),
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
    List<Asset> assets = await assetService.select(barcodeScanRes);
    allSections = await sectionTypeService.retrieve();
    setState(() {
      if (assets.isNotEmpty) {
        error = false;
        asset = assets[0];
        imagePath = asset?.itemImage ?? asset?.image;
        if (allAssets[0].sectionId != null) {
          _section = allSections
              .firstWhere((element) => element.id == asset?.sectionId)
              .name;
        }
      }else {
        error = true;
        CustomWidgetBuilder.errorScanDialog(context, 'no item found', false, barcodeScanRes);
      }
    });
  }

  TableRow buildRow(List<dynamic> cells, {bool isHeader = false}) => TableRow(
        decoration: BoxDecoration(
            color: isHeader ? const Color(0xFFFFA227) : Colors.grey[200],
            borderRadius: isHeader
                ? BorderRadius.circular(10)
                : BorderRadius.circular(0)),
        children: cells
            .map((cell) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: cell.runtimeType == String
                      ? Text(
                          cell,
                          style: TextStyle(
                              color:
                                  isHeader ? Colors.white : const Color(0xFF0F6671),
                              fontWeight: isHeader
                                  ? FontWeight.bold
                                  : FontWeight.normal),
                        )
                      : cell,
                ))
            .toList(),
      );

  List<TableRow> _getListings(Size dSize) {
    List<TableRow> listings = <TableRow>[];
    int i = 0;
      listings.add(
        CustomWidgetBuilder.buildRow([lang.getTxt('no'), lang.getTxt('desc_table'),lang.getTxt('check_table')], isHeader: true),
      );
    for (i = 0; i < assets.length; i++) {
      listings.add(
        CustomWidgetBuilder.buildRow(
          [
            i + 1,
            assets[i].itemName,
            checkContainer(dSize, assets[i].isVerified==1?true:false),
          ],
        ),
      );
    }
    return listings;
  }

  getItems() async {
    assets = await assetService.getAllCountedItems();
    allAssets = await assetService.retrieve();
    setState(() {});
  }

  updateItem(bool correct) {
    if(asset != null){
      asset!.isVerified = correct?1:0;
      asset!.isCounted=1;
      assetService.update(asset!);
      asset = null;
      _section = null;
      getItems();
    }
  }
}
