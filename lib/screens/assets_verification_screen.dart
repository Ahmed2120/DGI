import 'package:dgi/Services/CategoryService.dart';
import 'package:dgi/Services/SectionTypeService.dart';
import 'package:dgi/Utility/CustomWidgetBuilder.dart';
import 'package:dgi/model/category.dart';
import 'package:dgi/model/sectionType.dart';
import 'package:dgi/screens/assets_details.dart';
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
import 'package:dgi/model/department.dart';
import 'package:dgi/model/floor.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../Services/MainCategoryService.dart';
import '../Utility/CustomWidgetBuilder.dart';
import '../Utility/footer.dart';
import '../Utility/header.dart';
import '../language.dart';
import '../model/mainCategory.dart';

class AssetsVerification extends StatefulWidget {
  const AssetsVerification({Key? key}) : super(key: key);

  @override
  State<AssetsVerification> createState() => _AssetsVerificationState();
}

class _AssetsVerificationState extends State<AssetsVerification> {
  //List<Country> countries = [];
  List<City> cities = [];
  List<Floor> floors = [];
  List<Department> departments=[];
  List<Area> areas =[];
  List<SectionType> sections =[];
  String? _section;
  String? _floor;
  AssetLocation assetLocation = AssetLocation(id:1, name: '', buildingAddress: '', buildingName: '', buildingNo: '',
      businessUnit: '', areaId: 1, departmentId: 1, floorId: 1,sectionId: 10,locationTypeName: 'Building',locationType: 1);
  final countryService = CountryService();
  final cityService = CityService();
  final floorService = FloorService();
  final areaService = AreaService();
  final departmentService = DepartmentService();
  final assetLocationService = AssetLocationService();
  final categoryService = CategoryService();
  final mainCategoryService = MainCategoryService();
  final sectionService = SectionTypeService();
  TextEditingController? category = TextEditingController();
  TextEditingController? mainCategory = TextEditingController();
  TextEditingController? city = TextEditingController();
  String? location;
  MainCategory? _main;
  List<String> locations = [];
  final GlobalKey<FormState> _formKey = GlobalKey();

  final lang = Language();

  @override
  void initState() {
    // TODO: implement initState
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
          child: Container(
            height: dSize.height - bottomPadding,
            child: Column(
              children: [
                Header(
                  title: lang.getTxt('verification_header_title'),
                  subTitle: lang.getTxt('verification_header_subTitle'),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  child: SizedBox(
                    height: dSize.height * 0.58,
                    child: Form(
                      key: _formKey,
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
                                  child: TypeAheadField<City>(
                                    textFieldConfiguration: TextFieldConfiguration(
                                        style: TextStyle(fontSize: dSize.height <= 500 ? 10 : dSize.height * 0.02),
                                        controller: this.city,
                                        decoration: InputDecoration(
                                          constraints: BoxConstraints(minHeight: 2, maxHeight: 30),
                                          suffixIcon: const Icon(
                                            Icons.arrow_drop_down,
                                            color: Color(0xFF00B0BD),
                                            size: 20,
                                          ),
                                          contentPadding: EdgeInsets.all(
                                              dSize.height <= 600
                                                  ? dSize.height * 0.015
                                                  : 4),
                                          isDense: true,
                                          border: InputBorder.none,
                                        )
                                    ),
                                    suggestionsCallback: getCitiesSuggestion,
                                    itemBuilder: (context, suggestion) {
                                      return ListTile(
                                        title: Text(suggestion.name, style: const TextStyle(
                                            color: Color(0xFF0F6671),
                                            fontSize: 15),),
                                      );
                                    },
                                    onSuggestionSelected: (suggestion){
                                      city!.text = suggestion.name;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: dSize.height * 0.01,
                            ),
                            CustomWidgetBuilder.buildTextFormField(dSize, lang.getTxt('area'),
                                areas.isNotEmpty ? areas[0].name : 'dump',false),
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
                              height: dSize.height * 0.01,
                            ),
                            // if (location == 'Office' || location == 'Building')
                              CustomWidgetBuilder.buildTextFormField(
                                  dSize,
                                  lang.getTxt('floor'),
                                  floors.isNotEmpty ? _floor : '0',false),
                            SizedBox(
                              height: dSize.height * 0.01,
                            ),
                            // if (location == 'Office' || location == 'Building')
                              CustomWidgetBuilder.buildTextFormField(
                                  dSize,
                                  lang.getTxt('section'),
                                  sections.isNotEmpty ? _section : '0',false),
                            SizedBox(
                              height: dSize.height * 0.01,
                            ),
                            // if (location == 'Office' || location == 'Store')
                            //   CustomWidgetBuilder.buildTextFormField(
                            //       dSize,
                            //       'DEPARTMENT',
                            //       departments.isNotEmpty ? departments[0].name : '0',false),
                            SizedBox(
                              height: dSize.height * 0.01,
                            ),
                          ],
                        ),
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
      )),
    );
  }

  initData() async{
    cities = await cityService.retrieve();
    city!.text = cities.isNotEmpty?cities[0].name:"";
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
          _section = sections.firstWhere((sec) => sec.id == assetLocation.sectionId, orElse: ()=> SectionType(name: '')).name;
          _floor = floors.firstWhere((flr) => flr.id == assetLocation.floorId, orElse: ()=> Floor(name: '')).name;
        }
      });
    });
    setState(() {

    });
  }
  

  List<City> getCitiesSuggestion(String query) {
    return cities.where((e) {
      final nameLower = e.name.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();
  }

}
