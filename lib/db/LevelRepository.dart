import 'package:dgi/db/DatabaseHandler.dart';
import 'package:dgi/model/level.dart';
import 'package:sqflite/sqflite.dart';

class LevelRepository{
  static const String TABLE_NAME = "level";
  DatabaseHandler databaseHandler = DatabaseHandler();
  Future<int> insert(Level level) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    result = await db.insert(TABLE_NAME, level.toMap());
    return result;
  }
  Future<List<Level>> retrieve() async {
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(TABLE_NAME);
    return queryResult.map((e) => Level.fromMap(e)).toList();
  }
  Future<int> batch(List<Level> levels) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    for(var level in levels){
      result = await db.insert(TABLE_NAME, level.toMap());
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