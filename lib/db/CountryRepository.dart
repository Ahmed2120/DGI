import 'package:dgi/db/DatabaseHandler.dart';
import 'package:dgi/model/country.dart';
import 'package:sqflite/sqflite.dart';

class CountryRepository{
  static const String TABLE_NAME = "country";
  DatabaseHandler databaseHandler = DatabaseHandler();
  Future<int> insert(Country country) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    result = await db.insert(TABLE_NAME, country.toMap());
    return result;
  }
  Future<List<Country>> retrieve() async {
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(TABLE_NAME);
    return queryResult.map((e) => Country.fromMap(e)).toList();
  }
  Future<int> batch(List<Country> countries) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    for(var country in countries){
      result = await db.insert(TABLE_NAME, country.toMap());
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