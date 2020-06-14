import 'dart:async';
import 'package:flutter/material.dart';
import 'package:inventory/Category/add_category.dart';
import 'package:inventory/Product/product.dart';

class Category extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CategoryState();
  }
}

class CategoryState extends State<Category> {

  @override
  Widget build(BuildContext context) {
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
          itemCount: 1 ,
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
              title: Text('Fertilizer',
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return AddCategory();
                        }));
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10.0),
                    child: GestureDetector(
                      child: Icon(Icons.delete,color: Colors.red,),
                      onTap: () {
                        //_delete(context, todoList[position]);
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
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddCategory();
          }));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

