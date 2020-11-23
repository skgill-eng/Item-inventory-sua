import 'dart:async';
import 'package:flutter/material.dart';
import 'package:inventory/Category/add_category.dart';
import 'package:inventory/Product/product.dart';
import 'package:inventory/Product/search_products.dart';
import 'package:inventory/Types/category_type.dart';
import 'package:firebase_database/firebase_database.dart';

class Category extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CategoryState();
  }
}

class CategoryState extends State<Category> {

  TextEditingController searchController = TextEditingController();

  List categoryList=[];
  int count = 0;
  int categoryId;
  String categoryName;
  void initState() {
    updateListView();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'All Categories',
            textAlign: TextAlign.center,
          ),
        ),
        actions: <Widget>[
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchProduct();
              }));
            },
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.search ,
                size: 40,
                color: Colors.black,
              ),
            ),
          )
        ],
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
                        hintText: 'Search Category',
                        //onSearchTextChanged,
                      ),
                      onChanged: (String searchText) async {
                       // updateSearchListView(searchText);
                      }),
                ),
            isLoading?Center(child: CircularProgressIndicator(),):Expanded(
              child: ListView.builder(
                  itemCount: categoryList.length,
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
                        title: Text(categoryList[position],
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        //subtitle: Text(this.todoList[position].date),
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
                                  updateAppBarTitleText ='Update '+categoryList[position]+' Category';
                                  navigateToDetail(


                                      categoryList[position],updateAppBarTitleText);
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
                                 // _delete(context, categoryList[position]);
                                },
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            //categoryId = this.categoryList[position].category_id;
                            categoryName=categoryList[position];
                          });
                          debugPrint("ListTile Tapped");
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {

                            return Product(categoryId,categoryName);
                          }));
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
              CategoryType('', 'Udai', 'Udai', '', ''), 'Category Details');
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void navigateToDetail(CategoryType category, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddCategory(category, title);
    }));

    if (result == true) {
      updateListView();
    }
  }

 }


 var isLoading = true;
  void updateListView() {
    final databaseReference = FirebaseDatabase.instance.reference().child("productCatalogue").child("categories");
    databaseReference.once().then((DataSnapshot snapshot) {

      var values=snapshot.value;
      List categoryList =[];
      print('Data : '+values.toString());
      for (int i = 0;i<values.length;i++){
        isLoading = true;
        categoryList.add(values[i]["categoryName"]);
        isLoading = false;
      }
      print("Category Name"+categoryList.toString());
    });
  }

