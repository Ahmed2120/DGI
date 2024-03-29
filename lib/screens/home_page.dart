import 'package:dgi/Services/ServerService.dart';
import 'package:dgi/Services/SettingService.dart';
import 'package:dgi/Services/TransactionService.dart';
import 'package:dgi/Utility/CustomWidgetBuilder.dart';
import 'package:dgi/enum.dart';
import 'package:dgi/language.dart';
import 'package:dgi/model/settings.dart';
import 'package:dgi/model/transaction.dart';
import 'package:dgi/screens/about.dart';
import 'package:dgi/screens/administrator_screen.dart';
import 'package:dgi/screens/assets_verification_screen.dart';
import 'package:dgi/screens/item_capture_screen.dart';
import 'package:dgi/screens/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Services/ExcelService.dart';
import 'assets_counter_screen.dart';
import 'item_capture_newPage.dart';
import 'item_counter_newPage.dart';
import 'item_verification_newPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TransactionType transactionType = TransactionType.none;
  final transactionService = TransactionService();
  final serverService = ServerService();
  final excelService = ExcelService();
  final settingService = SettingService();
  bool loader = false;

  final lang = Language();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTransaction();
  }

  getTransaction() async {
    List<TransactionLookUp> transactions = await transactionService.retrieve();
    setState(() {
      if (transactions.isNotEmpty) {
        transactionType =
            TransactionType.values[transactions[0].transactionType];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final dsize = MediaQuery.of(context).size;
    return Directionality(
      textDirection: Language.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: !loader
            ? Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Color(0xFF26BB9B),
                              Color(0xFF00B0BD),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            stops: [0, 1])),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: dsize.height * 0.041, left: 30, right: 30),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            lang.getTxt('home'),
                            style: const TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: dsize.height * 0.015,
                                bottom: dsize.height * 0.013),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: const Color(0xFFFFA227),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/icons/0-22.png',
                                  width: dsize.width <= 551
                                      ? dsize.width * 0.3
                                      : 160,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: dsize.height * 0.008),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFFFFFFF)
                                          .withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    'FIXED ASSET RACKING Software v 1.0.0',
                                    style: TextStyle(
                                      fontSize: dsize.width <= 551
                                          ? dsize.width * 0.034
                                          : 19,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(dsize.height * 0.0152),
                            height: dsize.height * 0.647,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: const Color(0xFFFFFFFF).withOpacity(0.3),
                                borderRadius: BorderRadius.circular(40)),
                            child: GridView.count(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              padding: EdgeInsets.symmetric(
                                  vertical: dsize.height * 0.0092,
                                  horizontal: dsize.width * 0.01),
                              children: [
                                InkWell(
                                  child:
                                      buildColumn(lang.getTxt('item_capture'), dsize, '1-15'),
                                  onTap: () {
                                    if (transactionType ==
                                        TransactionType.capture) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ItemNewCapture()));
                                    } else {
                                      CustomWidgetBuilder.showMessageDialog(
                                          context,
                                          lang.getTxt('open_page_error'),
                                          true);
                                    }
                                  },
                                ),
                                InkWell(
                                  child: buildColumn(
                                      lang.getTxt('asset_verification'), dsize, '1-12'),
                                  onTap: () {
                                    if (transactionType ==
                                        TransactionType.verification) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ItemNewVerification()));
                                    } else {
                                      CustomWidgetBuilder.showMessageDialog(
                                          context,
                                          lang.getTxt('open_page_error'),
                                          true);
                                    }
                                  },
                                ),
                                InkWell(
                                  child:
                                      buildColumn(lang.getTxt('asset_counter'), dsize, '1-13'),
                                  onTap: () {
                                    if (transactionType ==
                                        TransactionType.inventory) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ItemNewCounter()));
                                    } else {
                                      CustomWidgetBuilder.showMessageDialog(
                                          context,
                                          lang.getTxt('open_page_error'),
                                          true);
                                    }
                                  },
                                ),
                                InkWell(
                                  child: buildColumn(lang.getTxt('about'), dsize, '0-19'),
                                  onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => AboutUs())),
                                ),
                                InkWell(
                                  child: buildColumn(lang.getTxt('settings'), dsize, '0-20'),
                                  onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => const Settings())).then((value) => setState(() {})),
                                ),
                                InkWell(
                                    child: buildColumn(lang.getTxt('upload'), dsize, ''),
                                    onTap: () => uploadData()),
                                InkWell(
                                    child: buildColumn(lang.getTxt('exel'), dsize, 'excel'),
                                    onTap: () => exportExel()),
                                InkWell(
                                    child: buildColumn('Clear Data', dsize, 'clear-data'),
                                    onTap: () => clearData()),
                              ],
                              crossAxisCount: 2,
                              childAspectRatio: (dsize.width * 0.009) /
                                  (dsize.height * 0.00455),
                              crossAxisSpacing: dsize.width * 0.009,
                              mainAxisSpacing: dsize.height * 0.0227,
                              // ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: dsize.height * 0.0035),
                            child: FittedBox(
                              child: Text('SAGECO Dashboard',
                                  style: TextStyle(
                                      color: Color(0xFF0F6671),
                                      fontSize: dsize.height * 0.028,)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : CustomWidgetBuilder.buildSpanner(),
      ),
    );
  }

  uploadData() async {
    setState(() {
      loader = true;
    });
    try {
      if(transactionType == TransactionType.verification){
        await serverService.uploadAssetVerification();
      }else if(transactionType == TransactionType.capture){
        await serverService.uploadData();
      }else {
        await serverService.uploadAssetInventory();
        await serverService.uploadAssetCheck();
      }
      await serverService.clearData();
      List<Setting> settings = await settingService.retrieve();
      String pdaNo = "";
      if (settings.isNotEmpty) {
        pdaNo = settings[0].pdaNo;
      }
      setState(() {
        loader = false;
      });
      showSuccessDialog(lang.getTxt('successful_upload'), content: lang.getTxt('login_again'));
    } catch (e) {
      setState(() {
        loader = false;
      });
      CustomWidgetBuilder.showMessageDialog(context, e.toString(), true);
    }
  }

  clearData() async {
    setState(() {
      loader = true;
    });
    try {

      await serverService.clearData();

      setState(() {
        loader = false;
      });
      showSuccessDialog('Clear Data Done successfully');
    } catch (e) {
      setState(() {
        loader = false;
      });
      CustomWidgetBuilder.showMessageDialog(context, e.toString(), true);
    }
  }

  exportExel() async {
    setState(() {
      loader = true;
    });
    try {
      if(transactionType == TransactionType.verification){
        await excelService.exportExcelForVerification();
      }else{
        await excelService.exportExcel();
      }
      setState(() {
        loader = false;
      });
    } catch (e) {
      setState(() {
        loader = false;
      });
      CustomWidgetBuilder.showMessageDialog(context, e.toString(), true);
    }
  }

  void showSuccessDialog(String title, {String? content}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
              title: Text(title),
              content: content != null ?
                  Text(content) : null,
              actions: [
                TextButton(
                  child: Text(lang.getTxt('ok')),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> Administrator()), (route) => false);
                  },
                )
              ],
            ));
  }

  Column buildColumn(String title, dsize, String img) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF).withOpacity(0.3),
              borderRadius: BorderRadius.circular(20)),
          child: img != ''
              ? Image.asset(
                  'assets/icons/$img.png',
                  height: dsize.height * 0.152,
                )
              : Padding(
                  padding: EdgeInsets.all(dsize.height * 0.01),
                  child: Icon(Icons.cloud_upload, size: dsize.height * 0.13),
                ),
        ),
        SizedBox(
          height: dsize.height * 0.0044,
        ), //2
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: dsize.width * 0.03),
        ),
      ],
    );
  }
}
