import 'package:dgi/db/DatabaseHandler.dart';
import 'package:dgi/model/city.dart';
import 'package:sqflite/sqflite.dart';

class CityRepository{
  static const String TABLE_NAME = "city";
  DatabaseHandler databaseHandler = DatabaseHandler();
  Future<int> insert(City city) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    result = await db.insert(TABLE_NAME, city.toMap());
    return result;
  }
  Future<List<City>> retrieve() async {
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(TABLE_NAME);
    return queryResult.map((e) => City.fromMap(e)).toList();
  }
  Future<int> batch(List<City> cities) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    for(var city in cities){
      result = await db.insert(TABLE_NAME, city.toMap());
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