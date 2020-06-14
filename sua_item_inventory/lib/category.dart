import 'dart:async';
import 'package:flutter/material.dart';
import 'package:inventory/add_category.dart';

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

