import 'package:dgi/db/DatabaseHandler.dart';
import 'package:dgi/model/sectionType.dart';
import 'package:sqflite/sqflite.dart';

class SectionTypeRepository{
  static const String TABLE_NAME = "sectionType";
  DatabaseHandler databaseHandler = DatabaseHandler();
  Future<int> insert(SectionType sectionType) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    result = await db.insert(TABLE_NAME, sectionType.toMap());
    return result;
  }
  Future<List<SectionType>> retrieve() async {
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(TABLE_NAME);
    return queryResult.map((e) => SectionType.fromMap(e)).toList();
  }
  Future<int> batch(List<SectionType> sectionTypes) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    for(var sectionType in sectionTypes){
      result = await db.insert(TABLE_NAME, sectionType.toMap());
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