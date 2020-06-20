import 'dart:async';
import 'package:flutter/material.dart';
import 'package:inventory/Category/add_category.dart';
import 'package:inventory/Product/product.dart';
import 'package:inventory/Product/search_products.dart';
import 'package:inventory/Types/category_type.dart';
import 'package:inventory/Utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class Category extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CategoryState();
  }
}

class CategoryState extends State<Category> {

  TextEditingController searchController = TextEditingController();

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<CategoryType> categoryList;
  int count = 0;
  int categoryId;
  String categoryName;

  @override
  Widget build(BuildContext context) {
    if (categoryList == null) {
      categoryList = List<CategoryType>();
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'All Categories',
            textAlign: TextAlign.center,
          ),
        ),
        actions: <Widget>[
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchProduct();
              }));
            },
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(
                  Icons.search ,
                  size: 40,
                  color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(9.0),
          child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: new TextField(
                      decoration: InputDecoration(
                        enabledBorder:  const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search Category',
                        //onSearchTextChanged,
                      ),
                      onChanged: (String searchText) async {
                        updateSearchListView(searchText);
                      }),
                ),
            Expanded(
              child: ListView.builder(
                  itemCount: count,
                  itemBuilder: (BuildContext context, int position) {
                    return Card(
                      color: Colors.white,
                      elevation: 2.0,
                      child: ListTile(
//              leading: CircleAvatar(
//                backgroundColor: Colors.amber,
//                child: Text(getFirstLetter(this.todoList[position].title),
//                    style: TextStyle(fontWeight: FontWeight.bold)),
//              ),
                        title: Text(this.categoryList[position].category_name,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        //subtitle: Text(this.todoList[position].date),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 10.0),
                              child: GestureDetector(
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onTap: () {
                                  String updateAppBarTitleText;
                                  updateAppBarTitleText ='Update '+this.categoryList[position].category_name+' Category';
                                  navigateToDetail(


                                      this.categoryList[position],updateAppBarTitleText);
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10.0),
                              child: GestureDetector(
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onTap: () {
                                  _delete(context, categoryList[position]);
                                },
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            categoryId = this.categoryList[position].category_id;
                            categoryName=this.categoryList[position].category_name;
                          });
                          debugPrint("ListTile Tapped");
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {

                            return Product(categoryId,categoryName);
                          }));
                          //navigateToDetail(this.todoList[position], 'Edit Todo');
                        },
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetail(
              CategoryType('', 'Udai', 'Udai', '', ''), 'Category Details');
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void navigateToDetail(CategoryType category, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddCategory(category, title);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void _delete(BuildContext context, CategoryType category) async {
    int result = await databaseHelper.deleteCategory(category.category_id);
    if (result != 0) {
      //_showSnackBar(context, 'Todo Deleted Successfully');
      updateListView();
    }
  }


  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<CategoryType>> categoryListFuture =
          databaseHelper.getCategoryList();
      categoryListFuture.then((categoryList) {
        setState(() {
          this.categoryList = categoryList;
          this.count = categoryList.length;
        });
      });
    });
  }

  void updateSearchListView(String searchText) {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<CategoryType>> categoryListFuture =
      databaseHelper.searchCategoryList(searchText);
      categoryListFuture.then((categoryList) {
        setState(() {
          this.categoryList = categoryList;
          this.count = categoryList.length;
        });
      });
    });
  }
}
