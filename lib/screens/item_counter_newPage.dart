import 'package:dgi/Services/SectionTypeService.dart';
import 'package:dgi/Utility/CustomWidgetBuilder.dart';
import 'package:dgi/Utility/header.dart';
import 'package:dgi/model/sectionType.dart';
import 'package:dgi/screens/assets_check.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Services/MainCategoryService.dart';
import '../Services/SectionGroup_service.dart';
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
import '../model/sectionGroup.dart';
import 'assets_details.dart';

class ItemNewCounter extends StatefulWidget {
  const ItemNewCounter({Key? key}) : super(key: key);

  @override
  State<ItemNewCounter> createState() => _ItemNewCounterState();
}

class _ItemNewCounterState extends State<ItemNewCounter> {
  List<Category> categories = [];
  List<MainCategory> mainCategories = [];
  //List<Country> countries = [];
  List<City> cities = [];
  List<Floor> floors = [];
  List<Department> departments=[];
  List<Area> areas =[];
  List<SectionType> sections =[];
  List<SectionGroup> sectionGroups =[];
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
  final sectionGroupService = SectionGroupService();
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
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.all(8),
                            child: Text(lang.getTxt('asset_information_title'), style:
                            const TextStyle(fontSize: 13, color: Color(0xFF0F6671), fontWeight: FontWeight.bold),),
                          ),
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                child: ListView.builder(
                                  itemCount: sectionGroups.length,
                                  itemBuilder: (context, index)=>
                                      Container(
                                        width: double.infinity,
                                        height: 150,
                                        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                                        padding: const EdgeInsets.only(right: 35, left: 10, top: 5),
                                        decoration: BoxDecoration(
                                          // border: Border.all(color: Colors.grey.shade400),
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade600,
                                              blurRadius: 10,
                                              spreadRadius: 1,
                                              offset: const Offset(5, 5),
                                            ),
                                            const BoxShadow(
                                              color: Colors.white,
                                              blurRadius: 10,
                                              spreadRadius: 1,
                                              offset: Offset(-5, 5),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            info('Building', sectionGroups[index].buildingName,),
                                            info('Floor', sectionGroups[index].floorName,),
                                            info('Section', sectionGroups[index].name,),
                                          ],
                                        ),
                                      ),
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomWidgetBuilder.buildArrow(context,dSize,const Icon(Icons.arrow_back_ios_rounded), ()=>Navigator.of(context).pop()),
                          CustomWidgetBuilder.buildArrow(context,dSize,const Icon(Icons.arrow_forward_ios), ()=> Navigator.of(context).push(
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

  Row info(String title, String subTitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F6671),),
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          subTitle,
          style: const TextStyle(fontSize: 18),
        ),
      ],
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
    sectionGroups = await sectionGroupService.retrieve();
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
