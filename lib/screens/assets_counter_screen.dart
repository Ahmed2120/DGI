import 'package:dgi/Services/SectionTypeService.dart';
import 'package:dgi/Utility/CustomWidgetBuilder.dart';
import 'package:dgi/Utility/header.dart';
import 'package:dgi/model/sectionType.dart';
import 'package:dgi/screens/assets_check.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Services/MainCategoryService.dart';
import '../Utility/footer.dart';
import 'package:dgi/Services/CategoryService.dart';
import 'package:dgi/model/category.dart';
import 'package:dgi/Services/AreaService.dart';
import 'package:dgi/Services/AssetLocationService.dart';
import 'package:dgi/Services/CityService.dart';
import 'package:dgi/Services/CountryService.dart';
import 'package:dgi/Services/DepartmentService.dart';
import 'package:dgi/Services/FloorService.dart';
import 'package:dgi/model/area.dart';
import 'package:dgi/model/assetLocation.dart';
import 'package:dgi/model/city.dart';
import 'package:dgi/model/country.dart';
import 'package:dgi/model/department.dart';
import 'package:dgi/model/floor.dart';

import '../language.dart';
import '../model/mainCategory.dart';

class AssetsCounter extends StatefulWidget {
  const AssetsCounter({Key? key}) : super(key: key);

  @override
  State<AssetsCounter> createState() => _AssetsCounterState();
}

class _AssetsCounterState extends State<AssetsCounter> {
  List<Category> categories = [];
  List<MainCategory> mainCategories = [];
  //List<Country> countries = [];
  List<City> cities = [];
  List<Floor> floors = [];
  List<Department> departments=[];
  List<Area> areas =[];
  List<SectionType> sections =[];
  AssetLocation assetLocation = AssetLocation(
      id: 1,
      name: '',
      buildingAddress: '',
      buildingName: '',
      buildingNo: '',
      businessUnit: '',
      areaId: 1,
      departmentId: 1,
      floorId: 1,
      sectionId: 10,
      locationTypeName: 'Building',
      country: '',
      compound: '',
      city: '',
      governorate: '',
      locationType: 1);
  final countryService = CountryService();
  final cityService = CityService();
  final floorService = FloorService();
  final areaService = AreaService();
  final departmentService = DepartmentService();
  final assetLocationService = AssetLocationService();
  final categoryService = CategoryService();
  final mainCategoryService = MainCategoryService();
  final sectionService = SectionTypeService();
  String? category;
  String? mainCategory;
  String? city;
  String? location;
  MainCategory? _main;
  List<String> locations = [];

  final lang = Language();

  @override
  void initState() {
    super.initState();
    initData();
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
                    Header(
                      title: lang.getTxt('counter_header_title'),
                      subTitle: lang.getTxt('counter_header_subTitle'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      child: SizedBox(
                        height: dSize.height * 0.58,
                        child: SingleChildScrollView(
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(lang.getTxt('asset_information_title'), style:
                                TextStyle(fontSize: 13, color: Color(0xFF0F6671), fontWeight: FontWeight.bold),),
                              ),
                              Row(
                                children: [
                                  CustomWidgetBuilder.buildText(lang.getTxt('city'), dSize),
                                  Spacer(),
                                  Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Color(0xFF00B0BD), width: 2))),
                                    width: dSize.width * 0.5,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: city,
                                        iconSize: 20,
                                        icon: const Icon(
                                          Icons.arrow_drop_down,
                                          color: Color(0xFF00B0BD),
                                        ),
                                        isDense: true,
                                        isExpanded: true,
                                        items:
                                        cities.map((e) => e.name).map((String item) {
                                          return DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                  color: Color(0xFF0F6671), fontSize: 15),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (val) {
                                          setState(() {
                                            city = val;
                                          });
                                          print(val);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: dSize.height * 0.01,),
                              CustomWidgetBuilder.buildTextFormField(dSize,lang.getTxt('area'),areas.isNotEmpty?areas[0].name:'area',false),
                              SizedBox(height: dSize.height * 0.01,),
                              Row(
                                children: [
                                  CustomWidgetBuilder.buildText(
                                      Language.isEn ? lang.textEn['location_type']! : lang.textAr['location_type']!, dSize),
                                  Spacer(),
                                  Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Color(0xFF00B0BD), width: 2))),
                                    width: dSize.width * 0.5,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: location,
                                        iconSize: 20,
                                        icon: const Icon(
                                          Icons.arrow_drop_down,
                                          color: Color(0xFF00B0BD),
                                        ),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 15),
                                        selectedItemBuilder: (BuildContext context) {
                                          return locations.map((String value) {
                                            return Text(
                                              value,
                                              style: const TextStyle(
                                                  color: Color(0xFF0F6671)),
                                            );
                                          }).toList();
                                        },
                                        dropdownColor: Color(0xFF00B0BD),
                                        isDense: true,
                                        isExpanded: true,
                                        items: locations.map((String item) {
                                          return DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              // style: const TextStyle(
                                              //     color: Color(0xFF0F6671), fontSize: 20),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (val) {
                                          setState(() {
                                            location = val;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: dSize.height * 0.015,),
                              if(location == 'Office' || location == 'Building')
                                CustomWidgetBuilder.buildTextFormField(dSize,lang.getTxt('floor'),floors.isNotEmpty?areas[0].name:'2',false),
                              SizedBox(height: dSize.height * 0.01,),
                              if(location == 'Office' || location == 'Building')
                                CustomWidgetBuilder.buildTextFormField(dSize,lang.getTxt('section'),sections.isNotEmpty?areas[0].name:'2',false),
                              SizedBox(height: dSize.height * 0.01,),
                              if(location == 'Office' || location == 'Store')
                                CustomWidgetBuilder.buildTextFormField(dSize,lang.getTxt('department'),departments.isNotEmpty?areas[0].name:'2',false),
                              SizedBox(height: dSize.height * 0.01,),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomWidgetBuilder.buildArrow(context,dSize,Icon(Icons.arrow_back_ios_rounded), ()=>Navigator.of(context).pop()),
                          CustomWidgetBuilder.buildArrow(context,dSize,Icon(Icons.arrow_forward_ios), ()=> Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => AssetsCheck())))
                        ],
                      ),
                    ),
                    Footer()
                  ],
                ),
              ),
            ),
          )),
    );
  }
  initData() async{
    // categories = await categoryService.retrieve();
    // category = categories[0].name;
    mainCategories = await mainCategoryService.retrieve();
    mainCategory = mainCategories[0].name;
    _main = mainCategories[0];
    //countries = await countryService.retrieve();
    cities = await cityService.retrieve();
    city = cities.isNotEmpty?cities[0].name:"";
    floors = await floorService.retrieve();
    departments = await departmentService.retrieve();
    areas = await areaService.retrieve();
    sections = await sectionService.retrieve();
    assetLocationService.retrieve().then((value) {
      setState(() {
        if(value.isNotEmpty) {
          assetLocation = value[0];
          locations = [assetLocation.locationTypeName];
          location = assetLocation.locationTypeName;
        }
      });
    });
    setState(() {

    });
  }



}
