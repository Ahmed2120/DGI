import 'package:dgi/Services/SectionTypeService.dart';
import 'package:dgi/Utility/CustomWidgetBuilder.dart';
import 'package:dgi/Utility/configration.dart';
import 'package:dgi/Utility/header.dart';
import 'package:dgi/model/country.dart';
import 'package:dgi/model/sectionType.dart';
import 'package:dgi/screens/assets_capture_screen.dart';
import 'package:flutter/material.dart';
import '../Utility/footer.dart';
import 'package:dgi/Services/AreaService.dart';
import 'package:dgi/Services/AssetLocationService.dart';
import 'package:dgi/Services/CityService.dart';
import 'package:dgi/Services/CountryService.dart';
import 'package:dgi/Services/DepartmentService.dart';
import 'package:dgi/Services/FloorService.dart';
import 'package:dgi/model/area.dart';
import 'package:dgi/model/assetLocation.dart';
import 'package:dgi/model/city.dart';
import 'package:dgi/model/department.dart';
import 'package:dgi/model/floor.dart';

import '../language.dart';

class ItemCapture extends StatefulWidget {
  const ItemCapture({Key? key}) : super(key: key);

  @override
  State<ItemCapture> createState() => _ItemCaptureState();
}

class _ItemCaptureState extends State<ItemCapture> {
  List<City> cities = [];
  List<Country> countries = [];
  List<Floor> floors = [];
  List<Department> departments = [];
  List<Area> areas = [];
  List<SectionType> sections = [];
  List<SectionType> sectionsPerFloor = [];
  String? floor;
  String? department;
  String? section;
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
      locationType: 1);
  final countryService = CountryService();
  final cityService = CityService();
  final floorService = FloorService();
  final areaService = AreaService();
  final departmentService = DepartmentService();
  final assetLocationService = AssetLocationService();
  final sectionService = SectionTypeService();
  String? city;
  String? country;
  String? location;
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
                  title: Language.isEn ? lang.textEn['capture_header_title']! : lang.textAr['capture_header_title']!,
                  subTitle: Language.isEn ? lang.textEn['capture_header_subTitle']! : lang.textAr['capture_header_subTitle']!,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: SizedBox(
                    height: dSize.height * 0.58,
                    child: SingleChildScrollView(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(
                              lang.getTxt('asset_information_title'),
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF0F6671),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            children: [
                              CustomWidgetBuilder.buildText(lang.getTxt('country'), dSize),
                              Spacer(),
                              Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Color(0xFF00B0BD), width: 2))),
                                width: dSize.width * 0.5,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: country,
                                    iconSize: 20,
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      color: Color(0xFF00B0BD),
                                    ),
                                    isDense: true,
                                    isExpanded: true,
                                    items: countries
                                        .map((e) => e.name)
                                        .map((String item) {
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                              color: Color(0xFF0F6671),
                                              fontSize: 15),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        country = val;
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
                                    items: cities
                                        .map((e) => e.name)
                                        .map((String item) {
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                              color: Color(0xFF0F6671),
                                              fontSize: 15),
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
                          CustomWidgetBuilder.buildTextFormField(dSize, lang.getTxt('area'),
                              areas.isNotEmpty ? areas[0].name : 'area', false),
                          SizedBox(
                            height: dSize.height * 0.01,
                          ),
                          Row(
                            children: [
                              CustomWidgetBuilder.buildText(
                                  lang.getTxt('location_type'), dSize),
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
                          SizedBox(
                            height: dSize.height * 0.015,
                          ),
                          if (location == MyConfig.OFFICE ||
                              location == MyConfig.BUILDING)
                            Row(
                              children: [
                                CustomWidgetBuilder.buildText(lang.getTxt('floor'), dSize),
                                Spacer(),
                                Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Color(0xFF00B0BD),
                                              width: 2))),
                                  width: dSize.width * 0.5,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: floor,
                                      iconSize: 20,
                                      icon: const Icon(
                                        Icons.arrow_drop_down,
                                        color: Color(0xFF00B0BD),
                                      ),
                                      isDense: true,
                                      isExpanded: true,
                                      items: floors
                                          .map((e) => e.name).toSet().toList()
                                          .map((String item) {
                                        return DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                                color: Color(0xFF0F6671),
                                                fontSize: 15),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                        setState(() {
                                          floor = val;
                                        });
                                        getSectionsByFloor();
                                        print('-----${sectionsPerFloor.length}------');
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          SizedBox(
                            height: dSize.height * 0.01,
                          ),
                          if (location == MyConfig.OFFICE ||
                              location == MyConfig.BUILDING ||
                              location == MyConfig.STORE)
                            Row(
                              children: [
                                CustomWidgetBuilder.buildText(
                                    lang.getTxt('section'), dSize),
                                Spacer(),
                                Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Color(0xFF00B0BD),
                                              width: 2))),
                                  width: dSize.width * 0.5,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: section,
                                      iconSize: 20,
                                      icon: const Icon(
                                        Icons.arrow_drop_down,
                                        color: Color(0xFF00B0BD),
                                      ),
                                      isDense: true,
                                      isExpanded: true,
                                      items: sectionsPerFloor
                                          .map((e) => e.name).toSet().toList()
                                          .map((String item) {
                                        return DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                                color: Color(0xFF0F6671),
                                                fontSize: 15),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                        setState(() {
                                          section = val;
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
                          if (location == MyConfig.OFFICE)
                            Row(
                              children: [
                                CustomWidgetBuilder.buildText(
                                    lang.getTxt('department'), dSize),
                                Spacer(),
                                Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Color(0xFF00B0BD),
                                              width: 2))),
                                  width: dSize.width * 0.5,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: department,
                                      iconSize: 20,
                                      icon: const Icon(
                                        Icons.arrow_drop_down,
                                        color: Color(0xFF00B0BD),
                                      ),
                                      isDense: true,
                                      isExpanded: true,
                                      items: departments.toSet().toList()
                                          .map((e) => e.name)
                                          .map((String item) {
                                        return DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                                color: Color(0xFF0F6671),
                                                fontSize: 15),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                        setState(() {
                                          department = val;
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
                          Icon(Icons.arrow_back_ios_rounded),
                          () => Navigator.of(context).pop()),
                      CustomWidgetBuilder.buildArrow(
                          context,
                          dSize,
                          Icon(Icons.arrow_forward_ios),
                          () => moveToAssetsCapture()),
                    ],
                  ),
                ),
                const Footer()
              ],
            ),
          ),
        ),
      )),
    );
  }

  initData() async {
    cities = await cityService.retrieve();
    countries = await countryService.retrieve();
    if(countries.isNotEmpty){
      countries = [...{...countries}];
      country = countries[0].name;
    }
    city = cities.isNotEmpty ? cities[0].name : "";
    floors = await floorService.retrieve();
    departments = await departmentService.retrieve();
    areas = await areaService.retrieve();
    sections = await sectionService.retrieve();
    assetLocationService.retrieve().then((value) {
      setState(() {
        if (value.isNotEmpty) {
          assetLocation = value[0];
          locations = [assetLocation.locationTypeName];
          location = assetLocation.locationTypeName;
          if (location == MyConfig.BUILDING ) {
            if(assetLocation.sectionId != null){
            section = sections
                .firstWhere((element) => element.id == assetLocation.sectionId)
                .name;}
            if(assetLocation.floorId != null){
            floor = floors
                .firstWhere((element) => element.id == assetLocation.floorId)
                .name;
            getSectionsByFloor();}
          } else if (location == MyConfig.STORE &&
              assetLocation.sectionId != null) {
            section = sections
                .firstWhere((element) => element.id == assetLocation.sectionId)
                .name;
          } else if (location == MyConfig.OFFICE ) {
            if(assetLocation.sectionId != null){
              section = sections
                  .firstWhere((element) => element.id == assetLocation.sectionId)
                  .name;}
            if(assetLocation.floorId != null){
              floor = floors
                  .firstWhere((element) => element.id == assetLocation.floorId)
                  .name;
              getSectionsByFloor();}
            if(assetLocation.departmentId != null){
            department = departments
                .firstWhere(
                    (element) => element.id == assetLocation.departmentId)
                .name;}
          }
        }
      });
    });
    setState(() {});
  }

  moveToAssetsCapture() {
    if (!validateData()) {
      CustomWidgetBuilder.showMessageDialog(context, lang.getTxt('validation'),true);
    } else {
      int? departmentId ;
      int?sectionId;
      int?floorId;
      if(departments.isNotEmpty && department != null){
        departmentId = departments.firstWhere((element) => element.name == department).id;
      }
      if(sections.isNotEmpty && section != null){
        sectionId = sections.firstWhere((element) => element.name == section).id;
      }
      if(floors.isNotEmpty && floor != null){
        floorId = floors.firstWhere((element) => element.name == floor).id;
      }
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AssetsCapture(
                assetLocation: assetLocation,
                departmentId: departmentId,
                sectionId: sectionId,
                floorId: floorId,
              )));
    }
  }

  bool validateData() {
    return (location == MyConfig.OFFICE &&
            department != null &&
            floor != null &&
            section != null) ||
        (location == MyConfig.STORE && section != null) ||
        (location == MyConfig.BUILDING && floor != null && section != null);
  }

  getSectionsByFloor(){
    setState(() {
      section = null;
      final floorId = floors
          .firstWhere((element) => element.name == floor)
          .id;

      sectionsPerFloor = sections.where((sec) => sec.floorId == floorId).toList();
      if(sectionsPerFloor.isNotEmpty) {
        section = sectionsPerFloor
            .firstWhere((element) => element.id == assetLocation.sectionId)
            .name;
      }
    });
  }
}
