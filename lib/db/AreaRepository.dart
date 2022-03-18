import 'package:dgi/db/DatabaseHandler.dart';
import 'package:dgi/model/area.dart';
import 'package:sqflite/sqflite.dart';

class AreaRepository{
  static const String TABLE_NAME = "area";
  DatabaseHandler databaseHandler = DatabaseHandler();
  Future<int> insert(Area area) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    result = await db.insert(TABLE_NAME, area.toMap());
    return result;
  }
  Future<List<Area>> retrieve() async {
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(TABLE_NAME);
    return queryResult.map((e) => Area.fromMap(e)).toList();
  }
  Future<int> batch(List<Area> areas) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    for(var area in areas){
      result = await db.insert(TABLE_NAME, area.toMap());
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