import 'package:dgi/db/DatabaseHandler.dart';
import 'package:dgi/model/locationType.dart';
import 'package:dgi/model/area.dart';
import 'package:sqflite/sqflite.dart';

class LocationTypeRepository{
  static const String TABLE_NAME = "locationType";
  DatabaseHandler databaseHandler = DatabaseHandler();
  Future<int> insert(LocationType locationType) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    result = await db.insert(TABLE_NAME, locationType.toMap());
    return result;
  }
  Future<List<LocationType>> retrieve() async {
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(TABLE_NAME);
    return queryResult.map((e) => LocationType.fromMap(e)).toList();
  }
  Future<int> batch(List<LocationType> locationTypes) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    for(var locationType in locationTypes){
      result = await db.insert(TABLE_NAME, locationType.toMap());
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