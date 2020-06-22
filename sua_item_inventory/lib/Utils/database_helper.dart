import 'package:inventory/PurchaseOrder/purchaseOrderType.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:inventory/Types/category_type.dart';
import 'package:inventory/Types/product._type.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper; // Singleton DatabaseHelper
  static Database _database; // Singleton Database

  String categoryTableName = 'category_table_name';
  String productTable = 'product_table';
  String catID = 'category_id';
  String catName = 'category_name';
  String proId = 'product_id';
  String proName = 'product_name';
  String proCP = 'product_cost_price';
  String proSP = 'product_sell_price';
  String createdBy = 'created_by';
  String updatedBy = 'updated_by';
  String createDate = 'createDate';
  String updateDate = 'updateDate';

  String poTable = 'po_table';
  String POID = 'PO_id';
  String POName = 'PO_name';
  String POamount = 'PO_amount';
  String poDate = 'PO_Date';

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper
          ._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'itemInventory.db';

    // Open/create the database at a given path
    var itemInventoryDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return itemInventoryDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $categoryTableName($catID INTEGER PRIMARY KEY AUTOINCREMENT, $catName TEXT, '
        '$createdBy TEXT, $updatedBy TEXT,$createDate TEXT,$updateDate TEXT)');

    await db.execute(
        'CREATE TABLE $productTable($proId INTEGER PRIMARY KEY AUTOINCREMENT,$catID INTEGER ,$proName TEXT, '
        '$proCP TEXT,$proSP TEXT,$createdBy TEXT, $updatedBy TEXT,$createDate TEXT,'
        '$updateDate TEXT)');

    await db.execute(
        'CREATE TABLE $poTable($POID INTEGER PRIMARY KEY AUTOINCREMENT,$POName TEXT, '
            '$POamount TEXT,$poDate TEXT, $createdBy TEXT, $updatedBy TEXT,$createDate TEXT,'
            '$updateDate TEXT)');
  }

  // Fetch Operation: Get all category_type objects from database
  Future<List<Map<String, dynamic>>> getCategoryTypeMapList() async {
    Database db = await this.database;
    var result = await db.query(categoryTableName, orderBy: '$catName ASC');
    return result;
  }

  Future<List<Map<String, dynamic>>> searchCategory(String searchText) async {
    Database db = await this.database;
    var result =
    await db.rawQuery("SELECT * FROM $categoryTableName WHERE $catName LIKE '$searchText%'");
    return result;
  }

  // Insert Operation: Insert a category_type object to database
  Future<int> insertCategory(CategoryType categoryType) async {
    Database db = await this.database;
    var result = await db.insert(categoryTableName, categoryType.toMap());
    return result;
  }

  // Update Operation: Update a category_type object and save it to database
  Future<int> updateCategory(CategoryType categoryType) async {
    var db = await this.database;
    var result = await db.update(categoryTableName, categoryType.toMap(),
        where: '$catID = ?', whereArgs: [categoryType.category_id]);
    return result;
  }

  // Delete Operation: Delete a category_type object from database
  Future<int> deleteCategory(int id) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $categoryTableName WHERE $catID = $id');
    if (result != 0) {
      result =
      await db.rawDelete('DELETE FROM $productTable WHERE $catID = $id');
    }
    return result;
  }

  // Get number of category_type objects in database
  Future<int> getCategoryCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $categoryTableName');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'category List' [ List<CategoryType> ]
  Future<List<CategoryType>> getCategoryList() async {
    var categoryMapList =
        await getCategoryTypeMapList(); // Get 'Map List' from database
    int count =
        categoryMapList.length; // Count the number of map entries in db table

    List<CategoryType> categoryList = List<CategoryType>();
    // For loop to create a 'category List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      categoryList.add(CategoryType.fromMapObject(categoryMapList[i]));
    }

    return categoryList;
  }

  Future<List<CategoryType>> searchCategoryList(String searchText) async {
    var categoryMapList =
    await searchCategory(searchText); // Get 'Map List' from database
    int count =
        categoryMapList.length; // Count the number of map entries in db table

    List<CategoryType> categoryList = List<CategoryType>();
    // For loop to create a 'category List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      categoryList.add(CategoryType.fromMapObject(categoryMapList[i]));
    }

    return categoryList;
  }


  // Fetch Operation: Get all product_type objects from database
  Future<List<Map<String, dynamic>>> getProductTypeMapList(int cid) async {
    Database db = await this.database;
//    var result = await db.query(productTable ,where: '$catID = ?',
//        whereArgs: [cid],orderBy: '$proName ASC');

    var result =
        await db.rawQuery('select * FROM $productTable WHERE $catID= $cid');

    return result;
  }

  Future<List<Map<String, dynamic>>> searchProduct(String searchText) async {
    Database db = await this.database;
    var result =
    await db.rawQuery("SELECT * FROM $productTable WHERE $proName LIKE '$searchText%'");
    return result;
  }


  // Insert Operation: Insert a product_type object to database
  Future<int> insertProduct(ProductType productType) async {
    Database db = await this.database;
    var result = await db.insert(productTable, productType.toMap());
    return result;
  }

  // Insert Operation: Insert a po_type object to database
  Future<int> insertPO(POType poType) async {
    Database db = await this.database;
    print('InsertPO'+poType.PO_date) ;
    var result = await db.insert(poTable, poType.toMap());
    return result;
  }

  // Update Operation: Update a product_type object and save it to database
  Future<int> updateProduct(ProductType productType) async {
    var db = await this.database;
    var result = await db.update(productTable, productType.toMap(),
        where: '$proId = ?', whereArgs: [productType.product_id]);
    return result;
  }

  // Update Operation: Update a po_type object and save it to database
  Future<int> updatePO(POType po) async {
    var db = await this.database;
    var result = await db.update(poTable, po.toMap(),
        where: '$POID = ?', whereArgs: [po.PO_id]);
    return result;
  }

  // Delete Operation: Delete a product_type object from database
  Future<int> deleteProduct(int id) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $productTable WHERE $proId = $id');
    return result;
  }

  // Delete Operation: Delete a PO_type object from database
  Future<int> deletePO(int id) async {
    var db = await this.database;
    int result =
    await db.rawDelete('DELETE FROM $poTable WHERE $POID = $id');
    return result;
  }

  // Get number of product_type objects in database
  Future<int> getProductCount(int cid) async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db
        .rawQuery('SELECT COUNT (*) from $productTable where $catID = $cid ');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'product List' [ List<ProductType> ]
  Future<List<ProductType>> getProductList(int cid) async {
    var productMapList =
        await getProductTypeMapList(cid); // Get 'Map List' from database
    int count =
        productMapList.length; // Count the number of map entries in db table

    List<ProductType> productList = List<ProductType>();
    // For loop to create a 'product List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      productList.add(ProductType.fromMapObject(productMapList[i]));
    }

    return productList;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'product List' [ List<ProductType> ]
  Future<List<ProductType>> getComplateProductList() async {
    var productMapList =
    await getComplateProductTypeMapList(); // Get 'Map List' from database
    int count =
        productMapList.length; // Count the number of map entries in db table

    List<ProductType> productList = List<ProductType>();
    // For loop to create a 'product List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      productList.add(ProductType.fromMapObject(productMapList[i]));
    }

    return productList;
  }

  // Fetch Operation: Get all product_type objects from database
  Future<List<Map<String, dynamic>>> getComplateProductTypeMapList() async {
    Database db = await this.database;
//    var result = await db.query(productTable ,where: '$catID = ?',
//        whereArgs: [cid],orderBy: '$proName ASC');

    var result =
    await db.rawQuery('select * FROM $productTable');

    return result;
  }

  Future<List<ProductType>> searchProductList(String searchText) async {
    var productMapList =
    await searchProduct(searchText); // Get 'Map List' from database
    int count =
        productMapList.length; // Count the number of map entries in db table

    List<ProductType> productList = List<ProductType>();
    // For loop to create a 'product List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      productList.add(ProductType.fromMapObject(productMapList[i]));
    }

    return productList;
  }


  // Get the 'Map List' [ List<Map> ] and convert it to 'product List' [ List<ProductType> ]
  Future<List<POType>> getComplatePOList() async {
    var poMapList =
    await getComplatePOMapList(); // Get 'Map List' from database
    int count =
        poMapList.length; // Count the number of map entries in db table

    List<POType> poList = List<POType>();
    // For loop to create a 'product List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      poList.add(POType.fromMapObject(poMapList[i]));
      print ('getComplatePOList'+poList[i].PO_date.toString()) ;

    }

    return poList;
  }

  // Fetch Operation: Get all product_type objects from database
  Future<List<Map<String, dynamic>>> getComplatePOMapList() async {
    Database db = await this.database;
    var result = await db.query(poTable, orderBy: '$POName ASC');

    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'product List' [ List<ProductType> ]
  Future<List<POType>> getFilterPOList(String StartDate,String endDate) async {
    var poMapList =
    await getFilterPOMapList(StartDate,endDate); // Get 'Map List' from database
    int count =
        poMapList.length; // Count the number of map entries in db table

    List<POType> poList = List<POType>();
    // For loop to create a 'product List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      poList.add(POType.fromMapObject(poMapList[i]));
    }
  }

  // Fetch Operation: Get all product_type objects from database
  Future<List<Map<String, dynamic>>> getFilterPOMapList(String StartDate,String endDate) async {
    Database db = await this.database;
//    var result = await db.query(productTable ,where: '$catID = ?',
//        whereArgs: [cid],orderBy: '$proName ASC');

    var result =
    await db.rawQuery('select * FROM $poTable where $createDate BETWEEN $StartDate and $endDate');

    return result;
  }

  Future<List<POType>> searchPOList(String searchText) async {
    var poMapList =
    await searchPO(searchText); // Get 'Map List' from database
    int count =
        poMapList.length; // Count the number of map entries in db table

    List<POType> poList = List<POType>();
    // For loop to create a 'product List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      poList.add(POType.fromMapObject(poMapList[i]));
    }
    return poList;
  }



    Future<List<Map<String, dynamic>>> searchPO(String searchText) async {
      Database db = await this.database;
      var result =
      await db.rawQuery("SELECT * FROM $poTable WHERE $POName LIKE '$searchText%'");
      return result;
    }



}

