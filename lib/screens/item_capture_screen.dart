import 'package:dgi/Services/AreaService.dart';
import 'package:dgi/Services/AssetLocationService.dart';
import 'package:dgi/Services/CityService.dart';
import 'package:dgi/Services/CountryService.dart';
import 'package:dgi/Services/DepartmentService.dart';
import 'package:dgi/Services/FloorService.dart';
import 'package:dgi/Utility/DropDownMenu.dart';
import 'package:dgi/model/area.dart';
import 'package:dgi/model/assetLocation.dart';
import 'package:dgi/model/city.dart';
import 'package:dgi/model/country.dart';
import 'package:dgi/model/department.dart';
import 'package:dgi/model/floor.dart';
import 'package:dgi/screens/assets_capture_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemCapture extends StatefulWidget {
  const ItemCapture({Key? key}) : super(key: key);

  @override
  State<ItemCapture> createState() => _ItemCaptureState();
}

class _ItemCaptureState extends State<ItemCapture> {
  List<Country> countries = [];
  List<City> cities = [];
  List<Floor> floors = [];
  List<Department> departments=[];
  List<Area> areas =[Area(name: 'damp')];
  AssetLocation assetLocation = AssetLocation(id:1, name: '', buildingAddress: '', buildingName: '', buildingNo: '', businessUnit: '', areaId: 1, departmentId: 1, floorId: 1,sectionId: 10);
  final GlobalKey<FormState> _formKey = GlobalKey();
  final countryService = CountryService();
  final cityService = CityService();
  final floorService = FloorService();
  final areaService = AreaService();
  final departmentService = DepartmentService();
  final assetLocationService = AssetLocationService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    final dSize = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: dSize.height - 24,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: dSize.height * 0.20,
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
                                    vertical: 5, horizontal: 25),
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
                                          fontFamily: 'Montserrat'),
                                      children: const <InlineSpan>[
                                        TextSpan(
                                          text: 'ITEM ',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text: 'CAPTURE',
                                        ),
                                      ]),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: dSize.height * 0.018,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('DATE : 14-03-2022', style:
                              TextStyle(color: Color(0xFF0F6671), fontSize: dSize.width * 0.037),),
                              Text('TIME : 24,00', style:
                              TextStyle(color: Color(0xFF0F6671), fontSize: dSize.width * 0.037),),
                              Text('NO. : 01223997', style:
                              TextStyle(color: Color(0xFF0F6671), fontSize: dSize.width * 0.037),),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: SizedBox(
                      height: dSize.height * 0.58,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(bottom: 5),
                              child: const Text('ITEM LOCATION INFORMATION', style:
                              TextStyle(fontSize: 13, color: Color(0xFF0F6671), fontWeight: FontWeight.bold),),
                            ),
                            DropDownMenu(title: "COUNTRY", values: countries.map((e) => e.name).toList(),),
                            SizedBox(height: dSize.height * 0.01,),
                            DropDownMenu(title: "CITY", values: cities.map((e) => e.name).toList()),
                            SizedBox(height: dSize.height * 0.01,),
                            buildTextFormField(dSize,'AREA',areas.isNotEmpty?areas[0].name:'dump'),
                            SizedBox(height: dSize.height * 0.01,),
                            buildTextFormField(dSize,'DEPARTMENT',departments.isNotEmpty?departments[0].name:"dump"),
                            SizedBox(height: dSize.height * 0.01,),
                            buildTextFormField(dSize,'BUSINESS UNIT',assetLocation!.businessUnit),
                            SizedBox(height: dSize.height * 0.01,),
                            buildTextFormField(dSize,'NAME',assetLocation!.name),
                            SizedBox(height: dSize.height * 0.01,),
                            buildTextFormField(dSize,'BLDG NAME',assetLocation!.buildingName),
                            SizedBox(height: dSize.height * 0.01,),
                            buildTextFormField(dSize,'BLDG ADDRESS',assetLocation!.buildingAddress),
                            SizedBox(height: dSize.height * 0.01,),
                            buildTextFormField(dSize,'BUILDING NO',assetLocation!.buildingNo.toString()),
                            SizedBox(height: dSize.height * 0.01,),
                            DropDownMenu(title: 'FLOOR NO', values: floors.map((e) => e.name).toList()),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Color(0xFF00B0BD),
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Icon(Icons.arrow_back_ios, color: Colors.white,),
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => AssetsCapture(assetLocationId: assetLocation.id,))),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Color(0xFF00B0BD),
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Icon(Icons.arrow_forward_ios, color: Colors.white,),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      height: dSize.height * 0.05,
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Color(0xFF26BB9B),
                                Color(0xFF00B0BD),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              stops: [0, 1])),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'USER NAME : MO GAMAL',
                            style: TextStyle(color: Colors.white, fontSize: dSize.width * 0.037),
                          ),
                          Text(
                            'PDA NO : 1023088',
                            style: TextStyle(color: Colors.white, fontSize: dSize.width * 0.037),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
        ));
  }

  Text buildText(String title, dSize) {
    return Text(
      title,
      style:
      TextStyle(fontSize: dSize.width * 0.04, color: Color(0xFF0F6671), fontWeight: FontWeight.bold),
    );
  }

  initData() async{
/*
    await cityService.insert(City(name: 'Cairo'));
    await countryService.insert(Country(name: 'Egypt'));
    await areaService.insert(Area(name: 'helwan'));
    await floorService.insert(Floor(name: '8'));
    await departmentService.insert(Department(name: 'dep'));
    await assetLocationService.insert(AssetLocation(name: "location",areaId: 1,buildingAddress: "test building Address",
    buildingName: "building Name",buildingNo: '10',businessUnit: 'businessUnit',departmentId: 10,floorId: 10,id: 10));
*/

    countries = await countryService.retrieve();
    cities = await cityService.retrieve();
    floors = await floorService.retrieve();
    departments = await departmentService.retrieve();
    areas = await areaService.retrieve();
    assetLocationService.retrieve().then((value) {
      setState(() {
        if(value.isNotEmpty) {
          assetLocation = value[0];
        }
      });
    });
    setState(() {

    });
  }

  buildTextFormField(Size dSize,String title,String text){
    return Row(
      children: [
        buildText(title, dSize),
        const Spacer(),
        Container(
          width: dSize.width * 0.4,
          decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: Color(0xFF00B0BD), width: 2)),
          ),
          child: TextFormField(
            controller:TextEditingController(text: text) ,
            enabled: false,
            decoration: const InputDecoration(
              constraints: BoxConstraints(maxHeight: 20),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
