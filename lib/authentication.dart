import 'package:dgi/db/DatabaseHandler.dart';
import 'package:dgi/db/UserRepository.dart';
import 'package:dgi/model/User.dart';
import 'package:sqflite/sqflite.dart';

class Authentication{
  DatabaseHandler databaseHandler = DatabaseHandler();

  static String? username;

  Future<String> logIn(String username, String password) async {
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(UserRepository.TABLE_NAME, where: 'username = ? and password = ?', whereArgs: [username, password]);
    if(queryResult.isEmpty) {
      print('user $queryResult');
      return 'failed';
    }
    else{
      username = User.fromMap(queryResult[0]).username;
      print('log in: username ${User.fromMap(queryResult[0]).username}, password: ${User.fromMap(queryResult[0]).password}');
      return 'success';
    }

    print('log in: ${User.fromMap(queryResult[0]).username}');
  }
}