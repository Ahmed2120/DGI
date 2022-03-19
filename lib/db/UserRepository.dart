import 'package:dgi/db/DatabaseHandler.dart';
import 'package:dgi/model/User.dart';
import 'package:sqflite/sqflite.dart';

class UserRepository{
  static const String TABLE_NAME = "users";
  DatabaseHandler databaseHandler = DatabaseHandler();
  Future<int> insert(User user) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    result = await db.insert(TABLE_NAME, user.toMap());
    return result;
  }
  Future<List<User>> retrieve() async {
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(TABLE_NAME);
    return queryResult.map((e) => User.fromMap(e)).toList();
  }
  Future<int> batch(List<User> users) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    for(var user in users){
      result = await db.insert(TABLE_NAME, user.toMap());
    }
    return result;
  }
}