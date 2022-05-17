import 'dart:convert';
import 'dart:io';
import 'package:dgi/Services/AreaService.dart';
import 'package:dgi/Services/AssetLocationService.dart';
import 'package:dgi/Services/AssetService.dart';
import 'package:dgi/Services/CaptureDetailsService.dart';
import 'package:dgi/Services/CategoryService.dart';
import 'package:dgi/Services/CityService.dart';
import 'package:dgi/Services/CountryService.dart';
import 'package:dgi/Services/DepartmentService.dart';
import 'package:dgi/Services/FloorService.dart';
import 'package:dgi/Services/ItemService.dart';
import 'package:dgi/Services/MainCategoryService.dart';
import 'package:dgi/Services/SectionTypeService.dart';
import 'package:dgi/Services/SettingService.dart';
import 'package:dgi/Services/TransactionService.dart';
import 'package:dgi/Services/UserService.dart';
import 'package:dgi/db/DatabaseHandler.dart';
import 'package:dgi/model/AssetVerificationResponse.dart';
import 'package:dgi/model/CaptuerDeatailsList.dart';
import 'package:dgi/model/CaptureDetails.dart';
import 'package:dgi/model/CaptureDetailsRequest.dart';
import 'package:dgi/model/assetLocation.dart';
import 'package:dgi/model/category.dart';
import 'package:dgi/model/department.dart';
import 'package:dgi/model/floor.dart';
import 'package:dgi/model/item.dart';
import 'package:dgi/model/mainCategory.dart';
import 'package:dgi/model/sectionType.dart';
import 'package:dgi/model/settings.dart';
import 'package:dgi/model/transaction.dart';
import 'package:dgi/model/transcationResponse.dart';
import 'package:http/http.dart' as http;
import 'package:dgi/Utility/configration.dart';
import 'package:dgi/model/country.dart';

class ServerService{

  SettingService settingService = SettingService();

  Future<List<Country>> getAllCountries() async{
    if(MyConfig.SERVER == ''){
      await setServerIPAddress();
    }
    final response = await http
        .get(Uri.parse('${MyConfig.SERVER}${MyConfig.COUNTRY_API}'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Country>((json) => Country.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load countries');
    }
  }

  Future<List<MainCategory>> getAllMainCategories() async{
    if(MyConfig.SERVER == ''){
      await setServerIPAddress();
    }
    final response = await http
        .get(Uri.parse('${MyConfig.SERVER}${MyConfig.MAIN_CATEGORY_API}'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<MainCategory>((json) => MainCategory.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load main categories');
    }
  }

  Future<List<Category>> getAllCategories() async{
    if(MyConfig.SERVER == ''){
      await setServerIPAddress();
    }
    final response = await http
        .get(Uri.parse('${MyConfig.SERVER}${MyConfig.CATEGORY_API}'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Category>((json) => Category.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<Item>> getAllItems() async{
    if(MyConfig.SERVER == ''){
      await setServerIPAddress();
    }
    final response = await http
        .get(Uri.parse('${MyConfig.SERVER}${MyConfig.ITEM_API}'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Item>((json) => Item.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }

  Future<List<Department>> getAllDepartments() async{
    if(MyConfig.SERVER == ''){
      await setServerIPAddress();
    }
    final response = await http
        .get(Uri.parse('${MyConfig.SERVER}${MyConfig.DEPARTMENT_API}'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Department>((json) => Department.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load department');
    }
  }

  Future<List<SectionType>> getAllSections() async{
    if(MyConfig.SERVER == ''){
      await setServerIPAddress();
    }
    final response = await http
        .get(Uri.parse('${MyConfig.SERVER}${MyConfig.SECTION_API}'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<SectionType>((json) => SectionType.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load sections');
    }
  }

  Future<List<Floor>> getAllFloors() async{
    if(MyConfig.SERVER == ''){
      await setServerIPAddress();
    }
    final response = await http
        .get(Uri.parse("${MyConfig.SERVER}${MyConfig.FLOOR_API}"));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Floor>((json) => Floor.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load floors');
    }
  }

  Future<TransactionResponse?> getTransaction(String pdaNo) async{
    if(MyConfig.SERVER == ''){
      await setServerIPAddress();
    }
    final queryParameters = {
      'PDANo': pdaNo,
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    final uri = '${MyConfig.SERVER}${MyConfig.TRANSACTION_API}' + '?' + queryString;
    try{
      final response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        if(responseJson != null && responseJson["Succeeded"] != null && ! responseJson["Succeeded"]){
          return null;
        }
        if(responseJson == null){
          throw Exception('This PDANo not assign to transaction');
        }
        return TransactionResponse.fromMap(json.decode(response.body));
      }else {
        _handleStatusCode(response.statusCode);
      }
    }on SocketException{
      throw Exception('Failed to connect to server make sure you connect to the internet');
    } catch(e){
      throw Exception(e);
    }
  }

  syncro(String pdaNo) async{
    if(MyConfig.SERVER == ''){
      await setServerIPAddress();
    }
    final floorService = FloorService();
    final areaService = AreaService();
    final departmentService = DepartmentService();
    final assetLocationService = AssetLocationService();
    final userService = UserService();
    final transactionService = TransactionService();
    final countryService = CountryService();
    final categoryService = CategoryService();
    final itemService = ItemService();
    final mainCategoryService = MainCategoryService();
    final cityService = CityService();
    final sectionService = SectionTypeService();
    TransactionResponse? response = await getTransaction(pdaNo);
    if(response == null){
      return "Error in Synchronization please try again later";
    }else{
      List<Category> categories = await getAllCategories();
      List<MainCategory> mainCategories = await getAllMainCategories();
      List<Item> items = await getAllItems();
      List<Department> departments = await getAllDepartments();
      List<SectionType> sections = await getAllSections();
      List<Floor> floors = await getAllFloors();
      await assetLocationService.insert(AssetLocation(
          id: response.assetLocation.id,
          name: response.assetLocation.name,
          buildingAddress: response.assetLocation.buildingAddress,
          buildingName: response.assetLocation.buildingName,
          buildingNo: response.assetLocation.buildingNo,
          businessUnit: response.assetLocation.businessUnit,
          areaId: response.assetLocation.areaId,
          departmentId: response.assetLocation.departmentId,
          floorId: response.assetLocation.floorId,
          sectionId: response.assetLocation.sectionId,
          locationType:response.assetLocation.locationType,
          locationTypeName: response.assetLocation.locationTypeName));
      await userService.insert(response.user);
      await areaService.insert(response.assetLocation.area);
      await transactionService.insert(TransactionLookUp(
          id: response.id,
          transactionType: response.transactionType,
          transActionTypeName: response.transActionTypeName));
      await countryService.insert(response.assetLocation.country);
      await cityService.insert(response.assetLocation.city);
      await mainCategoryService.batch(mainCategories);
      await itemService.batch(items);
      await categoryService.batch(categories);
      await departmentService.batch(departments);
      await sectionService.batch(sections);
      await floorService.batch(floors);
      if(response.transactionType == 2){
        await downloadAssets(response.id);
      }
      return "Success";
    }
  }
  downloadAssets(int transactionId) async {
    AssetService assetService = AssetService();
    try{
      AssetVerificationResponse ? assetVerificationResponse = await getAssets(1, transactionId);
      if(assetVerificationResponse == null) {
        throw Exception("there is no data");
      }else{
        await assetService.batch(assetVerificationResponse.assets);
        for(int i=2;i<=assetVerificationResponse!.totalPages;i++){
          assetVerificationResponse = await getAssets(i, transactionId);
          await assetService.batch(assetVerificationResponse!.assets);
          print(assetVerificationResponse.assets[i].sectionId);
        }
      }
    }catch(e){
      await clearData();
      rethrow;
    }
  }
  getAssets(int pageNumber,int transactionId)async{
    if(MyConfig.SERVER == ''){
      await setServerIPAddress();
    }
    final queryParameters = {
      'pageNumber': pageNumber.toString(),
      'pageSize': MyConfig.PAGE_SIZE.toString(),
      'transactionId':transactionId.toString()
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    final uri = '${MyConfig.SERVER}${MyConfig.ASSET_VERFICATION}' + '?' + queryString;
    try{
      final response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        if(responseJson == null){
          throw Exception('This is no asset data assign to transaction');
        }
        return AssetVerificationResponse.fromMap(json.decode(response.body));
      }else {
        _handleStatusCode(response.statusCode);
      }
    }on SocketException {
      throw Exception(
          'Failed to connect to server make sure you connect to the internet');
    } on FormatException{
        throw Exception("Bad response");
    } catch(e){
      throw Exception(e);
    }

  }

  uploadData()async{
    final captureService = CaptureDetailsService();
    final transactionService = TransactionService();
    List<TransactionLookUp> transactions = await transactionService.retrieve();
    if(MyConfig.SERVER == ''){
      await setServerIPAddress();
    }
    try{
      while(true){
        List<CaptureDetails> captureDetails = await captureService.retrieveTopElement();
        if(captureDetails.isEmpty) {
          break;
        }
        await uploadToServer(captureDetails, transactions[0]);
        await captureService.update(captureDetails);
      }
    }on SocketException{
      throw Exception('Failed to connect to server make sure you connect to the internet');
    }on FormatException{
      throw Exception("Bad response");
    }catch(e){
      rethrow;
    }
  }

  uploadToServer(List<CaptureDetails> captureDetails,TransactionLookUp transaction) async {
    List<CaptureDetailsRequest> captureDetailsList = captureDetails.map((e) =>
        CaptureDetailsRequest(quantity: e.quantity,image: e.image,description: e.description,id: e.id,
            departmentId: e.departmentId,floorId: e.floorId,sectionId: e.sectionId,serialNumber: e.serialNumber,
            assetLocationId: e.assetLocationId,itemId: e.itemId,transactionId: transaction.id,color: e.color,
            height: e.height,length: e.length,width: e.width)).toList();
    CaptureDetailsList request = CaptureDetailsList(captureDetailsList: captureDetailsList);
    print('====' + jsonEncode(request));
    final response = await http.post(
        Uri.parse('${MyConfig.SERVER}${MyConfig.UPLOAD_API}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(request)
    );
    final responseJson = jsonDecode(response.body);
    if(response.statusCode == 200 && responseJson["Succeeded"]) {
      return true;
    }else if(responseJson != null && responseJson["Message"] != null){
      throw Exception(responseJson["Message"]);
    }else{
      _handleStatusCode(response.statusCode);
    }
  }

  clearData()async{
    final dataHandler = DatabaseHandler();
    await dataHandler.clearData();
  }

  // uploadAssetVerification()async{
  //   List<CaptureDetailsRequest> captureDetailsList = captureDetails.map((e) =>
  //       CaptureDetailsRequest(quantity: e.quantity,image: e.image,description: e.description,id: e.id,
  //           departmentId: e.departmentId,floorId: e.floorId,sectionId: e.sectionId,serialNumber: e.serialNumber,
  //           assetLocationId: e.assetLocationId,itemId: e.itemId,transactionId: transaction.id,color: e.color,
  //           height: e.height,length: e.length,width: e.width)).toList();
  //   CaptureDetailsList request = CaptureDetailsList(captureDetailsList: captureDetailsList);
  //   print('====' + jsonEncode(request));
  //   final response = await http.post(
  //       Uri.parse('${MyConfig.SERVER}${MyConfig.UPLOAD_API}'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(request)
  //   );
  //   final responseJson = jsonDecode(response.body);
  //   if(response.statusCode == 200 && responseJson["Succeeded"]) {
  //     return true;
  //   }else if(responseJson != null && responseJson["Message"] != null){
  //     throw Exception(responseJson["Message"]);
  //   }else{
  //     _handleStatusCode(response.statusCode);
  //   }
  // }

  setServerIPAddress()async{
    List<Setting> settings = await settingService.retrieve();
    if(settings.isNotEmpty){
      MyConfig.SERVER = settings[0].ipAddress;
    }else{
      throw Exception("Fail to get setting");
    }
  }

  void _handleStatusCode(int statusCode) {
    if(statusCode == 404){
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
