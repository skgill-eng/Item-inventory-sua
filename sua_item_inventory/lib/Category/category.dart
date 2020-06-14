import 'dart:async';
import 'package:flutter/material.dart';
import 'package:inventory/Category/add_category.dart';
import 'package:inventory/Product/product.dart';
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

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<CategoryType> categoryList;
  int count = 0;

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
            'Category Name',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: count ,
            itemBuilder: (BuildContext context, int position){
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
                      child: Icon(Icons.edit,color: Colors.blue,),
                      onTap: () {
                        navigateToDetail(this.categoryList[position], 'Edit Category');
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10.0),
                    child: GestureDetector(
                      child: Icon(Icons.delete,color: Colors.red,),
                      onTap: () {
                        _delete(context, categoryList[position]);
                      },
                    ),
                  ),
                ],
              ),
              onTap: () {
                debugPrint("ListTile Tapped");
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Product();
                }));
                //navigateToDetail(this.todoList[position], 'Edit Todo');
              },
            ),
          );
        }),
      ),
      floatingActionButton:FloatingActionButton(
        onPressed: () {
          navigateToDetail(CategoryType('', 'Udai', 'Udai','',''), 'Category Details');
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
      Future<List<CategoryType>> categoryListFuture = databaseHelper.getCategoryList();
      categoryListFuture.then((categoryList) {
        setState(() {
          this.categoryList = categoryList;
          this.count = categoryList.length;
        });
      });
    });
  }
}

