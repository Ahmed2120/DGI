import 'dart:convert';

import 'package:dgi/model/category.dart';
import 'package:dgi/model/item.dart';
import 'package:dgi/model/mainCategory.dart';
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

}