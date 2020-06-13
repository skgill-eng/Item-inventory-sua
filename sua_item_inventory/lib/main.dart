import 'package:flutter/material.dart';
import 'package:inventory/login.dart';

void main() {
  runApp(SUAInventory());
}

class SUAInventory extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SUA Inventory',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: Login(),
    );
  }
}




