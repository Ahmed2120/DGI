import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:dgi/Services/ServerService.dart';
import 'package:dgi/Services/TransactionService.dart';
import 'package:dgi/Services/UserService.dart';
import 'package:dgi/authentication.dart';
import 'package:dgi/model/User.dart';
import 'package:dgi/model/transaction.dart';
import 'package:dgi/screens/home_page.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  String pdaNo;
  AuthScreen({Key? key, required this.pdaNo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
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
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: deviceSize.height * 0.014),
              child: Container(
                height: deviceSize.height,
                width: deviceSize.width,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 0,
                        child: CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(0.5),
                            radius: deviceSize.height * 0.1,
                            child: Image.asset(
                              'assets/icons/0-18.png',
                              width: deviceSize.height * 0.15,
                            )),
                      ),
                      Flexible(
                          child: Container(
                        margin: EdgeInsets.only(top: deviceSize.height * 0.004),
                        child: Text(
                          'Welcome!',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: deviceSize.height <= 405
                                ? 14
                                : deviceSize.height * 0.06,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                      Flexible(
                        child: AuthCard(
                          pdaNo: pdaNo,
                        ),
                        flex: 0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  String pdaNo;
  AuthCard({Key? key, required this.pdaNo}) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final serverService = ServerService();

  final GlobalKey<FormState> _formKey = GlobalKey();

  final Map<String, String> _authData = {'password': ''};

  bool isLoading = false;
  final _passwordController = TextEditingController();
  final userService = UserService();
  TransactionLookUp? transaction;
  User? user;
  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    List<User> users = await userService.retrieve();
    if (users.isEmpty) {
      try{
        await serverService.syncro(widget.pdaNo);
        users = await userService.retrieve();
        setState(() {
          user = users.isNotEmpty?users[0]:null;
        });
      }catch(e){
        print(e.toString());
        //_showErrorDialog(e.toString().replaceAll("Exception: ", ""));
      }
    }

    List<TransactionLookUp> transactions =
        await TransactionService().retrieve();
    if (transactions.isNotEmpty) {
      setState(() {
        user = users.isNotEmpty?users[0]:null;
        transaction = transactions[0];
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    _formKey.currentState!.save();
    setState(() {
      isLoading = true;
    });

    try {
      var bytes1 = utf8.encode(_authData['password']!); // data being hashed
      var digest1 = sha256.convert(bytes1);
      Authentication auth = Authentication();
      if (user == null) {
        await initData();
        user = await getUser();
      }
      if(user != null){
        auth.logIn(user!.username, digest1.toString()).then((value) {
          setState(() {
            isLoading = false;
          });
          if (value == 'success') {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const HomePage()));
          } else {
            _showErrorDialog('Invalid password');
          }
        });
      }
      else{
        _showErrorDialog('There is no transaction assign to this device');
      }
  }catch (err) {
      var errMessage = 'Could not authenticate you. please try again later';
      _showErrorDialog(err.toString());
    }
  }

  getUser()async{
    List<User> users = await userService.retrieve();
    return users.isNotEmpty ? users[0] : null;
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
                      isLoading = false;
                    });
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return SizedBox(
      width: deviceSize.width * 0.75,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Text(user != null ?"${user?.name}":"",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ))),
            SizedBox(
              height: deviceSize.height * 0.02,
            ),
            Text(
              "PDA NO ${widget.pdaNo}",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(
              height: deviceSize.height * 0.002,
            ),
            if(transaction != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(
                  "TRANSACTION NO : ${transaction != null ?transaction?.id:''}",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: deviceSize.height * 0.002,
                ),
                Text(
                  "TRANSACTION NAME : ${transaction != null ?transaction?.transActionTypeName:''}",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],),
            if(transaction == null)
              Text(
                "THERE IS NO TRANSACTION ASSIGN TO THIS DEVICE",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            TextFormField(
              decoration: const InputDecoration(
                  labelStyle: TextStyle(color: Colors.white),
                  labelText: 'Password',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  )),
              obscureText: true,
              controller: _passwordController,
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Type Password';
                }
              },
              onSaved: (val) {
                _authData['password'] = val!;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            // if (isLoading)
            //   const CircularProgressIndicator()
            ElevatedButton(
              child: isLoading ? CircularProgressIndicator() : Text('Log In'),
              onPressed: isLoading?null:_submit,
              style: ElevatedButton.styleFrom(
                  primary: const Color(0xFFFFA227),
                  textStyle: const TextStyle(fontSize: 20),
                  padding: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  minimumSize: const Size(double.infinity, 34)),
            ),
            SizedBox(
              height: deviceSize.height * 0.02,
            ),
            ElevatedButton(
              child: const Text('Close'),
              onPressed: () {Navigator.pop(context);},
              style: ElevatedButton.styleFrom(
                  primary: Color(0xFF0F6671),
                  textStyle: TextStyle(fontSize: 20),
                  padding: EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  minimumSize: Size(double.infinity, 34)),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Column(
                children: [
                  Text(
                    'Modyle Name : ASSET TRACKING',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize:
                      deviceSize.height <= 430 ? deviceSize.height * 0.03 : 12,
                    ),
                  ),
                  SizedBox(
                    height: deviceSize.height * 0.015,
                  ),
                  Text(
                    'Internal Version',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: deviceSize.height * 0.03,
                    ),
                  ),
                  Text(
                    'V 1.0.0',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: deviceSize.height * 0.03,
                    ),
                  ),
                  SizedBox(
                    height: deviceSize.height * 0.01,
                  ),
                  Text(
                    'DGI SYSTEM',
                    style: TextStyle(
                        color: Color(0xFF0F6671),
                        fontSize: deviceSize.height * 0.042,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}