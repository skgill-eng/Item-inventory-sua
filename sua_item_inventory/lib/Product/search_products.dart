import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory/Types/product._type.dart';
import 'package:inventory/Utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class SearchProduct extends StatefulWidget {

  SearchProduct();

  @override
  State<StatefulWidget> createState() {
    return SearchProductState();
  }
}

class SearchProductState extends State<SearchProduct> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<ProductType> productList;
  int count = 0;

  @override
  Widget build(BuildContext context) {

    String appBarTitleText='Search Any Products';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appBarTitleText,
          textAlign: TextAlign.left,
        ),
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
                    hintText: 'Search Any Product',
                    //onSearchTextChanged,
                  ),
                  onChanged: (String searchText) async {
                    updateSearchListView(searchText);
                  }),
            ),
            Expanded(
              child:ListView.builder(
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
                        title: Text(this.productList[position].product_name,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              //margin: EdgeInsets.only(left: 10.0),
                              child: Text(
                                'Cost Price : ₹' +
                                    this.productList[position].product_cost_price,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.red),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 30.0),
                              child: Text(
                                'Sell Price : ₹' +
                                    this.productList[position].product_sell_price,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void updateSearchListView(String searchText) {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<ProductType>> productListFuture =
      databaseHelper.searchProductList(searchText);
      productListFuture.then((productList) {
        setState(() {
          this.productList = productList;
          this.count = productList.length;
        });
      });
    });
  }
}

