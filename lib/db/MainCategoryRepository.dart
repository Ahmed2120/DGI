import 'package:dgi/db/DatabaseHandler.dart';
import 'package:dgi/model/area.dart';
import 'package:sqflite/sqflite.dart';

import '../model/mainCategory.dart';

class MainCategoryRepository{
  static const String TABLE_NAME = "mainCategory";
  DatabaseHandler databaseHandler = DatabaseHandler();
  Future<int> insert(MainCategory mainCategory) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    result = await db.insert(TABLE_NAME, mainCategory.toMap());
    return result;
  }
  Future<List<MainCategory>> retrieve() async {
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(TABLE_NAME);
    return queryResult.map((e) => MainCategory.fromMap(e)).toList();
  }
  Future<int> batch(List<MainCategory> mainCategories) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    for(var mainCategory in mainCategories){
      result = await db.insert(TABLE_NAME, mainCategory.toMap());
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