import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'test.db'),
      onCreate: (database, version) async {
        Batch batch = database.batch();
        batch.execute("CREATE TABLE category(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL)");
        batch.execute("CREATE TABLE area(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL)");
        batch.execute("CREATE TABLE city(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL)");
        batch.execute("CREATE TABLE department(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL)");
        batch.execute("CREATE TABLE country(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL)");
        batch.execute("CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT , name TEXT NOT NULL,username TEXT NOT NULL, password TEXT NOT NULL, email TEXT NOT NULL,address TEXT NOT NULL)",);
        await batch.commit();
      },
      version: 1,
    );
  }

}