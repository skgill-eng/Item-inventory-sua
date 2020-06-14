import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory/Category/category.dart';
import 'package:inventory/Types/product._type.dart';
import 'package:inventory/Utils/database_helper.dart';


class AddProduct extends StatefulWidget {
  final String appBarTitle;
  final ProductType product;
  AddProduct(this.product, this.appBarTitle);
  @override
  State<StatefulWidget> createState() {
    return AddProductState(this.product, this.appBarTitle);
  }
}

class AddProductState extends State<AddProduct> {

  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  ProductType product;

  TextEditingController productNameController = TextEditingController();
  TextEditingController productCostPriceController = TextEditingController();
  TextEditingController productSellingPriceController = TextEditingController();


  AddProductState(this.product, this.appBarTitle);

  @override
  Widget build(BuildContext context) {

    final productName = TextFormField(
      controller: productNameController,
      keyboardType: TextInputType.text,
      autofocus: false,
      //initialValue: 'udaisingh@gmail.com',
      onChanged: (value){
        debugPrint('Something changed in Title Text Field');
        product.product_name = productNameController.text;
      },
      decoration: InputDecoration(
        hintText: 'Enter Product Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final productCostPrice = TextFormField(
      controller: productCostPriceController,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      autofocus: false,
      //initialValue: 'udaisingh@gmail.com',
      onChanged: (value){
        debugPrint('Something changed in Title Text Field');
        product.product_cost_price = productCostPriceController.text;
      },
      decoration: InputDecoration(
        hintText: 'Enter Product Cost Price',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final productSellingPrice = TextFormField(
      controller: productSellingPriceController,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      autofocus: false,
      //initialValue: 'udaisingh@gmail.com',
      onChanged: (value){
        debugPrint('Something changed in Title Text Field');
        product.product_sell_price = productSellingPriceController.text;
      },
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
          _save();
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Save', style: TextStyle(color: Colors.white)),
      ),
    );

    productNameController.text = product.product_name;
    productCostPriceController.text = product.product_cost_price;
    productSellingPriceController.text = product.product_sell_price;

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),

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

  void _save() async {

    Navigator.pop(context, true);
    product.created_by = "Udai";
    product.updated_by = "Udai";
    product.create_date =  DateFormat.yMMMd().format(DateTime.now());
    product.update_date =  DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (product.product_id != null) {  // Case 1: Update operation
      result = await helper.updateProduct(product);
      print("Update category"+product.product_id.toString());
    } else {// Case 2: Insert Operation
      result = await helper.insertProduct(product);
      print("Insert category"+product.product_id.toString());
    }

    if (result != 0) {
      print("Success");// Success
      //_showAlertDialog('Status', 'Category Saved Successfully');
    } else {
      print("Failue");// Failure
      //_showAlertDialog('Status', 'Problem Saving Category');
    }

  }
}

