import 'package:dgi/model/area.dart';
import 'package:dgi/model/city.dart';
import 'package:dgi/model/country.dart';
import 'package:dgi/model/department.dart';
import 'package:dgi/model/floor.dart';
import 'package:dgi/model/sectionType.dart';

class AssetLocationResponse{
  final int id;
  final int areaId;
  final String? businessUnit;
  final int? departmentId;
  final String? name;
  final String? buildingName;
  final String? buildingAddress;
  final String? buildingNo;
  final int? floorId;
  final int? sectionId;
  final int locationType;
  final String locationTypeName;
  final Floor? floor;
  final Area area;
  final Department? department;
  final String compoundName;
  final String cityName;
  final String governorateName;
  final String countryName;
  final SectionType? section;
  final City city;
  final Country country;

  AssetLocationResponse(
      { required this.id,
        this.name,
        this.buildingAddress,
        this.buildingName,
        this.buildingNo,
        this.businessUnit,
        required this.areaId,
        required this.departmentId,
        required this.floorId,
        required this.sectionId,
        required this.locationType,
        required this.locationTypeName,
        this.floor,
        required this.area,
        this.department,
        required this.country,
        required this.city,
        required this.compoundName,
        required this.cityName,
        required this.countryName,
        required this.governorateName,
        this.section
      });

  AssetLocationResponse.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        name = res["Name"],
        businessUnit = res["BusinessUnit"],
        buildingAddress = res["BuildingAddress"],
        buildingName = res["Section"]["Floor"]["Building"]["Name"],
        buildingNo = res["BuildingNo"],
        areaId = res["AreaId"],
        departmentId = res["DepartmentId"],
        floorId = res["FloorId"],
        sectionId = res["SectionId"],
        locationType = res["LocationType"],
        locationTypeName = res["LocationTypeName"],
        floor = res["Floor"] != null ? Floor.fromMap(res["Section"]["Floor"]):null,
        area = Area.fromMap(res["Section"]["Floor"]["Building"]["Area"]),
        department = res["Department"]!=null ? Department.fromMap(res["Department"]):null,
        section = res["Section"]!=null ? SectionType.fromMap(res["Section"]):null,
        city = City.fromMap(res["Section"]["Floor"]["Building"]["Area"]["Compound"]["City"]),
        country = Country.fromMap(res["Section"]["Floor"]["Building"]["Area"]["Compound"]["City"]["Governerate"]["Country"]),
        compoundName = res["Section"]["Floor"]["Building"]["Area"]["Compound"]["NameInArabic"],
        cityName = res["Section"]["Floor"]["Building"]["Area"]["Compound"]["City"]["Name"],
        governorateName = res["Section"]["Floor"]["Building"]["Area"]["Compound"]["City"]["Governerate"]["NameInArabic"],
        countryName = res["Section"]["Floor"]["Building"]["Area"]["Compound"]["City"]["Governerate"]["Country"]["Name"];



      Map<String, Object?> toMap() {
    return {'Id':id,'Name': name,'BusinessUnit':businessUnit,'BuildingAddress':buildingAddress,'BuildingName':buildingName,
      'BuildingNo':buildingNo,'AreaId':areaId,'DepartmentId':departmentId,'FloorId':floorId,'SectionId':sectionId,
      'LocationType': locationType, 'LocationTypeName': locationTypeName,'Floor':floor?.toMap(),'Area':area.toMap(),
    'Department':department?.toMap(),'City':city.toMap(),'Country':country.toMap(),'Section':section};
  }
}