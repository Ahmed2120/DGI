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
  final City city;
  final Country country;
  final SectionType? section;

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
        this.section
      });

  AssetLocationResponse.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        name = res["Name"],
        businessUnit = res["BusinessUnit"],
        buildingAddress = res["BuildingAddress"],
        buildingName = res["BuildingName"],
        buildingNo = res["BuildingNo"],
        areaId = res["AreaId"],
        departmentId = res["DepartmentId"],
        floorId = res["FloorId"],
        sectionId = res["SectionId"],
        locationType = res["LocationType"],
        locationTypeName = res["LocationTypeName"],
        floor = res["Floor"] != null ? Floor.fromMap(res["Floor"]):null,
        area = Area.fromMap(res["Area"]),
        department = res["Department"]!=null ? Department.fromMap(res["Department"]):null,
        section = res["Section"]!=null ? SectionType.fromMap(res["Section"]):null,
        city = City.fromMap(res["City"]),
        country = Country.fromMap(res["Country"]);


  Map<String, Object?> toMap() {
    return {'Id':id,'Name': name,'BusinessUnit':businessUnit,'BuildingAddress':buildingAddress,'BuildingName':buildingName,
      'BuildingNo':buildingNo,'AreaId':areaId,'DepartmentId':departmentId,'FloorId':floorId,'SectionId':sectionId,
      'LocationType': locationType, 'LocationTypeName': locationTypeName,'Floor':floor?.toMap(),'Area':area.toMap(),
    'Department':department?.toMap(),'City':city.toMap(),'Country':country.toMap(),'Section':section};
  }
}