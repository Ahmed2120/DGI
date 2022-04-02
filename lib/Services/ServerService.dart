import 'dart:convert';
import 'package:dgi/Services/AreaService.dart';
import 'package:dgi/Services/AssetLocationService.dart';
import 'package:dgi/Services/CaptureDetailsService.dart';
import 'package:dgi/Services/CategoryService.dart';
import 'package:dgi/Services/CountryService.dart';
import 'package:dgi/Services/DepartmentService.dart';
import 'package:dgi/Services/FloorService.dart';
import 'package:dgi/Services/ItemService.dart';
import 'package:dgi/Services/MainCategoryService.dart';
import 'package:dgi/Services/TransactionService.dart';
import 'package:dgi/Services/UserService.dart';
import 'package:dgi/model/CaptureDetails.dart';
import 'package:dgi/model/CaptureDetailsRequest.dart';
import 'package:dgi/model/assetLocation.dart';
import 'package:dgi/model/category.dart';
import 'package:dgi/model/item.dart';
import 'package:dgi/model/mainCategory.dart';
import 'package:dgi/model/transaction.dart';
import 'package:dgi/model/transcationResponse.dart';
import 'package:http/http.dart' as http;
import 'package:dgi/Utility/configration.dart';
import 'package:dgi/model/country.dart';

class ServerService{

  Future<List<Country>> getAllCountries() async{
    final response = await http
          .get(Uri.parse(MyConfig.COUNTRY_API));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Country>((json) => Country.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load countries');
    }
  }

  Future<List<MainCategory>> getAllMainCategories() async{
    final response = await http
        .get(Uri.parse(MyConfig.MAIN_CATEGORY_API));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<MainCategory>((json) => MainCategory.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load main categories');
    }
  }

  Future<List<Category>> getAllCategories() async{
    final response = await http
        .get(Uri.parse(MyConfig.CATEGORY_API));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Category>((json) => Category.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<Item>> getAllItems() async{
    final response = await http
        .get(Uri.parse(MyConfig.ITEM_API));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Item>((json) => Item.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }

  Future<TransactionResponse> getTransaction(String pdaNo) async{
    final queryParameters = {
      'PDANo': pdaNo,
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    final uri = MyConfig.TRANSACTION_API + '?' + queryString;
    final response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      return TransactionResponse.fromMap(json.decode(response.body));
    } else {
      throw Exception('Failed to load transaction');
    }
  }

  syncro(String pdaNo) async{
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
    TransactionResponse response = await getTransaction(pdaNo);
    List<Country> countries = await getAllCountries();
    List<Category> categories = await getAllCategories();
    List<MainCategory> mainCategories = await getAllMainCategories();
    List<Item> items = await getAllItems();
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
        sectionId: response.assetLocation.sectionId));
    await userService.insert(response.user);
    await floorService.insert(response.assetLocation.floor);
    await areaService.insert(response.assetLocation.area);
    await departmentService.insert(response.assetLocation.department);
    await transactionService.insert(TransactionLookUp(
        id: response.id,
        transactionType: response.transactionType,
        transActionTypeName: response.transActionTypeName));
    countryService.batch(countries);
    mainCategoryService.batch(mainCategories);
    itemService.batch(items);
    categoryService.batch(categories);
  }

  uploadData()async{
    // get all cupture
    final captureService = CaptureDetailsService();
    final transactionService = TransactionService();
    List<CaptureDetails> captureDetails = await captureService.retrieve();
    List<TransactionLookUp> transactions = await transactionService.retrieve();
    List<CaptureDetailsRequest> request = captureDetails.map((e) =>
        CaptureDetailsRequest(quantity: e.quantity,image: e.image,description: e.description,id: e.id,
            assetLocationId: e.assetLocationId,itemId: e.itemId,name: e.name,transactionId: transactions[0].id)).toList();
    print(jsonEncode(request));
    final response = await http.post(
      Uri.parse(MyConfig.UPLOAD_API),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(captureDetails)
    );
  }

}