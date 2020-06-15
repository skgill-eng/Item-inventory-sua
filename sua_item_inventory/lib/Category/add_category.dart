import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory/Types/category_type.dart';
import 'package:inventory/Utils/database_helper.dart';

class AddCategory extends StatefulWidget {
  final String appBarTitle;
  final CategoryType category;
  AddCategory(this.category, this.appBarTitle);
  @override
  State<StatefulWidget> createState() {
    return AddCategoryState(this.category, this.appBarTitle);
  }
}

class AddCategoryState extends State<AddCategory> {
  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  CategoryType category;

  TextEditingController categoryNameController = TextEditingController();

  AddCategoryState(this.category, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    final categoryName = TextFormField(
      controller: categoryNameController,
      keyboardType: TextInputType.text,
      autofocus: false,
      onChanged: (value) {
        debugPrint('Something changed in Title Text Field');
        category.category_name = categoryNameController.text;
      },
      //initialValue: 'udaisingh@gmail.com',
      decoration: InputDecoration(
        hintText: 'Enter Category Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final saveButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          setState(() {
            debugPrint("Save button clicked");
            _save();
          });
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Save', style: TextStyle(color: Colors.white)),
      ),
    );

    categoryNameController.text = category.category_name;

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(height: 48.0),
            categoryName,
            SizedBox(height: 24.0),
            saveButton
          ],
        ),
      ),
    );
  }

  void _save() async {
    Navigator.pop(context, true);
    category.created_by = "Udai";
    category.updated_by = "Udai";
    category.create_date = DateFormat.yMMMd().format(DateTime.now());
    category.update_date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (category.category_id != null) {
      // Case 1: Update operation
      result = await helper.updateCategory(category);
      print("Update category" + category.category_id.toString());
    } else {
      // Case 2: Insert Operation
      result = await helper.insertCategory(category);
      print("Insert category" + category.category_id.toString());
    }

    if (result != 0) {
      print("Success"); // Success
      //_showAlertDialog('Status', 'Category Saved Successfully');
    } else {
      print("Failure"); // Failure
      //_showAlertDialog('Status', 'Problem Saving Category');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
