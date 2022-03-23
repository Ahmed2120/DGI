import 'package:dgi/db/DatabaseHandler.dart';
import 'package:dgi/model/asset.dart';
import 'package:sqflite/sqflite.dart';

class AssetRepository{
  static const String TABLE_NAME = "asset";
  DatabaseHandler databaseHandler = DatabaseHandler();
  Future<int> insert(Asset area) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    result = await db.insert(TABLE_NAME, area.toMap());
    return result;
  }
  Future<List<Asset>> select(String barcode) async {
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(TABLE_NAME,where: "barcode",whereArgs: [barcode]);
    return queryResult.map((e) => Asset.fromMap(e)).toList();
  }
  Future<List<Asset>> retrieve() async {
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(TABLE_NAME);
    return queryResult.map((e) => Asset.fromMap(e)).toList();
  }
  Future<int> batch(List<Asset> assets) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    for(var asset in assets){
      result = await db.insert(TABLE_NAME, asset.toMap());
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