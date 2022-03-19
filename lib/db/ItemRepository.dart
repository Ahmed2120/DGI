import 'package:dgi/db/DatabaseHandler.dart';
import 'package:dgi/model/item.dart';
import 'package:sqflite/sqflite.dart';

class ItemRepository{
  static const String TABLE_NAME = "item";
  DatabaseHandler databaseHandler = DatabaseHandler();
  Future<int> insert(Item item) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    result = await db.insert(TABLE_NAME, item.toMap());
    return result;
  }
  Future<List<Item>> retrieve() async {
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(TABLE_NAME);
    return queryResult.map((e) => Item.fromMap(e)).toList();
  }
  Future<int> batch(List<Item> items) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    for(var item in items){
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