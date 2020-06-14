import 'dart:async';
import 'package:flutter/material.dart';
import 'package:inventory/Category/add_category.dart';
import 'package:inventory/Product/add_product.dart';

class Product extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProductState();
  }
}

class ProductState extends State<Product> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product Name',
          textAlign: TextAlign.left,
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
                  title: Text('DAP',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        //margin: EdgeInsets.only(left: 10.0),
                        child: Text('CP:- Rs 1200',
                          style: TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.red),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20.0),
                        child: Text('SP:- Rs 1400',
                          style: TextStyle(fontWeight: FontWeight.bold,
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
                          child: Icon(Icons.edit,color: Colors.blue,),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return AddProduct();
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
                    //navigateToDetail(this.todoList[position], 'Edit Todo');
                  },
                ),
              );
            }),
      ),
      floatingActionButton:FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddProduct();
          }));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

