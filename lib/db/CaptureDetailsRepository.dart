import 'package:dgi/db/DatabaseHandler.dart';
import 'package:dgi/model/CaptureDetails.dart';
import 'package:sqflite/sqflite.dart';

class CaptureDetailsRepository{
  static const String TABLE_NAME = "captureDetails";
  DatabaseHandler databaseHandler = DatabaseHandler();
  Future<int> insert(CaptureDetails captureDetails) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    result = await db.insert(TABLE_NAME, captureDetails.toMap());
    return result;
  }
  Future<List<CaptureDetails>> retrieve() async {
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(TABLE_NAME);
    return queryResult.map((e) => CaptureDetails.fromMap(e)).toList();
  }
  Future<List<CaptureDetails>> retrieveTopElement(int size) async {
    try{
      final Database db = await databaseHandler.initializeDB();
      final List<Map<String, Object?>> queryResult = await db.query(TABLE_NAME,where: "isUploaded = ?",whereArgs: [0],limit: size);
      return queryResult.map((e) => CaptureDetails.fromMap(e)).toList();
    }catch(e){
      rethrow;
    }
  }
  void update(List<CaptureDetails> items)async{
    try{
      final Database db = await databaseHandler.initializeDB();
      for(CaptureDetails item in items){
        item.isUploaded = 1;
        db.update(TABLE_NAME, item.toMap(),where: "Id = ?",whereArgs: [item.id]);
      }
    }catch(e){
      throw Exception(e);
    }
  }
  Future<int> batch(List<CaptureDetails> captureDetails) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    for(var item in captureDetails){
      result = await db.insert(TABLE_NAME, item.toMap());
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