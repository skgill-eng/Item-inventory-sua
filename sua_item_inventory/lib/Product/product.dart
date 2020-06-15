import 'dart:async';
import 'package:flutter/material.dart';
import 'package:inventory/Category/add_category.dart';
import 'package:inventory/Product/add_product.dart';
import 'package:inventory/Types/product._type.dart';
import 'package:inventory/Utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class Product extends StatefulWidget {
  final categoryId;

  Product(this.categoryId);

  @override
  State<StatefulWidget> createState() {
    return ProductState();
  }
}

class ProductState extends State<Product> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<ProductType> productList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (productList == null) {
      productList = List<ProductType>();
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product Lists',
          textAlign: TextAlign.left,
        ),
      ),
      body: Container(
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
                  title: Text(this.productList[position].product_name,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        //margin: EdgeInsets.only(left: 10.0),
                        child: Text(
                          'CP : ₹' +
                              this.productList[position].product_cost_price,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.red),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20.0),
                        child: Text(
                          'SP : ₹' +
                              this.productList[position].product_sell_price,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.red),
                        ),
                      ),
                    ],
                  ),
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
                            navigateToDetail(
                                this.productList[position], 'Edit Product');
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
                            _delete(context, productList[position]);
                          },
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    //navigateToDetail(this.todoList[position], 'Edit Todo');
                  },
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetail(
              ProductType(widget.categoryId, '', '', '', '', '', '', ''),
              'Product Details');
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void navigateToDetail(ProductType product, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddProduct(product, title);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void _delete(BuildContext context, ProductType product) async {
    int result = await databaseHelper.deleteProduct(product.product_id);
    if (result != 0) {
      //_showSnackBar(context, 'Todo Deleted Successfully');
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<ProductType>> productListFuture =
          databaseHelper.getProductList(widget.categoryId);
      productListFuture.then((productList) {
        setState(() {
          this.productList = productList;
          this.count = productList.length;
        });
      });
    });
  }
}
