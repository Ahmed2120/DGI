import 'package:dgi/model/area.dart';
import 'package:dgi/model/department.dart';
import 'package:dgi/model/floor.dart';

class AssetLocationResponse{
  final int id;
  final int areaId;
  final String businessUnit;
  final int? departmentId;
  final String name;
  final String? buildingName;
  final String? buildingAddress;
  final String? buildingNo;
  final int? floorId;
  final int? sectionId;
  final int locationType;
  final String locationTypeName;
  final Floor floor;
  final Area area;
  final Department department;

  AssetLocationResponse(
      { required this.id,
        required this.name,
        this.buildingAddress,
        this.buildingName,
        this.buildingNo,
        required this.businessUnit,
        required this.areaId,
        required this.departmentId,
        required this.floorId,
        required this.sectionId,
        required this.locationType,
        required this.locationTypeName,
        required this.floor,
        required this.area,
        required this.department
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
        floor = Floor.fromMap(res["Floor"]),
        area = Area.fromMap(res["Area"]),
        department = Department.fromMap(res["Department"]);


  Map<String, Object?> toMap() {
    return {'Id':id,'Name': name,'BusinessUnit':businessUnit,'BuildingAddress':buildingAddress,'BuildingName':buildingName,
      'BuildingNo':buildingNo,'AreaId':areaId,'DepartmentId':departmentId,'FloorId':floorId,'SectionId':sectionId,
      'LocationType': locationType, 'LocationTypeName': locationTypeName,'Floor':floor.toMap(),'Area':area.toMap(),
    'Department':department.toMap()};
  }
}