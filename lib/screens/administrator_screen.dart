import 'package:dgi/Services/ServerService.dart';
import 'package:dgi/Services/SettingService.dart';
import 'package:dgi/Utility/configration.dart';
import 'package:dgi/model/settings.dart';
import 'package:flutter/material.dart';
import '../Services/lightCapture_service.dart';
import '../Utility/CustomWidgetBuilder.dart';
import '../model/assetLocation.dart';
import 'auth_screen.dart';
import 'light_capture_screen.dart';

class Administrator extends StatefulWidget {
  const Administrator({Key? key}) : super(key: key);

  @override
  State<Administrator> createState() => _AdministratorState();
}

class _AdministratorState extends State<Administrator> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  //TextEditingController nameController = TextEditingController();
  TextEditingController noController = TextEditingController();
  TextEditingController ipAddressController = TextEditingController(text: 'http://85.93.89.54:');
  final settingService = SettingService();
  final serverService = ServerService();
  final lightCaptureService = LightCaptureService();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final dSize = MediaQuery.of(context).size;
    final bottomPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: !_isLoading
          ? SafeArea(
              child: SingleChildScrollView(
                child: SizedBox(
                  height: dSize.height - bottomPadding,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: dSize.height * 0.35,
                        padding:
                            EdgeInsets.symmetric(vertical: dSize.height * 0.02),
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
                              decoration: const BoxDecoration(color: Colors.white),
                              child: Text(
                                'ADMINISTRATOR',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: const Color(0xFF0F6671),
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
                                  CustomWidgetBuilder.buildText(
                                      'PDA NO', dSize),
                                  const Spacer(),
                                  SizedBox(
                                    width: dSize.width * 0.5,
                                    child: TextFormField(
                                      controller: noController,
                                      decoration: InputDecoration(
                                        enabledBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF00B0BD)),
                                        ),
                                        contentPadding: EdgeInsets.all(
                                            dSize.width <= 400
                                                ? dSize.height * 0.007
                                                : 8),
                                        isDense: true,
                                      ),
                                      keyboardType: TextInputType.number,
                                      validator: (val) {
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
                                  CustomWidgetBuilder.buildText(
                                      'IP address', dSize),
                                  const Spacer(),
                                  SizedBox(
                                    width: dSize.width * 0.5,
                                    child: TextFormField(
                                      controller: ipAddressController,
                                      decoration: InputDecoration(
                                        enabledBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF00B0BD)),
                                        ),
                                        contentPadding: EdgeInsets.all(
                                            dSize.width <= 400
                                                ? dSize.height * 0.007
                                                : 8),
                                        isDense: true,
                                      ),
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return 'please enter IP address';
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: dSize.height * 0.035,
                              ),
                              Wrap(
                                alignment: WrapAlignment.center,
                                spacing: 20,
                                runSpacing: 20,
                                children: [
                                  ElevatedButton(
                                    child: Text(
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
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        minimumSize: Size(dSize.width * 0.4, 34)),
                                  ),
                                  ElevatedButton(
                                    child: Text(
                                      'Light Capture',
                                      style: TextStyle(
                                          fontSize: dSize.height <= 500
                                              ? dSize.height * 0.027
                                              : 13.75),
                                    ),
                                    onPressed: () => {_lightCapture()},
                                    style: ElevatedButton.styleFrom(
                                        primary: const Color(0xFF0F6671),
                                        textStyle: const TextStyle(fontSize: 20),
                                        padding: const EdgeInsets.all(15),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        minimumSize: Size(dSize.width * 0.4, 34)),
                                  ),
                                  ElevatedButton(
                                    child: Text(
                                      'Clear Data',
                                      style: TextStyle(
                                          fontSize: dSize.height <= 500
                                              ? dSize.height * 0.027
                                              : 13.75),
                                    ),
                                    onPressed: () => {clearData()},
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.red,
                                        textStyle: const TextStyle(fontSize: 20),
                                        padding: const EdgeInsets.all(15),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        minimumSize: Size(dSize.width * 0.4, 34)),
                                  ),
                                ],
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
            )
          : CustomWidgetBuilder.buildSpanner(),
    );
  }

  Text buildText(String title, dSize) {
    return Text(
      title,
      style: TextStyle(
          fontSize: dSize.width * 0.04,
          color: const Color(0xFF0F6671),
          fontWeight: FontWeight.bold),
    );
  }

  getTransaction() async {
    try {
      setState(() {
        _isLoading = true;
      });
      MyConfig.SERVER = ipAddressController.text;
      String response = await serverService.syncro(noController.text);
      if(response == "Success"){
        await settingService
            .insert(
            Setting(pdaNo: noController.text,ipAddress: ipAddressController.text))
            .whenComplete(() =>
            setState(() {
              _isLoading = false;
            }));
        showSuccessDialog(noController.text);
      }else {
        _showErrorDialog(response);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorDialog(e.toString().replaceAll("Exception: ", ""));
    }
  }

  clearData() async {
    setState(() {
      _isLoading = true;
    });
    try {

      await serverService.clearData();

      setState(() {
        _isLoading = false;
      });
      successClearDataDialog();
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      CustomWidgetBuilder.showMessageDialog(context, e.toString(), true);
    }
  }

  void showSuccessDialog(String pdaNo) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          title: const Text("Synchronization done successfully"),
          content: const Text('Please Log in to start your transaction'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AuthScreen(pdaNo: pdaNo)));
              },
            )
          ],
        ));
  }

  void successClearDataDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          title: const Text("Clear Data Done successfully"),
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

  Future _submit() async {
    if (!_formKey.currentState!.validate()) {
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

  Future _lightCapture() async {
    // if (!_formKey.currentState!.validate()) {
    //   return;
    // }
    FocusScope.of(context).unfocus();
    _formKey.currentState!.save();
    try {
      setState(() {
        _isLoading = true;
      });
      MyConfig.SERVER = ipAddressController.text;
      String response = await lightCaptureService.getAllFloors();
      await lightCaptureService.getAllItems();
      if(response == "Success"){

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LightCaptureScreen()));
        // showSuccessDialog(noController.text);
      }else {
        _showErrorDialog(response);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorDialog(e.toString().replaceAll("Exception: ", ""));
    }

  }
}
