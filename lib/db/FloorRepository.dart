import 'package:dgi/db/DatabaseHandler.dart';
import 'package:dgi/model/floor.dart';
import 'package:sqflite/sqflite.dart';

class FloorRepository{
  static const String TABLE_NAME = "floor";
  DatabaseHandler databaseHandler = DatabaseHandler();
  Future<int> insert(Floor floor) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    result = await db.insert(TABLE_NAME, floor.toMap());
    return result;
  }
  Future<List<Floor>> retrieve() async {
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(TABLE_NAME);
    return queryResult.map((e) => Floor.fromMap(e)).toList();
  }
  Future<int> batch(List<Floor> floors) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    for(var floor in floors){
      result = await db.insert(TABLE_NAME, floor.toMap());
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