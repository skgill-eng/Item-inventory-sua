import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory/PurchaseOrder/purchaseOrderType.dart';
import 'package:inventory/Utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

import 'add_po.dart';

class POList extends StatefulWidget {

  POList();

  @override
  State<StatefulWidget> createState() {
    return POListState();
  }
}

class POListState extends State<POList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<POType> poList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (poList == null) {
      poList = List<POType>();
      updateListView();
    }

    String appBarTitleText='Purchase Order List';


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
                    hintText: 'Search PO List',
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
                        title: Text(this.poList[position].PO_name,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              //margin: EdgeInsets.only(left: 10.0),
                              child: Text(
                                'PurA:₹' +
                                    this.poList[position].PO_amount,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.red),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 20.0),
                              child: Text(
                                'PurDate:' +
                                    this.poList[position].create_date,
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
                                  String updateAppBarTitleText;
                                  updateAppBarTitleText ='Update '+this.poList[position].PO_name+' Product Details';
                                  navigateToDetail(
                                      this.poList[position], updateAppBarTitleText);
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
                                  _delete(context, poList[position]);
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetail(
              POType('', '', '', '', '', '',),
              'PO Details');
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void navigateToDetail(POType po, String title) async {
    bool result =
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddPO(po, title);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void _delete(BuildContext context, POType po) async {
    int result = await databaseHelper.deletePO(po.PO_id);
    if (result != 0) {
      //_showSnackBar(context, 'Todo Deleted Successfully');
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<POType>> poListFuture =
      databaseHelper.getComplatePOList();
      poListFuture.then((poList) {
        setState(() {
          this.poList = poList;
          this.count = poList.length;
        });
      });
    });
  }
  void updateSearchListView(String searchText) {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<POType>> poListFuture =
      databaseHelper.searchPOList(searchText);
      poListFuture.then((poList) {
        setState(() {
          this.poList = poList;
          this.count = poList.length;
        });
      });
    });
  }
}

