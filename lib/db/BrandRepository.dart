import 'package:dgi/db/DatabaseHandler.dart';
import 'package:sqflite/sqflite.dart';

import '../model/brand.dart';

class BrandRepository{
  static const String TABLE_NAME = "brand";
  DatabaseHandler databaseHandler = DatabaseHandler();
  Future<int> insert(Brand brand) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    result = await db.insert(TABLE_NAME, brand.toMap());
    return result;
  }
  Future<List<Brand>> retrieve() async {
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(TABLE_NAME);
    return queryResult.map((e) => Brand.fromMap(e)).toList();
  }
  Future<int> batch(List<Brand> brands) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    for(var brand in brands){
      result = await db.insert(TABLE_NAME, brand.toMap());
    }
    return result;
  }
  Future<void> delete(int id) async {
    final db = await databaseHandler.initializeDB();
    await db.delete(
      TABLE_NAME,
      where: "id = ?",
      whereArgs: [id],
    );
  }
}