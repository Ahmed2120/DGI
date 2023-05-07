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
import 'package:dgi/screens/assets_check.dart';
import 'package:dgi/screens/take_picture_page.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../../Services/SectionTypeService.dart';
import '../../Services/assetCheckService.dart';
import '../../Utility/CustomWidgetBuilder.dart';
import '../../language.dart';
import '../../model/assetCheck.dart';

class ScanItemScreen extends StatefulWidget {
  ScanItemScreen(this.barcode, {Key? key}) : super(key: key);

  String barcode;
  @override
  State<ScanItemScreen> createState() => _ScanItemScreenState();
}

class _ScanItemScreenState extends State<ScanItemScreen> {

  final lang = Language();

  String? imagePath;
  bool error = false;

  final sectionTypeService = SectionTypeService();
  final assetCheckService = AssetCheckService();
  final assetService = AssetService();

  List<SectionType> sections = [];
  String? section;
  String? _assetSection;
  AssetCheck? _assetsCheck;
  bool _isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey();
  final _barcodeController = TextEditingController();

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
                                      children: const <InlineSpan>[
                                        TextSpan(
                                          text: 'Update',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text: 'Asset',
                                        ),
                                      ]),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: dSize.height * 0.011,
                        ),
                        // Container(
                        //   padding:
                        //   EdgeInsets.symmetric(vertical: dSize.height * 0.007),
                        //   width: double.infinity,
                        //   decoration: const BoxDecoration(color: Colors.white),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //     children: [
                        //       Text(
                        //         // '${lang.getTxt('assets_total')} : ' + allAssets.length.toString(),
                        //         '${lang.getTxt('assets_total')} : ' + '2',
                        //         style: TextStyle(
                        //             color: const Color(0xFF0F6671),
                        //             fontSize: dSize.width * 0.031),
                        //       ),
                        //       Text(
                        //         '${lang.getTxt('remain')} : ' +
                        //             allAssets
                        //                 .where((element) =>
                        //             element.isVerified == 0 ||
                        //                 element.isVerified == null)
                        //                 .toList()
                        //                 .length
                        //                 .toString(),
                        //         style: TextStyle(
                        //             color: const Color(0xFF0F6671),
                        //             fontSize: dSize.width * 0.037),
                        //       ),
                        //     ],
                        //   ),
                        // )
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
                              CustomWidgetBuilder.buildText(lang.getTxt('barcode'), dSize),
                              const Spacer(),
                              InkWell(
                                onTap: () => scanBarcodeNormal(),
                                // onTap: ()=>getItemData('090104010100003'),
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
                          CustomWidgetBuilder.buildTextFormField(
                              dSize,
                              lang.getTxt('section'),
                              _assetsCheck?.sectionName?? "",false),
                          const SizedBox(height: 20,),
                          Row(
                            children: [
                              CustomWidgetBuilder.buildText('Change Section', dSize),
                              const Spacer(),
                              Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(color: Color(0xFF00B0BD), width: 2))),
                                width: dSize.width * 0.5,
                                child: DropdownSearch<String>(
                                  popupProps: const PopupProps.menu(
                                      showSelectedItems: true,
                                      showSearchBox: true
                                  ),
                                  items: sections.map((e) => e.name).toSet().toList(),
                                  dropdownDecoratorProps: const DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                        suffixIconColor: Color(0xFF00B0BD)
                                    ),
                                  ),
                                  onChanged: changeSection,
                                  selectedItem: section,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  _isLoading ? const CircularProgressIndicator() : ElevatedButton(
                    child: Text(
                      'Update',
                      style: TextStyle(
                          fontSize: dSize.height <= 500
                              ? dSize.height * 0.027
                              : 13.75),
                    ),
                    onPressed: section == null ? null : () => {update()},
                    style: ElevatedButton.styleFrom(
                        primary: const Color(0xFFFFA227),
                        textStyle: const TextStyle(fontSize: 20),
                        padding: const EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        minimumSize: Size(dSize.width * 0.4, 34)),
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
    _assetsCheck = await assetCheckService.retrieveByBarcode(barcodeScanRes);
    print(_assetsCheck!.sectionId);
    print(sections);
    if(_assetsCheck == null) {

      error = true;
      errorScanDialog(context, 'No item Dialog', false);
      print('errorr');
    }

    setState(() {});
  }

  getItems() async {

    sections = await sectionTypeService.retrieve();
    setState(() {});
  }

  changeSection(value) async {
    section = value;
    setState(() {});
  }

  update()async{
    setState(() => _isLoading = true);

    _assetsCheck!.sectionId = sections.firstWhere((element) => section == element.name).id!;
    _assetsCheck!.isChecked = 1;
    await assetCheckService.update(_assetsCheck!);

    _assetsCheck = null;
    section = null;
    setState(() => _isLoading = false);
  }

  void errorScanDialog(BuildContext context,String message,bool dismissible,
      {String title = 'An error Occurred'}) {
    final lang = Language();
    showDialog(
        context: context,
        barrierDismissible: dismissible,
        builder: (ctx) => Directionality(
          textDirection: Language.isEn ? TextDirection.ltr : TextDirection.rtl,
          child: AlertDialog(
            title: Text(lang.getTxt('error_occurred'),),
            content: Text(message),
            actions: [
              TextButton(
                child: Text(lang.getTxt('ok'),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ));
  }
}
