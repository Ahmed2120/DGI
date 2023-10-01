import 'package:dgi/db/DatabaseHandler.dart';
import 'package:sqflite/sqflite.dart';

import '../model/supplier.dart';

class SupplierRepository{
  static const String TABLE_NAME = "supplier";
  DatabaseHandler databaseHandler = DatabaseHandler();
  Future<int> insert(Supplier supplier) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    result = await db.insert(TABLE_NAME, supplier.toMap());
    return result;
  }
  Future<List<Supplier>> retrieve() async {
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(TABLE_NAME);
    return queryResult.map((e) => Supplier.fromMap(e)).toList();
  }
  Future<int> batch(List<Supplier> suppliers) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    for(var supplier in suppliers){
      result = await db.insert(TABLE_NAME, supplier.toMap());
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