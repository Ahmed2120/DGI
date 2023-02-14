import 'dart:convert';
import 'dart:io';

import '../Utility/configration.dart';
import '../db/DatabaseHandler.dart';
import '../db/captureLight.dart';
import '../model/AssetVerificationResponse.dart';
import '../model/asset.dart';
import '../model/description.dart';
import '../model/floor.dart';
import '../model/item.dart';
import '../model/sectionType.dart';
import 'package:http/http.dart' as http;

import 'AssetService.dart';

class LightVerificationService{

  static List<DescriptionLight> severDescriptions = [];
  static List<SectionType> severSections = [];
  static List<Floor> severFloors = [];
  static List<Item> severItems = [];
  static List<Asset> assets = [];
  static int totalPages = 1;
  static int totalRecords = 0;

  downloadAssets(int pageNum, int sectionId) async {
    print(sectionId);
    AssetService assetService = AssetService();
    try {
      AssetVerificationResponse? assetVerificationResponse =
      await getAssets(pageNum, sectionId);
      if (assetVerificationResponse == null) {
        throw Exception("there is no data");
      } else {
        assets = assetVerificationResponse.assets;
        totalPages = assetVerificationResponse.totalPages;
        totalRecords = assetVerificationResponse.totalRecords;
      }
    } catch (e) {
      await clearData();
      rethrow;
    }
  }

  getAssets(int pageNumber, int sectionId) async {
    final myConfig = MyConfig.ASSET_LightVERFICATION;
    final queryParameters = {
      'pageNumber': pageNumber.toString(),
      'pageSize': '5',
      'sectionId': sectionId.toString()
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    final uri =
        '${MyConfig.SERVER}${myConfig}' + '?' + queryString;
    try {
      final response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        if (responseJson == null) {
          throw Exception('This is no asset data assign to transaction');
        }
        return AssetVerificationResponse.fromMap(json.decode(response.body));
      } else {
        _handleStatusCode(response.statusCode);
      }
    } on SocketException {
      throw Exception(
          'Failed to connect to server make sure you connect to the internet');
    } on FormatException {
      throw Exception("Bad response");
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> getAllFloors() async  {
    final response = await http
        .get(Uri.parse("${MyConfig.SERVER}${MyConfig.FLOOR_WithoutId}"));
    print(response.body);
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      severFloors = parsed.map<Floor>((json) => Floor.fromMap(json)).toList();
      return "Success";
    } else {
      throw Exception('Failed to load floors');
    }
  }

  Future<String> getAllSections() async {
    // String queryString = Uri(queryParameters: queryParameters).query;
    final response = await http.get(
        Uri.parse('${MyConfig.SERVER}${MyConfig.ALL_SECTION}'));
    print(response.body);
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      severSections = parsed
          .map<SectionType>((json) => SectionType.fromMap(json))
          .toList();
      return 'Success';
    } else {
      throw Exception('Failed to load sections');
    }
  }

  uploadToServer(List<int> assetIDs,) async {

    final request = {"AssetIDs" : assetIDs};
    final response =
    await http.post(Uri.parse('${MyConfig.SERVER}${MyConfig.UPLOAD_VerificationLight}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(request));
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

  clearData() async {
    final dataHandler = DatabaseHandler();
    await dataHandler.clearData();
  }
}