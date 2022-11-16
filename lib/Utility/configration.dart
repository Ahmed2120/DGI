class MyConfig {
  static String SERVER = '';
  static String COUNTRY_API = '/Country/GetAllCountries';
  static String MAIN_CATEGORY_API = '/MainCategory/GetMainCategories';
  static String CATEGORY_API = '/Category/GetCategories';
  static String ITEM_API = '/Item/GetItems';
  static String TRANSACTION_API = '/Transaction/GetTrasnaction';
  static String UPLOAD_API = '/Api/Cupture/UploadCupture';
  static String DEPARTMENT_API = '/LocationLocup/GetAllDepartments';
  static String SECTION_API = '/LocationLocup/GetAllSectionsByTransacionId';
  static String LEVEL_API = '/LocationLocup/GetAllLevels';
  static String ACCOUNTGROUP_API = '/LocationLocup/GetAllAccountGroups';
  static String SUPPLIER_API = '/LocationLocup/GetAllSuppliers';
  static String FLOOR_API = '/LocationLocup/GetAllFloorsByTransactionId';
  static String BRAND_API = '/LocationLocup/GetAllBrands';
  static String COLOR_API = '/LocationLocup/GetAllGetColors';
  static String DESCRIPTION_API = '/LocationLocup/GetAllDescriptions';
  static String ASSET_VERFICATION = '/Verification/GetAssetsByTransactionId';
  static String ASSET_INVENTORY = '/GetAssetsByTransactionId';
  static String ASSET_VERFICATION_UPLOAD = '/Verification/UploadVerification';
  static String ASSET_INVENTORY_UPLOAD = '/UploadCounter';
  static const String BUILDING = "Building";
  static const String OFFICE = "Office";
  static const String STORE = "Store";
  static const int PAGE_SIZE = 5;
}