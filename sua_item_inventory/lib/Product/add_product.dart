import 'dart:async';
import 'package:flutter/material.dart';
import 'package:inventory/Category/category.dart';


class AddProduct extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddProductState();
  }
}

class AddProductState extends State<AddProduct> {

  @override
  Widget build(BuildContext context) {

    final productName = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      //initialValue: 'udaisingh@gmail.com',
      decoration: InputDecoration(
        hintText: 'Enter Product Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final productCostPrice = TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      autofocus: false,
      //initialValue: 'udaisingh@gmail.com',
      decoration: InputDecoration(
        hintText: 'Enter Product Cost Price',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final productSellingPrice = TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      autofocus: false,
      //initialValue: 'udaisingh@gmail.com',
      decoration: InputDecoration(
        hintText: 'Enter Product Selling Price',
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
          Navigator.pop(context);
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Save', style: TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),

      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(height: 24.0),
            productName,
            SizedBox(height: 10.0),
            productCostPrice,
            SizedBox(height: 10.0),
            productSellingPrice,
            SizedBox(height: 24.0),
            saveButton
          ],
        ),
      ),
    );
  }
}

