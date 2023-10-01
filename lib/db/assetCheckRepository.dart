import 'package:dgi/db/DatabaseHandler.dart';
import 'package:dgi/model/sectionType.dart';
import 'package:sqflite/sqflite.dart';

import '../model/assetCheck.dart';

class AssetCheckRepository{
  static const String TABLE_NAME = "assetCheck";
  DatabaseHandler databaseHandler = DatabaseHandler();
  Future<int> insert(AssetCheck assetCheck) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    result = await db.insert(TABLE_NAME, assetCheck.toJson());
    return result;
  }
  Future<List<AssetCheck>> retrieve() async {
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(TABLE_NAME);
    return queryResult.map((e) => AssetCheck.fromMap(e)).toList();
  }

  Future<AssetCheck> retrieveByBarcode(String barcode) async {
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(TABLE_NAME);
    return queryResult.map((e) => AssetCheck.fromMap(e)).toList().last;
  }

  Future<List<AssetCheck>> retrieveChecked() async {
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(TABLE_NAME, where: 'IsChecked = ?', whereArgs: [1]);
    return queryResult.map((e) => AssetCheck.fromMap(e)).toList();
  }

  Future<int> batch(List<AssetCheck> assetsCheck) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    for(var assetCheck in assetsCheck){
      result = await db.insert(TABLE_NAME, assetCheck.toJson());
    }
    return result;
  }
  Future<void> update(AssetCheck assetCheck) async {
    final db = await databaseHandler.initializeDB();
    await db.update(
      TABLE_NAME,
      assetCheck.toJson(),
      where: "id = ?",
      whereArgs: [assetCheck.id],
    );
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