import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'dgi.db'),
      onCreate: (database, version) async {
        Batch batch = database.batch();
        batch.execute("CREATE TABLE category(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, mainCategoryId INTEGER)");
        batch.execute("CREATE TABLE locationType(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL)");
        batch.execute("CREATE TABLE sectionType(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL,floorId INTEGER)");
        batch.execute("CREATE TABLE area(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL)");
        batch.execute("CREATE TABLE transaction(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL)");
        batch.execute("CREATE TABLE mainCategory(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL)");
        batch.execute("CREATE TABLE city(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL)");
        batch.execute("CREATE TABLE department(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL)");
        batch.execute("CREATE TABLE country(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL)");
        batch.execute("CREATE TABLE floor(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL)");
        batch.execute("CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT , name TEXT NOT NULL,username TEXT NOT NULL, password TEXT NOT NULL, email TEXT NOT NULL,address TEXT NOT NULL)",);
        batch.execute("CREATE TABLE assetLocation(id INTEGER PRIMARY KEY , name TEXT NOT NULL,buildingAddress TEXT NOT NULL,buildingName TEXT NOT NULL,buildingNo TEXT NOT NULL,floorId INTEGER NOT NULL,departmentId INTEGER NOT NULL,areaId INTEGER NOT NULL,businessUnit TEXT NOT NULL,sectionId INTEGER)",);
        batch.execute("CREATE TABLE captureDetails(id INTEGER PRIMARY KEY AUTOINCREMENT , name TEXT,image BLOB NOT NULL,categoryId  INTEGER NOT NULL,assetLocationId INTEGER NOT NULL,description TEXT NOT NULL,quantity INTEGER NOT NULL)",);
        batch.execute("CREATE TABLE asset(id INTEGER PRIMARY KEY AUTOINCREMENT ,itemId INTEGER,barcode TEXT, serialnumber TEXT,image BLOB NOT NULL,barcodeImage BLOB NOT NULL,assetLocationId INTEGER NOT NULL,description TEXT NOT NULL,isVerified BOOLEAN DEFAULT false,isCounted BOOLEAN DEFAULT false,correct BOOLEAN DEFAULT false)",);
        await batch.commit();
      },
      version: 1,
    );
  }

}