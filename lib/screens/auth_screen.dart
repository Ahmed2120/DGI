import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:dgi/Services/AreaService.dart';
import 'package:dgi/Services/AssetLocationService.dart';
import 'package:dgi/Services/CategoryService.dart';
import 'package:dgi/Services/CityService.dart';
import 'package:dgi/Services/CountryService.dart';
import 'package:dgi/Services/DepartmentService.dart';
import 'package:dgi/Services/FloorService.dart';
import 'package:dgi/Services/SectionTypeService.dart';

import 'package:dgi/authentication.dart';
import 'package:dgi/db/UserRepository.dart';
import 'package:dgi/model/User.dart';
import 'package:dgi/model/area.dart';
import 'package:dgi/model/assetLocation.dart';
import 'package:dgi/model/category.dart';
import 'package:dgi/model/city.dart';
import 'package:dgi/model/country.dart';
import 'package:dgi/model/department.dart';
import 'package:dgi/model/floor.dart';
import 'package:dgi/model/sectionType.dart';
import 'package:dgi/screens/home_page.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {

  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    print('deviceSize: ${deviceSize.width * 0.1}');

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
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                // color: Colors.red,
                height: deviceSize.height - 30,
                width: deviceSize.width,
                child: Center(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 0,
                        child: CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(0.5),
                            radius: deviceSize.width * 0.2,
                            child: Image.asset('assets/icons/0-18.png', width: deviceSize.width * 0.25,)),
                      ),
                      Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                              'Welcome!',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: deviceSize.width * 0.1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
                      const Flexible(
                        child: AuthCard(),
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
  const AuthCard({Key? key}) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {

  String _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  final GlobalKey<FormState> _formKey = GlobalKey();

  final Map<String, String> _authData = {'username': '', 'password': ''};

  bool isLoading = false;
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future _submit() async {
    if(!_formKey.currentState!.validate()){
      return;
    }
    FocusScope.of(context).unfocus();
    _formKey.currentState!.save();
    setState(() {
      isLoading = true;
    });

    try {
      var bytes1 = utf8.encode(_authData['password']!);         // data being hashed
      var digest1 = sha256.convert(bytes1);
      User user = User(
          name: 'ahmad',
          username: _authData['username']!,
          password: digest1.toString(),
          address: 'address',
          email: 'email');
      Authentication auth = Authentication();
      UserRepository userRepository = UserRepository();
      userRepository.insert(user);
      userRepository.retrieve().then((value) {
        for (var val in value) {
          print('${val.username}');
        }
      });

      auth.logIn(_authData['username']!, digest1.toString()).then((value) {
        setState(() {
          isLoading = false;
        });
        if(value == 'success'){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const HomePage()));
        }else{
          _showErrorDialog('Invalid username or password');
        }
      });

    } catch (err) {
      var errMessage = 'Could not authenticate you. please try again later';
      _showErrorDialog(err.toString());
    }
  }
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  initData()async{
    var rng = Random().nextInt(1000);
    CategoryService categoryService = CategoryService();
    final countryService = CountryService();
    final cityService = CityService();
    final floorService = FloorService();
    final areaService = AreaService();
    final departmentService = DepartmentService();
    final assetLocationService = AssetLocationService();
    final sectionTypeService = SectionTypeService();
    String random = getRandomString(8);
    Category category = Category(name: random);
    await categoryService.insert(category);
    await cityService.insert(City(name: random));
    await countryService.insert(Country(name: random));
    await areaService.insert(Area(name: random));
    await floorService.insert(Floor(name: rng.toString()));
    await departmentService.insert(Department(name: random));
    await sectionTypeService.insert(SectionType(name:rng.toString(),floorId: rng));
    await assetLocationService.insert(AssetLocation(name: "location",areaId: 1,buildingAddress: "test building Address",
        buildingName: "building Name",buildingNo: '10',businessUnit: 'businessUnit',departmentId: 10,floorId: 10,id: rng,sectionId: 22));
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
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'username', labelStyle: TextStyle(color: Colors.white),enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),),
              keyboardType: TextInputType.emailAddress,
              validator: (val){
                if(val!.isEmpty){
                  return 'Inavalid username';
                }
              },
              onSaved: (val){
                _authData['email'] = val!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelStyle: TextStyle(color: Colors.white),
                  labelText: 'Password',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  )
              ),
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
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                  primary: const Color(0xFFFFA227),
                  textStyle: const TextStyle(fontSize: 20),
                  padding: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  minimumSize: const Size(double.infinity, 34)),
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(
              child: const Text('Close'),
              onPressed: () {},
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
            Text(
              'Modyle Name : ASSET TRACKING',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: deviceSize.width * 0.04,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Internal Version',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: deviceSize.width * 0.04,
              ),
            ),
            const Text(
              'V 1.0.0',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'DGI SYSTEM',
              style: TextStyle(
                  color: Color(0xFF0F6671),
                  fontSize: deviceSize.width * 0.045,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    );
  }
}