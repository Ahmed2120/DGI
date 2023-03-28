import 'package:dgi/db/DatabaseHandler.dart';
import 'package:dgi/model/sectionType.dart';
import 'package:sqflite/sqflite.dart';

import '../model/sectionGroup.dart';

class SectionGroupRepository{
  static const String TABLE_NAME = "sectionGroup";
  DatabaseHandler databaseHandler = DatabaseHandler();
  Future<int> insert(SectionGroup sectionGroup) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    result = await db.insert(TABLE_NAME, sectionGroup.toMap());
    return result;
  }
  Future<List<SectionGroup>> retrieve() async {
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(TABLE_NAME);
    return queryResult.map((e) => SectionGroup.fromMap(e)).toList();
  }
  Future<int> batch(List<SectionGroup> sectionGroups) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    for(var sectionGroup in sectionGroups){
      result = await db.insert(TABLE_NAME, sectionGroup.toMap());
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