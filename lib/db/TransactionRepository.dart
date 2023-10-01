import 'package:dgi/db/DatabaseHandler.dart';
import 'package:dgi/model/transaction.dart';
import 'package:sqflite/sqflite.dart';

class TransactionRepository{
  static const String TABLE_NAME = "transactionTable";
  DatabaseHandler databaseHandler = DatabaseHandler();
  Future<int> insert(TransactionLookUp transaction) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    result = await db.insert(TABLE_NAME, transaction.toMap());
    return result;
  }
  Future<List<TransactionLookUp>> retrieve() async {
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(TABLE_NAME);
    return queryResult.map((e) => TransactionLookUp.fromMap(e)).toList();
  }
  Future<int> batch(List<TransactionLookUp> transactionLookUps) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    for(var transactionLookUp in transactionLookUps){
      result = await db.insert(TABLE_NAME, transactionLookUp.toMap());
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