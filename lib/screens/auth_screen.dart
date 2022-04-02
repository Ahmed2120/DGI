import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:dgi/Services/ServerService.dart';
import 'package:dgi/Services/UserService.dart';
import 'package:dgi/authentication.dart';
import 'package:dgi/model/User.dart';
import 'package:dgi/screens/home_page.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  String pdaNo;
  AuthScreen({Key? key,required this.pdaNo}) : super(key: key);

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
                height: deviceSize.height ,
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
                       Flexible(
                        child: AuthCard(pdaNo: pdaNo,),
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
  AuthCard({Key? key,required this.pdaNo}) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {

  final serverService = ServerService();

  final GlobalKey<FormState> _formKey = GlobalKey();

  final Map<String, String> _authData = {'username': '', 'password': ''};

  bool isLoading = false;
  final _passwordController = TextEditingController();
  final userService = UserService();

  @override
  void initState() {
    super.initState();
    initData();
  }
  void initData()async{
    List<User> users = await userService.retrieve();
    if(users.isEmpty)
      await serverService.syncro(widget.pdaNo);
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
      Authentication auth = Authentication();

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
  /*initData()async{
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
    await countryService.insert(Country(name: random,id: 1));
    await areaService.insert(Area(name: random,id: 10));
    await floorService.insert(Floor(name: rng.toString()));
    await departmentService.insert(Department(name: random));
    await sectionTypeService.insert(SectionType(name:rng.toString(),floorId: rng));
    await assetLocationService.insert(AssetLocation(name: "location",areaId: 1,buildingAddress: "test building Address",
    buildingName: "building Name",buildingNo: '10',businessUnit: 'businessUnit',departmentId: 10,floorId: 10,id: rng,sectionId: 22));
    await assetService.insert(Asset(id:10,itemId: rng, barcode: "test", barcodeImage: image, serialnumber: "serial 010", assetLocationId: rng, description: "description item", image: image));
  }*/

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
                _authData['username'] = val!;
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