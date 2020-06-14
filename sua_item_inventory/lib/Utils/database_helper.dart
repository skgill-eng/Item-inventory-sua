import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:inventory/Types/category_type.dart';
import 'package:inventory/Types/product._type.dart';


class DatabaseHelper {

  static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
  static Database _database;                // Singleton Database

  String categoryTableName = 'category_table_Name';
  String catID = 'category_id';
  String catName = 'category_name';
  String proId = 'product_id';
  String proName = 'product_name';
  String proCP = 'product_cost_price';
  String proSP = 'product_sell_price';
  String createdBy = 'created_by';
  String updatedBy = 'updated_by';
  String createDate='createDate' ;
  String updateDate='updateDate' ;

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {

    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
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
    var itemInventoryDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return itemInventoryDatabase;
  }

  void _createDb(Database db, int newVersion) async {

    await db.execute('CREATE TABLE $categoryTableName($catID INTEGER PRIMARY KEY AUTOINCREMENT, $catName TEXT, '
        '$createdBy TEXT, $updatedBy TEXT,$createDate TEXT,$updateDate TEXT)');
  }

  // Fetch Operation: Get all category_type objects from database
  Future<List<Map<String, dynamic>>> getCategoryTypeMapList() async {
    Database db = await this.database;
    var result = await db.query(categoryTableName, orderBy: '$catName ASC');
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
    var result = await db.update(categoryTableName, categoryType.toMap(), where: '$catID = ?', whereArgs: [categoryType.category_id]);
    return result;
  }

  Future<int> updateCategoryCompleted(CategoryType categoryType) async {
    var db = await this.database;
    var result = await db.update(categoryTableName, categoryType.toMap(), where: '$catID = ?', whereArgs: [categoryType.category_id]);
    return result;
  }

  // Delete Operation: Delete a category_type object from database
  Future<int> deleteCategory(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $categoryTableName WHERE $catID = $id');
    return result;
  }

  // Get number of category_type objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $categoryTableName');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'category List' [ List<CategoryType> ]
  Future<List<CategoryType>> getCategoryList() async {

    var categoryMapList = await getCategoryTypeMapList(); // Get 'Map List' from database
    int count = categoryMapList.length;         // Count the number of map entries in db table

    List<CategoryType> categoryList = List<CategoryType>();
    // For loop to create a 'category List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      categoryList.add(CategoryType.fromMapObject(categoryMapList[i]));
    }

    return categoryList;
  }

}