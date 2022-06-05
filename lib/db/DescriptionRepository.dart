import 'package:dgi/db/DatabaseHandler.dart';
import 'package:dgi/model/item.dart';
import 'package:sqflite/sqflite.dart';

import '../model/description.dart';

class DescriptionRepository{
  static const String TABLE_NAME = "description";
  DatabaseHandler databaseHandler = DatabaseHandler();
  Future<int> insert(Description description) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    result = await db.insert(TABLE_NAME, description.toMap());
    return result;
  }
  Future<List<Description>> retrieve() async {
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(TABLE_NAME);
    return queryResult.map((e) => Description.fromMap(e)).toList();
  }
  Future<int> batch(List<Description> descriptions) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    for(var description in descriptions){
      result = await db.insert(TABLE_NAME, description.toMap());
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