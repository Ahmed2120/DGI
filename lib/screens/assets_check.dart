import 'dart:convert';

import 'package:dgi/Services/AssetService.dart';
import 'package:dgi/Utility/footer.dart';
import 'package:dgi/model/asset.dart';
import 'package:dgi/model/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../Utility/CustomWidgetBuilder.dart';

class AssetsCheck extends StatefulWidget {
  Category category;
  AssetsCheck({Key? key,required this.category}) : super(key: key);

  @override
  State<AssetsCheck> createState() => _AssetsCheckState();
}

class _AssetsCheckState extends State<AssetsCheck> {
  Asset? asset;
  final assetService = AssetService();
  List<Asset> assets = [];
  List<Asset> allAssets = [];
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
    print('dffd: ${dSize.height * 0.033}');
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          height: dSize.height - 24,
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
                                  ),
                                  children: const <InlineSpan>[
                                    TextSpan(
                                      text: 'ASSETS ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: 'Counter',
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
                      decoration: BoxDecoration(color: Colors.white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'ASSETS TOTAL : '+allAssets.length.toString(),
                            style: TextStyle(
                                color: Color(0xFF0F6671),
                                fontSize: dSize.width * 0.031),
                          ),
                          Text(
                            'REMAIN : '+allAssets.where((element) => element.isCounted==0).toList().length.toString(),
                            style: TextStyle(
                                color: Color(0xFF0F6671),
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
                            buildText('BARCODE', dSize),
                            const Spacer(),
                            InkWell(
                                    onTap: () => scanBarcodeNormal(),
                                    child: Container(
                                      padding: EdgeInsets.all(7),
                                      width: dSize.width * 0.5,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xFF00B0BD),
                                            width: 2.0),
                                      ),
                                      child: Text('Tab to scan barcode', textAlign: TextAlign.center,),
                                    ),
                                  ),
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
                                child: asset == null
                                    ? Image.asset(
                                        'assets/icons/img.png',
                                        fit: BoxFit.cover,
                                        width: dSize.width * 0.577,
                                      )
                                    : Image.memory(
                                        base64Decode(asset!.image),
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
                            'ASSET DESC',
                            asset == null ? "" : asset!.description),
                        SizedBox(
                          height: dSize.height * 0.01,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              SizedBox(
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
                              ),
                              Padding(
                                padding: EdgeInsets.all(dSize.height * 0.007),
                                child: Text(
                                  'CLICK THE ASSETS FOR MORE DETAILS',
                                  style: TextStyle(
                                      color: Color(0xFF00B0BD),
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
                                      buildText('TOTAL ASSETS', dSize),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      buildText(allAssets.where((element) => element.correct>0).toList().length.toString(), dSize),
                                      checkContainer(dSize, true),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      buildText(allAssets.where((element) => element.correct==0&&element.isCounted>0).toList().length.toString(), dSize),
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
              const Footer()
            ],
          ),
        ),
      ),
    ));
  }

  Container checkContainer(Size dSize, bool isCorrect) {
    Icon icon = isCorrect ? const Icon(Icons.check) : const Icon(Icons.close);
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: dSize.height * 0.0001, horizontal: dSize.width * 0.009),
      decoration: BoxDecoration(
          color: isCorrect ? Color(0xFF00B0BD) : Color(0xFFFFA227),
          borderRadius: BorderRadius.circular(15)),
      child: Icon(
        icon.icon,
        color: Colors.white,
        size: 15,
      ),
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
    setState(() {
      if (assets.isNotEmpty) {
        asset = assets[0];
      }
    });
  }

  TableRow buildRow(List<dynamic> cells, {bool isHeader = false}) => TableRow(
        decoration: BoxDecoration(
            color: isHeader ? Color(0xFFFFA227) : Colors.grey[200],
            borderRadius: isHeader
                ? BorderRadius.circular(10)
                : BorderRadius.circular(0)),
        children: cells
            .map((cell) => Padding(
                  padding: EdgeInsets.all(8.0),
                  child: cell.runtimeType == String
                      ? Text(
                          cell,
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

  List<TableRow> _getListings(Size dSize) {
    List<TableRow> listings = <TableRow>[];
    int i = 0;
      listings.add(
        CustomWidgetBuilder.buildRow(['No', 'ASSETS', 'DESC', 'CHECK'], isHeader: true),
      );
    for (i = 0; i < assets.length; i++) {
      listings.add(
        CustomWidgetBuilder.buildRow(
          [
            i + 1,
            widget.category.name,
            assets[i].description,
            checkContainer(dSize, assets[i].correct>0?true:false),
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
      asset!.correct = correct?1:0;
      asset!.isCounted=1;
      assetService.update(asset!);
      asset = null;
      getItems();
    }
  }
}
