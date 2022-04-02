import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'dgi.db'),
      onCreate: (database, version) async {
        Batch batch = database.batch();
        batch.execute("CREATE TABLE setting(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,pdaNo TEXT)");
        batch.execute("CREATE TABLE category(Id INTEGER, Name TEXT, MainCategoryId INTEGER)");
        batch.execute("CREATE TABLE locationType(Id INTEGER PRIMARY KEY, Name TEXT)");
        batch.execute("CREATE TABLE sectionType(Id INTEGER PRIMARY KEY , Name TEXT ,floorId INTEGER)");
        batch.execute("CREATE TABLE area(Id INTEGER PRIMARY KEY , Name TEXT)");
        batch.execute("CREATE TABLE transactionTable(Id INTEGER PRIMARY KEY ,TransactionType INTEGER,TransActionTypeName TEXT)");
        batch.execute("CREATE TABLE mainCategory(id INTEGER PRIMARY KEY , Name TEXT NOT NULL)");
        batch.execute("CREATE TABLE city(Id INTEGER PRIMARY KEY , Name TEXT NOT NULL)");
        batch.execute("CREATE TABLE department(Id INTEGER PRIMARY KEY , Name TEXT NOT NULL)");
        batch.execute("CREATE TABLE country(Id INTEGER PRIMARY KEY, Name TEXT NOT NULL)");
        batch.execute("CREATE TABLE floor(Id INTEGER PRIMARY KEY AUTOINCREMENT, Name TEXT NOT NULL)");
        batch.execute("CREATE TABLE item(Id INTEGER PRIMARY KEY AUTOINCREMENT, Name TEXT NOT NULL,CategoryId INTEGER)");
        batch.execute("CREATE TABLE users(Id INTEGER PRIMARY KEY AUTOINCREMENT , Name TEXT,UserName TEXT NOT NULL, HashedPassword TEXT NOT NULL, EmailAddress TEXT NOT NULL,Address TEXT)",);
        batch.execute("CREATE TABLE assetLocation(Id INTEGER PRIMARY KEY , Name TEXT NOT NULL,BuildingAddress TEXT NOT NULL,BuildingName TEXT NOT NULL,BuildingNo TEXT NOT NULL,FloorId INTEGER NOT NULL,DepartmentId INTEGER NOT NULL,AreaId INTEGER NOT NULL,BusinessUnit TEXT NOT NULL,SectionId INTEGER)",);
        batch.execute("CREATE TABLE captureDetails(Id INTEGER PRIMARY KEY AUTOINCREMENT , Name TEXT,Image BLOB NOT NULL,ItemId  INTEGER NOT NULL,AssetLocationId INTEGER NOT NULL,Description TEXT NOT NULL,Quantity INTEGER NOT NULL)");
        batch.execute("CREATE TABLE asset(Id INTEGER PRIMARY KEY ,ItemId INTEGER,Barcode TEXT, Serialnumber TEXT,Image BLOB NOT NULL,BarcodeImage BLOB NOT NULL,AssetLocationId INTEGER NOT NULL,Description TEXT NOT NULL,isVerified BOOLEAN DEFAULT false,isCounted BOOLEAN DEFAULT false,correct BOOLEAN DEFAULT false)",);
        await batch.commit();
      },
      version: 1,
    );
  }

}