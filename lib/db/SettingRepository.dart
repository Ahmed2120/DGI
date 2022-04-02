import 'package:dgi/db/DatabaseHandler.dart';
import 'package:dgi/model/locationType.dart';
import 'package:dgi/model/area.dart';
import 'package:dgi/model/settings.dart';
import 'package:sqflite/sqflite.dart';

class SettingRepository{
  static const String TABLE_NAME = "setting";
  DatabaseHandler databaseHandler = DatabaseHandler();
  Future<int> insert(Setting setting) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    result = await db.insert(TABLE_NAME, setting.toMap());
    return result;
  }
  Future<List<Setting>> retrieve() async {
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(TABLE_NAME);
    return queryResult.map((e) => Setting.fromMap(e)).toList();
  }
}