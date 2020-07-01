import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory/PurchaseOrder/purchaseOrderType.dart';
import 'package:inventory/Utils/database_helper.dart';


class AddPO extends StatefulWidget {
  final String appBarTitle;
  final POType po;
  AddPO(this.po, this.appBarTitle);
  @override
  State<StatefulWidget> createState() {
    return AddPOState(this.po, this.appBarTitle);
  }
}

class AddPOState extends State<AddPO> {

  DatabaseHelper helper = DatabaseHelper();
  String appBarTitle;
  POType po;

  TextEditingController poNameController = TextEditingController();
  TextEditingController poAmountController = TextEditingController();
  TextEditingController poDateController = TextEditingController();



  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        po.PO_date = DateFormat.yMMMd().format(selectedDate);
        print("Dateeeeeeeeeeeeeeee"+po.PO_date);
      });
  }


  AddPOState(this.po, this.appBarTitle);

  @override
  Widget build(BuildContext context) {

    final poName = TextFormField(
      controller: poNameController,
      keyboardType: TextInputType.text,
      autofocus: false,
      //initialValue: 'udaisingh@gmail.com',
      onChanged: (value){
        debugPrint('Something changed in Title Text Field');
        po.PO_name = poNameController.text;
      },
      decoration: InputDecoration(
        labelText: "PO Name",
        //hintText: 'Enter PO Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final poAmount = TextFormField(
      controller: poAmountController,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      autofocus: false,
      //initialValue: 'udaisingh@gmail.com',
      onChanged: (value){
        debugPrint('Something changed in Title Text Field');
        po.PO_amount = poAmountController.text;
        po.PO_date=DateFormat.yMMMd().format(DateTime.now());

      },
      decoration: InputDecoration(
        labelText: "PO Amount",
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final poDate = TextFormField(
      controller: poDateController,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      autofocus: false,
      //initialValue: 'udaisingh@gmail.com',
      onChanged: (value){
        debugPrint('Something changed in Title Text Field');
        //po.create_date = poDateController.text;
      },
      decoration: InputDecoration(
        labelText: "PO Date",
        //hintText: 'Enter PO Selling Price',
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
          poNameController.text.isNotEmpty && poAmountController.text.isNotEmpty?
          setState(() {
            _save();
          }):showAlertDialog(context);
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Save', style: TextStyle(color: Colors.white)),
      ),
    );

    String createDate = DateFormat.yMMMd().format(selectedDate);
    poNameController.text = po.PO_name;
    poAmountController.text = po.PO_amount;

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),

      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[

            SizedBox(height: 20.0),
            poName,
            SizedBox(height: 20.0),
            poAmount,
            SizedBox(height: 20.0,),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(16),
              color: Colors.blue,
              child: Center(child: Text('Select date : '+"${selectedDate.toLocal()}".split(' ')[0])),
              onPressed: () => _selectDate(context),
            ),
            SizedBox(height: 10.0),
            saveButton
          ],
        ),
      ),
    );
  }


  void _save() async {

    Navigator.pop(context, true);
    po.created_by = "Udai";
    po.updated_by = "Udai";
    po.create_date = DateFormat.yMMMd().format(DateTime.now());
    po.update_date =  DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (po.PO_id != null) {  // Case 1: Update operation
      result = await helper.updatePO(po);
      print("Update category"+po.PO_id.toString());
    } else {// Case 2: Insert Operation
      result = await helper.insertPO(po);
      print(po);
      print("Insert category"+po.PO_id.toString());
    }

    if (result != 0) {
      print("Success");// Success
      //_showAlertDialog('Status', 'Category Saved Successfully');
    } else {
      print("Failure");// Failure
      //_showAlertDialog('Status', 'Problem Saving Category');
    }

  }
}

showAlertDialog(BuildContext context) {

  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Error"),
    content: Text(
        "Enter Details"
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}