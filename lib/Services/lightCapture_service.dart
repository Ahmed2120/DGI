import 'dart:convert';

import '../Utility/configration.dart';
import '../db/captureLight.dart';
import '../model/building.dart';
import '../model/description.dart';
import '../model/floor.dart';
import '../model/item.dart';
import '../model/sectionType.dart';
import 'package:http/http.dart' as http;

class LightCaptureService{

  static List<DescriptionLight> severDescriptions = [];
  static List<SectionType> severSections = [];
  static List<Building> severBuildings = [];
  static List<Item> severItems = [];

  Future<List<DescriptionLight>> getAllDescriptions(int itemId) async {
    final queryParameters = {
      'ItemId': itemId.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;

    final response = await http
        .get(Uri.parse('${MyConfig.SERVER}${MyConfig.DESCRIPTION_BYITEMID}?$queryString'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      severDescriptions = parsed
          .map<DescriptionLight>((json) => DescriptionLight.fromMap(json))
          .toList();
      return parsed
          .map<DescriptionLight>((json) => DescriptionLight.fromMap(json))
          .toList();
    } else {
      throw Exception('Failed to load description');
    }
  }

  Future<String> getAllBuildings() async  {
    final response = await http
        .get(Uri.parse("${MyConfig.SERVER}${MyConfig.BUILDING_API}"));
    print(response.body);
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      severBuildings = parsed.map<Building>((json) => Building.fromMap(json)).toList();
      return "Success";
    } else {
      throw Exception('Failed to load Buildings');
    }
  }

  Future<List<Floor>> getAllFloors(int buildingId) async  {
    final queryParameters = {
      'buildingId': buildingId.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    final response = await http
        .get(Uri.parse("${MyConfig.SERVER}${MyConfig.FLOOR_ByBuildingId}?$queryString"));
    print(response.body);
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      // severFloors = parsed.map<Floor>((json) => Floor.fromMap(json)).toList();
      return parsed.map<Floor>((json) => Floor.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load floors');
    }
  }

  Future<List<SectionType>> getAllSections(int floorId) async {
    final queryParameters = {
      'FloorId': floorId.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    final response = await http.get(
        Uri.parse('${MyConfig.SERVER}${MyConfig.SECTION_ByFloorId}?$queryString'));
    print(response.body);
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      severSections = parsed
          .map<SectionType>((json) => SectionType.fromMap(json))
          .toList();
      return parsed
          .map<SectionType>((json) => SectionType.fromMap(json))
          .toList();
    } else {
      throw Exception('Failed to load sections');
    }
  }

  Future<List<Item>> getAllItems() async {
    final response =
    await http.get(Uri.parse('${MyConfig.SERVER}${MyConfig.ITEM_API}'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      severItems = parsed.map<Item>((json) => Item.fromMap(json)).toList();
      return parsed.map<Item>((json) => Item.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }

  uploadToServer(CaptureLight captureLight,) async {
    print(captureLight.image);

    final response =
    await http.post(Uri.parse('${MyConfig.SERVER}${MyConfig.UPLOAD_CaptureLight}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(captureLight.toMap()));
    final responseJson = jsonDecode(response.body);
    print(responseJson);
    if (response.statusCode == 200 && responseJson["Succeeded"]) {
      return true;
    } else if (responseJson != null && responseJson["Message"] != null) {
      throw Exception(responseJson["Message"]);
    } else {
      _handleStatusCode(response.statusCode);
    }
  }

  void _handleStatusCode(int statusCode) {
    if (statusCode == 404) {
      throw Exception("Invalid IP Address");
    } else if (statusCode == 401) {
      throw Exception("Unauthorized");
    } else if (statusCode == 500) {
      throw Exception("Server Error");
    } else {
      throw Exception("Something does wen't wrong");
    }
  }
}