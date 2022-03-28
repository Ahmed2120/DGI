import 'package:dgi/Services/CategoryService.dart';
import 'package:dgi/Services/SectionTypeService.dart';
import 'package:dgi/Utility/CustomWidgetBuilder.dart';
import 'package:dgi/model/category.dart';
import 'package:dgi/model/sectionType.dart';
import 'package:dgi/screens/assets_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
import '../Utility/CustomWidgetBuilder.dart';
import '../Utility/footer.dart';
import '../Utility/header.dart';

class AssetsVerification extends StatefulWidget {
  const AssetsVerification({Key? key}) : super(key: key);

  @override
  State<AssetsVerification> createState() => _AssetsVerificationState();
}

class _AssetsVerificationState extends State<AssetsVerification> {
  List<Category> categories = [];
  List<Country> countries = [];
  List<City> cities = [];
  List<Floor> floors = [];
  List<Department> departments = [];
  List<Area> areas = [];
  List<SectionType> sections = [];
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
      sectionId: 10);
  final GlobalKey<FormState> _formKey = GlobalKey();
  final countryService = CountryService();
  final cityService = CityService();
  final floorService = FloorService();
  final areaService = AreaService();
  final departmentService = DepartmentService();
  final assetLocationService = AssetLocationService();
  final categoryService = CategoryService();
  final sectionService = SectionTypeService();
  String? category;
  String? city;
  String? location;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  List<String> locations = ['STORE', 'BUILDING', 'OFFICE'];



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
              const Header(
                title: 'ASSETS',
                subTitle: 'VERIFICATION',
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
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
                          child: const Text(
                            'ASSET LOCATION INFORMATION',
                            style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF0F6671),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          children: [
                            CustomWidgetBuilder.buildText('CATEGORY', dSize),
                            const Spacer(),
                            Container(
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Color(0xFF00B0BD), width: 2))),
                              width: dSize.width * 0.5,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: category,
                                  iconSize: 30,
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Color(0xFF00B0BD),
                                  ),
                                  isDense: true,
                                  isExpanded: true,
                                  items: categories
                                      .map((e) => e.name)
                                      .map((String item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                            color: Color(0xFF0F6671),
                                            fontSize: 20),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      category = val;
                                    });
                                    print(val);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: dSize.height * 0.01,
                        ),
                        Row(
                          children: [
                            CustomWidgetBuilder.buildText('CITY', dSize),
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
                                  iconSize: 30,
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Color(0xFF00B0BD),
                                  ),
                                  isDense: true,
                                  isExpanded: true,
                                  items: cities
                                      .map((e) => e.name)
                                      .map((String item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                            color: Color(0xFF0F6671),
                                            fontSize: 20),
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
                        SizedBox(
                          height: dSize.height * 0.01,
                        ),
                        CustomWidgetBuilder.buildTextFormField(dSize, 'AREA',
                            areas.isNotEmpty ? areas[0].name : 'dump'),
                        SizedBox(
                          height: dSize.height * 0.01,
                        ),
                        Row(
                          children: [
                            CustomWidgetBuilder.buildText(
                                'LOCATION TYPE', dSize),
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
                                  iconSize: 30,
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Color(0xFF00B0BD),
                                  ),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
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
                        SizedBox(
                          height: dSize.height * 0.01,
                        ),
                        if (location == 'OFFICE' || location == 'BUILDING')
                          CustomWidgetBuilder.buildTextFormField(
                              dSize,
                              'FLOOR NO',
                              floors.isNotEmpty ? floors[0].name : '0'),
                        SizedBox(
                          height: dSize.height * 0.01,
                        ),
                        if (location == 'OFFICE' || location == 'BUILDING')
                          CustomWidgetBuilder.buildTextFormField(
                              dSize,
                              'SECTION NO',
                              sections.isNotEmpty ? sections[0].name : '0'),
                        SizedBox(
                          height: dSize.height * 0.01,
                        ),
                        if (location == 'OFFICE' || location == 'STORE')
                          CustomWidgetBuilder.buildTextFormField(
                              dSize,
                              'DEPARTMENT',
                              departments.isNotEmpty ? departments[0].name : '0'),
                        SizedBox(
                          height: dSize.height * 0.01,
                        ),
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
                    CustomWidgetBuilder.buildArrow(
                        context,
                        dSize,
                        const Icon(Icons.arrow_back_ios_rounded),
                        () => Navigator.of(context).pop()),
                    CustomWidgetBuilder.buildArrow(
                        context,
                        dSize,
                        const Icon(Icons.arrow_forward_ios),
                        () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AssetsDetails()))),
                  ],
                ),
              ),
              const Footer()
            ],
          ),
        ),
      ),
    ));
  }

  initData() async {
    categories = await categoryService.retrieve();
    countries = await countryService.retrieve();
    cities = await cityService.retrieve();
    floors = await floorService.retrieve();
    departments = await departmentService.retrieve();
    areas = await areaService.retrieve();
    sections = await sectionService.retrieve();
    assetLocationService.retrieve().then((value) {
      setState(() {
        if (value.isNotEmpty) {
          assetLocation = value[0];
        }
      });
    });
    setState(() {});
  }
}
