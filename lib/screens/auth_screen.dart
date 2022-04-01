import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:dgi/Services/AreaService.dart';
import 'package:dgi/Services/AssetLocationService.dart';
import 'package:dgi/Services/AssetService.dart';
import 'package:dgi/Services/CategoryService.dart';
import 'package:dgi/Services/CityService.dart';
import 'package:dgi/Services/CountryService.dart';
import 'package:dgi/Services/DepartmentService.dart';
import 'package:dgi/Services/FloorService.dart';
import 'package:dgi/Services/ItemService.dart';
import 'package:dgi/Services/SectionTypeService.dart';

import 'package:dgi/authentication.dart';
import 'package:dgi/db/UserRepository.dart';
import 'package:dgi/model/User.dart';
import 'package:dgi/model/area.dart';
import 'package:dgi/model/asset.dart';
import 'package:dgi/model/assetLocation.dart';
import 'package:dgi/model/category.dart';
import 'package:dgi/model/city.dart';
import 'package:dgi/model/country.dart';
import 'package:dgi/model/department.dart';
import 'package:dgi/model/floor.dart';
import 'package:dgi/model/item.dart';
import 'package:dgi/model/mainCategory.dart';
import 'package:dgi/model/sectionType.dart';
import 'package:dgi/screens/home_page.dart';
import 'package:flutter/material.dart';

import '../Services/MainCategoryService.dart';

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
              padding: EdgeInsets.only(top: deviceSize.height * 0.014),
              child: Container(
                // color: Colors.red,
                height: deviceSize.height ,
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
                            radius: deviceSize.height * 0.1,
                            child: Image.asset('assets/icons/0-18.png', width: deviceSize.height * 0.15,)),
                      ),
                      Flexible(
                          child: Container(
                            margin: EdgeInsets.only(top: deviceSize.height * 0.004),
                            child: Text(
                              'Welcome!',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: deviceSize.height <= 405 ? 14 : deviceSize.height * 0.06,
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
  String image = "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";
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
    MainCategoryService mainCategoryService = MainCategoryService();
    final countryService = CountryService();
    final cityService = CityService();
    final floorService = FloorService();
    final areaService = AreaService();
    final departmentService = DepartmentService();
    final assetLocationService = AssetLocationService();
    final sectionTypeService = SectionTypeService();
    final assetService = AssetService();
    final itemService =ItemService();
    String random = getRandomString(8);
    Item item1 = Item(name: 'cat1item1',categoryId: 1);
    Item item2 = Item(name: 'cat1item2',categoryId: 1);
    Item item3 = Item(name: 'cat2item3',categoryId: 2);
    Item item4 = Item(name: 'cat2item1',categoryId: 2);
    Item item5 = Item(name: 'cat3item2',categoryId: 3);
    Item item6 = Item(name: 'cat3item1',categoryId: 3);
    Item item7 = Item(name: 'cat4item2',categoryId: 4);
    Item item8 = Item(name: 'cat5item2',categoryId: 5);
    Category category1 = Category(id:1,name: 'table1', mainCategoryId: 1);
    Category category2 = Category(id:2,name: 'table2', mainCategoryId: 1);
    Category category3 = Category(id:3,name: 'table3', mainCategoryId: 1);
    Category category4 = Category(id:4,name: 'chair1', mainCategoryId: 2);
    Category category5 = Category(id:5,name: 'chair2', mainCategoryId: 2);
    MainCategory mainCategory1 = MainCategory(name: 'table');
    MainCategory mainCategory2 = MainCategory(name: 'chair');
    await mainCategoryService.insert(mainCategory1);
    await mainCategoryService.insert(mainCategory2);
    await categoryService.insert(category1);
    await categoryService.insert(category2);
    await categoryService.insert(category3);
    await categoryService.insert(category4);
    await categoryService.insert(category5);
    await itemService.insert(item1);
    await itemService.insert(item2);
    await itemService.insert(item3);
    await itemService.insert(item4);
    await itemService.insert(item5);
    await itemService.insert(item6);
    await itemService.insert(item7);
    await itemService.insert(item8);
    await cityService.insert(City(name: random));
    await countryService.insert(Country(name: random));
    await areaService.insert(Area(name: random));
    await floorService.insert(Floor(name: rng.toString()));
    await departmentService.insert(Department(name: random));
    await sectionTypeService.insert(SectionType(name:rng.toString(),floorId: rng));
    await assetLocationService.insert(AssetLocation(name: "location",areaId: 1,buildingAddress: "test building Address",
    buildingName: "building Name",buildingNo: '10',businessUnit: 'businessUnit',departmentId: 10,floorId: 10,id: rng,sectionId: 22));
    await assetService.insert(Asset(itemId: rng, barcode: "test", barcodeImage: image, serialnumber: "serial 010", assetLocationId: rng, description: "description item", image: image));
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
    print('deviceSize:xx ${deviceSize.height * 0.03}');

    return SizedBox(
      width: deviceSize.width * 0.75,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'username', labelStyle: TextStyle(color: Colors.white), isDense: true, enabledBorder: UnderlineInputBorder(
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
            SizedBox(
              height: deviceSize.height * 0.02,
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
                fontSize: deviceSize.height <= 430 ? deviceSize.height * 0.03 : 12,
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
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    );
  }
}