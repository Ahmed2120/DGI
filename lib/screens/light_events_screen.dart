import 'package:flutter/material.dart';

import '../Services/ServerService.dart';
import '../Services/lightCapture_service.dart';
import '../Services/lightVerificaion_service.dart';
import '../Utility/CustomWidgetBuilder.dart';
import '../Utility/configration.dart';
import 'light_capture_screen.dart';
import 'light_verification_screen.dart';

class LightEventsScreen extends StatefulWidget {
  const LightEventsScreen({Key? key}) : super(key: key);

  @override
  State<LightEventsScreen> createState() => _LightEventsScreenState();
}

class _LightEventsScreenState extends State<LightEventsScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController ipAddressController = TextEditingController(text: 'http://85.93.89.54:');

  final serverService = ServerService();
  final lightCaptureService = LightCaptureService();
  final lightVerificationService = LightVerificationService();


  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final dSize = MediaQuery.of(context).size;
    final bottomPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      // body: SafeArea(
      //   child: GridView(
      //     padding: const EdgeInsets.all(20),
      //     gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      //       maxCrossAxisExtent: 200,
      //       childAspectRatio: 3 / 2,
      //       crossAxisSpacing: 20,
      //       mainAxisSpacing: 20,
      //     ),
      //     children: [
      //       buildInkWell(context, 'Light Capture', (){})
      //     ],
      //   ),
      // ),
      body: !_isLoading ? SafeArea(
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
                            padding: const EdgeInsets.only(bottom: 5),
                            child: CustomWidgetBuilder.buildText(
                                'PLEASE ENTER', dSize)),
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
                                'Light Verification',
                                style: TextStyle(
                                    fontSize: dSize.height <= 500
                                        ? dSize.height * 0.027
                                        : 13.75),
                              ),
                              onPressed: () => {_lightVerification()},
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
      ) : CustomWidgetBuilder.buildSpanner(),
    );
  }

  InkWell buildInkWell(BuildContext context, String title, Function function) {
    return InkWell(
        onTap: () =>function(),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        alignment: AlignmentDirectional.center,
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF26BB9B),
                Color(0xFF00B0BD),],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20)),
      ));
  }

  Future _lightCapture() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
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

        Navigator.push(context, MaterialPageRoute(builder: (context)=> LightCaptureScreen()));
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

  Future _lightVerification() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    _formKey.currentState!.save();
    try {
      setState(() {
        _isLoading = true;
      });
      MyConfig.SERVER = ipAddressController.text;
      String response = await lightVerificationService.getAllSections();
      // await lightCaptureService.getAllItems();
      if(response == "Success"){

        Navigator.push(context, MaterialPageRoute(builder: (context)=> LightVerificationScreen()));
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
}
