import 'dart:async';
import 'package:flutter/material.dart';
import 'package:inventory/Category/category.dart';
import 'package:inventory/PurchaseOrder/POList.dart';

class Welcome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WelcomeState();
  }
}

class WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {

    final ProductCatelogButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(12),
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) {
                return Category();
              }));
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Product Catalogue', style: TextStyle(color: Colors.black,fontSize: 20)),
      ),
    );

    final POCatelogButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) {
                return POList();
              }));
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Purchase  Catalogue',
                     style: TextStyle(color: Colors.black,fontSize: 20)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Catalogue',
            textAlign: TextAlign.left,
          ),
        ),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            ProductCatelogButton,
            SizedBox(height: 24.0),
            POCatelogButton
          ],
        ),
      ),
    );
  }
}
