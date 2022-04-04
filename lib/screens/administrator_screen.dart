import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dgi/Services/ServerService.dart';
import 'package:dgi/Services/SettingService.dart';
import 'package:dgi/model/settings.dart';
import 'package:flutter/material.dart';
import '../Services/AreaService.dart';
import '../Services/AssetLocationService.dart';
import '../Services/CategoryService.dart';
import '../Services/CountryService.dart';
import '../Services/DepartmentService.dart';
import '../Services/FloorService.dart';
import '../Services/ItemService.dart';
import '../Services/MainCategoryService.dart';
import '../Services/TransactionService.dart';
import '../Services/UserService.dart';
import '../Utility/CustomWidgetBuilder.dart';
import '../Utility/configration.dart';
import '../model/assetLocation.dart';
import '../model/category.dart';
import '../model/country.dart';
import '../model/item.dart';
import '../model/mainCategory.dart';
import '../model/transaction.dart';
import '../model/transcationResponse.dart';
import 'auth_screen.dart';

class Administrator extends StatefulWidget {
  const Administrator({Key? key}) : super(key: key);

  @override
  State<Administrator> createState() => _AdministratorState();
}

class _AdministratorState extends State<Administrator> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController noController = TextEditingController();
  final settingService = SettingService();
  final serverService = ServerService();

  bool _isLoading = false;
  double progress = 0;

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
                  height: dSize.height * 0.35,
                  padding: EdgeInsets.symmetric(vertical: dSize.height * 0.02),
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
                      Image.asset(
                        'assets/icons/0-18.png',
                        width: dSize.height * 0.2,
                      ),
                      SizedBox(
                        height: dSize.height * 0.06,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.white),
                        child: Text(
                          'ADMINISTRATOR',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xFF0F6671),
                              fontSize: dSize.height * 0.025,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        Container(
                            // alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(bottom: 5),
                            child: CustomWidgetBuilder.buildText(
                                'PLEASE ENTER', dSize)),
                        SizedBox(
                          height: dSize.height * 0.035,
                        ),
                        Row(
                          children: [
                            CustomWidgetBuilder.buildText('PDA NO', dSize),
                            Spacer(),
                            Container(
                              width: dSize.width * 0.5,
                              child: TextFormField(
                                controller: noController,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xFF00B0BD)),
                                  ),
                                  contentPadding: EdgeInsets.all(
                                      dSize.width <= 400
                                          ? dSize.height * 0.009
                                          : 12),
                                  isDense: true,
                                ),
                                keyboardType: TextInputType.number,
                                validator: (val){
                                  if (val!.isEmpty) {
                                    return 'please enter PDA NO';
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: dSize.height * 0.035,
                        ),
                        Row(
                          children: [
                            CustomWidgetBuilder.buildText('PDA NAME', dSize),
                            Spacer(),
                            Container(
                              width: dSize.width * 0.5,

                              child: TextFormField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xFF00B0BD)),
                                  ),
                                  contentPadding: EdgeInsets.all(
                                      dSize.width <= 400
                                          ? dSize.height * 0.009
                                          : 12),
                                  isDense: true,
                                ),
                                validator: (val){
                                  if (val!.isEmpty) {
                                    return 'please enter PDA NAME';
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: dSize.height * 0.035,
                        ),
                        ElevatedButton(
                          child: _isLoading ? CircularProgressIndicator() : Text(
                            'DONE',
                            style: TextStyle(
                                fontSize: dSize.height <= 500
                                    ? dSize.height * 0.027
                                    : 13.75),
                          ),
                          onPressed: () => {_submit()},
                          style: ElevatedButton.styleFrom(
                              primary: const Color(0xFFFFA227),
                              textStyle: const TextStyle(fontSize: 20),
                              padding: const EdgeInsets.all(15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              minimumSize: Size(dSize.width * 0.4, 34)),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                    width: double.infinity,
                    height: dSize.height * 0.12,
                    padding: EdgeInsets.symmetric(
                        vertical: dSize.height * 0.007, horizontal: 20),
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
                          'ASSET TRACKING',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: dSize.height <= 455 ? 9.5 : 13),
                        ),
                        Text(
                          'Internal Version',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: dSize.height <= 455 ? 9.5 : 13),
                        ),
                        Text(
                          'v 1.0.0',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: dSize.height <= 455 ? 9.5 : 13),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text buildText(String title, dSize) {
    return Text(
      title,
      style: TextStyle(
          fontSize: dSize.width * 0.04,
          color: Color(0xFF0F6671),
          fontWeight: FontWeight.bold),
    );
  }

  getTransaction() async {
    try{
    setState(() {
      _isLoading = true;
    });

      await serverService.syncro(noController.text);
      await settingService
          .insert(Setting(name: nameController.text, pdaNo: noController.text)).whenComplete(() => setState(() {
        _isLoading = false;
      }));
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AuthScreen(
                pdaNo: noController.text,
              )));
    }catch(e){
      _showErrorDialog('Please enter a valid PDA NO');
    }
  }

  Future _submit() async{
    if(!_formKey.currentState!.validate()){
      return;
    }
    FocusScope.of(context).unfocus();
    _formKey.currentState!.save();
    getTransaction();
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
                setState(() {
                  _isLoading = false;
                });
                Navigator.of(context).pop();
              },
            )
          ],
        ));
  }


}
