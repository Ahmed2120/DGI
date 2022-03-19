import 'package:dgi/db/DatabaseHandler.dart';
import 'package:dgi/model/category.dart';
import 'package:sqflite/sqflite.dart';

class CategoryRepository{
  static const String TABLE_NAME = "category";
  DatabaseHandler databaseHandler = DatabaseHandler();
  Future<int> insert(Category category) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    result = await db.insert(TABLE_NAME, category.toMap());
    return result;
  }
  Future<List<Category>> retrieve() async {
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(TABLE_NAME);
    return queryResult.map((e) => Category.fromMap(e)).toList();
  }
  Future<int> insertCategories(List<Category> categories) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    for(var category in categories){
      result = await db.insert(TABLE_NAME, category.toMap());
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