import 'package:dgi/db/DatabaseHandler.dart';
import 'package:sqflite/sqflite.dart';

import '../model/itemColor.dart';

class ColorRepository{
  static const String TABLE_NAME = "color";
  DatabaseHandler databaseHandler = DatabaseHandler();
  Future<int> insert(ItemColor color) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    result = await db.insert(TABLE_NAME, color.toMap());
    return result;
  }
  Future<List<ItemColor>> retrieve() async {
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(TABLE_NAME);
    return queryResult.map((e) => ItemColor.fromMap(e)).toList();
  }
  Future<int> batch(List<ItemColor> colors) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    for(var color in colors){
      result = await db.insert(TABLE_NAME, color.toMap());
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