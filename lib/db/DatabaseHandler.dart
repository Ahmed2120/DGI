import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'dgi.db'),
      onCreate: (database, version) async {
        Batch batch = database.batch();
        batch.execute("CREATE TABLE setting(id INTEGER PRIMARY KEY AUTOINCREMENT,pdaNo TEXT,ipAddress TEXT)");
        batch.execute("CREATE TABLE category(Id INTEGER, Name TEXT, MainCategoryId INTEGER)");
        batch.execute("CREATE TABLE locationType(Id INTEGER PRIMARY KEY, Name TEXT)");
        batch.execute("CREATE TABLE sectionType(Id INTEGER PRIMARY KEY , Name TEXT ,FloorId INTEGER)");
        batch.execute("CREATE TABLE area(Id INTEGER PRIMARY KEY , Name TEXT)");
        batch.execute("CREATE TABLE transactionTable(Id INTEGER PRIMARY KEY ,TransactionType INTEGER,TransActionTypeName TEXT)");
        batch.execute("CREATE TABLE mainCategory(Id INTEGER PRIMARY KEY , Name TEXT NOT NULL, ParentId INTEGER)");
        batch.execute("CREATE TABLE level(Id INTEGER PRIMARY KEY , Name TEXT NOT NULL)");
        batch.execute("CREATE TABLE accountGroup(Id INTEGER PRIMARY KEY , Name TEXT NOT NULL, ParentId INTEGER)");
        batch.execute("CREATE TABLE supplier(Id INTEGER PRIMARY KEY , Name TEXT NOT NULL)");
        batch.execute("CREATE TABLE city(Id INTEGER PRIMARY KEY , Name TEXT NOT NULL)");
        batch.execute("CREATE TABLE department(Id INTEGER PRIMARY KEY , Name TEXT NOT NULL)");
        batch.execute("CREATE TABLE country(Id INTEGER PRIMARY KEY, Name TEXT NOT NULL)");
        batch.execute("CREATE TABLE floor(Id INTEGER PRIMARY KEY , Name TEXT NOT NULL)");
        batch.execute("CREATE TABLE item(Id INTEGER PRIMARY KEY , Name TEXT NOT NULL, AccountGroupId INTEGER, ItemType INTEGER, HasMark INTEGER , HasWidth INTEGER , HasHeight INTEGER , HasLength INTEGER)");
        batch.execute("CREATE TABLE description(Id INTEGER PRIMARY KEY , Description TEXT NOT NULL, ItemId INTEGER)");
        batch.execute("CREATE TABLE users(Id INTEGER PRIMARY KEY , Name TEXT,UserName TEXT NOT NULL, HashedPassword TEXT NOT NULL, EmailAddress TEXT,Address TEXT)",);
        batch.execute("CREATE TABLE assetLocation(Id INTEGER PRIMARY KEY , Name TEXT,BuildingAddress TEXT,BuildingName TEXT,BuildingNo TEXT,FloorId INTEGER,DepartmentId INTEGER,AreaId INTEGER NOT NULL,BusinessUnit TEXT ,SectionId INTEGER,LocationType INTEGER,LocationTypeName TEXT,Compound TEXT,City TEXT,Governerate TEXT,Country TEXT)",);
        batch.execute("CREATE TABLE captureDetails(Id INTEGER PRIMARY KEY AUTOINCREMENT , Name TEXT,Image BLOB NOT NULL,ItemId  INTEGER NOT NULL,AssetLocationId INTEGER NOT NULL,Description TEXT NOT NULL,Quantity INTEGER NOT NULL,FloorId INTEGER,DepartmentId INTEGER,SectionId INTEGER,BrandId INTEGER,DescriptionId INTEGER,SerialNumber TEXT,isUploaded BOOLEAN DEFAULT false,ColorId INTEGER,Width INTEGER,Height INTEGER,Length INTEGER, Code TEXT, Cost TEXT, AjehzaTamolkNumber TEXT, ServiceDate TEXT , productionAge INTEGER, AccumulatedConsumption INTEGER, TransRefNumber TEXT, SupplierName TEXT, TransBoardNumber TEXT, transCreationDate TEXT, TransType TEXT, transHiekelNumbe TEXT, TransMamsha TEXT, AssetBookValue TEXT, File TEXT, FileName TEXT, ContentType TEXT)");
        batch.execute("CREATE TABLE asset(Id INTEGER PRIMARY KEY ,ItemId INTEGER,Barcode TEXT,SerialNumber TEXT,AssetImageInBase64 BLOB,AssetLocationId INTEGER ,Description TEXT ,isCounted BOOLEAN DEFAULT false,IsVerified INTEGER DEFAULT 2,Color TEXT,Width INTEGER,Height INTEGER,Length INTEGER,FloorId INTEGER,DepartmentId INTEGER,SectionId INTEGER,BrandId INTEGER,isUploaded BOOLEAN DEFAULT false, itemImage Text, itemName Text)",);
        batch.execute("CREATE TABLE brand(Id INTEGER PRIMARY KEY, Name TEXT)");
        batch.execute("CREATE TABLE color(Id INTEGER PRIMARY KEY, Name TEXT)");
        batch.execute("CREATE TABLE sectionGroup(Id INTEGER PRIMARY KEY, Name TEXT, FloorName TEXT, BuildingName TEXT)");
        await batch.commit();
      },
      version: 1,
    );
  }

  Future<List<Object?>> clearData() async {
    final Database db = await initializeDB();
    Batch batch = db.batch();
    batch.execute("delete from setting");
    batch.execute("delete from category");
    batch.execute("delete from locationType");
    batch.execute("delete from sectionType");
    batch.execute("delete from area");
    batch.execute("delete from transactionTable");
    batch.execute("delete from mainCategory");
    batch.execute("delete from level");
    batch.execute("delete from accountGroup");
    batch.execute("delete from supplier");
    batch.execute("delete from city");
    batch.execute("delete from department");
    batch.execute("delete from country");
    batch.execute("delete from floor");
    batch.execute("delete from item");
    batch.execute("delete from description");
    batch.execute("delete from users");
    batch.execute("delete from assetLocation");
    batch.execute("delete from users");
    batch.execute("delete from captureDetails");
    batch.execute("delete from asset");
    batch.execute("delete from brand");
    batch.execute("delete from color");
    batch.execute("delete from sectionGroup");
    return await batch.commit();
  }

}