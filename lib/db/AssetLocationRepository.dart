import 'package:dgi/db/DatabaseHandler.dart';
import 'package:dgi/model/area.dart';
import 'package:dgi/model/assetLocation.dart';
import 'package:sqflite/sqflite.dart';

class AssetLocationRepository{
  static const String TABLE_NAME = "assetLocation";
  final DatabaseHandler _databaseHandler = DatabaseHandler();
  Future<int> insert(AssetLocation assetLocation) async {
    int result = 0;
    final Database db = await _databaseHandler.initializeDB();
    result = await db.insert(TABLE_NAME, assetLocation.toMap());
    return result;
  }
  Future<List<AssetLocation>> retrieve() async {
    final Database db = await _databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(TABLE_NAME);
    return queryResult.map((e) => AssetLocation.fromMap(e)).toList();
  }
  Future<int> batch(List<AssetLocation> assetLocations) async {
    int result = 0;
    final Database db = await _databaseHandler.initializeDB();
    for(var assetLocation in assetLocations){
      result = await db.insert(TABLE_NAME, assetLocation.toMap());
    }
    return result;
  }
  Future<void> delete(int id) async {
    final db = await _databaseHandler.initializeDB();
    await db.delete(
      TABLE_NAME,
      where: "id = ?",
      whereArgs: [id],
    );
  }
}