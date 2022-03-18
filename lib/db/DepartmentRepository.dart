import 'package:dgi/db/DatabaseHandler.dart';
import 'package:sqflite/sqflite.dart';

import '../model/department.dart';

class DepartmentRepository{
  static const String TABLE_NAME = "department";
  DatabaseHandler databaseHandler = DatabaseHandler();
  Future<int> insert(Department department) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    result = await db.insert(TABLE_NAME, department.toMap());
    return result;
  }
  Future<List<Department>> retrieve() async {
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(TABLE_NAME);
    return queryResult.map((e) => Department.fromMap(e)).toList();
  }
  Future<int> batch(List<Department> departments) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    for(var department in departments){
      result = await db.insert(TABLE_NAME, department.toMap());
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