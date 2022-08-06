import 'package:dgi/db/DatabaseHandler.dart';
import 'package:dgi/model/accountGroup.dart';
import 'package:sqflite/sqflite.dart';

import '../model/mainCategory.dart';

class AccountGroupRepository{
  static const String TABLE_NAME = "accountGroup";
  DatabaseHandler databaseHandler = DatabaseHandler();
  Future<int> insert(AccountGroup accountGroup) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    result = await db.insert(TABLE_NAME, accountGroup.toMap());
    return result;
  }
  Future<List<AccountGroup>> retrieve() async {
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(TABLE_NAME);
    return queryResult.map((e) => AccountGroup.fromMap(e)).toList();
  }
  Future<int> batch(List<AccountGroup> accountGroups) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    for(var accountGroup in accountGroups){
      result = await db.insert(TABLE_NAME, accountGroup.toMap());
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