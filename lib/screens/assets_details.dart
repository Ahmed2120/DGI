import 'dart:convert';

import 'package:dgi/Services/AssetService.dart';
import 'package:dgi/Utility/footer.dart';
import 'package:dgi/model/asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../Utility/CustomWidgetBuilder.dart';

class AssetsDetails extends StatefulWidget {
  const AssetsDetails({Key? key}) : super(key: key);

  @override
  State<AssetsDetails> createState() => _AssetsDetailsState();
}

class _AssetsDetailsState extends State<AssetsDetails> {
  Asset? asset;
  final assetService = AssetService();
  List<Asset> assets =[];

  final GlobalKey<FormState> _formKey = GlobalKey();
  Image image = Image.asset('assets/icons/0-16.jpg', height: 30,);

  @override
  Widget build(BuildContext context) {
    final dSize = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          height: dSize.height - dSize.height * 0.035,
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
                      padding: EdgeInsets.symmetric(vertical: 6),
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'ASSETS TOTAL : 1000235',
                            style: TextStyle(
                                color: Color(0xFF0F6671),
                                fontSize: dSize.width * 0.031),
                          ),
                          Text(
                            'REMAIN : 1000235',
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
                  height: dSize.height * 0.635,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CustomWidgetBuilder.buildText('BARCODE', dSize),
                            const Spacer(),
                            InkWell(
                              onTap: ()=>scanBarcodeNormal(),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                width: dSize.width * 0.5,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xFF00B0BD), width: 2.0),
                                ),
                                child: Text('Tab to scan barcode', textAlign: TextAlign.center,),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: dSize.height * 0.01,
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomWidgetBuilder.buildText('ASSET DETAILS', dSize),
                              ],
                            ),
                            SizedBox(
                              height: dSize.height * 0.01,
                            ),
                            Container(
                              width: 200,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xFF00B0BD), width: 2.0),
                                ),
                                height: 100,
                                child:asset == null? Image.asset(
                                  'assets/icons/img.png',
                                  fit: BoxFit.cover,
                                  width: 300,
                                ):Image.memory(
                                  base64Decode(asset!.image),
                                  width: 300,
                                  height: 100,
                                )),
                          ],
                        ),
                        SizedBox(
                          height: dSize.height * 0.01,
                        ),
                        CustomWidgetBuilder.buildTextFormField(dSize, 'ASSET DESC',asset==null?"": asset!.description),
                        SizedBox(
                          height: dSize.height * 0.01,
                        ),
                        CustomWidgetBuilder.buildTextFormField(dSize, 'SERIAL NO',asset==null?"": asset!.serialnumber),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              child: const Text('DONE'),
                              onPressed: () => addAssets(),
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF00B0BD),
                                  ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                height: dSize.height * 0.187,
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

  List<TableRow> _getListings() {
    List<TableRow> listings = <TableRow>[];
    int i = 0;
    listings.add(
      CustomWidgetBuilder.buildRow(['No', 'ASSETS', 'DESC', 'PHOTO'], isHeader: true),
    );
    for (i = 0; i < assets.length; i++) {
      listings.add(
        CustomWidgetBuilder.buildRow(
          [
            (i + 1).toString(),
            'ASSETS',
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

  void getItemData(String barcodeScanRes) async{
    List<Asset> assets = await assetService.select(barcodeScanRes);
    setState(() {
      if(assets.isNotEmpty){
        asset=assets[0];
      }
    });
  }

  addAssets() {
    assets.add(asset!);
    asset = null;
    setState(() {

    });
  }

}
