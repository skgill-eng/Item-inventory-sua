class POType
{

  int _PO_id;
  String _PO_name;
  String _PO_amount;
  String _PO_date;
  String _created_by;
  String _updated_by;
  String _create_date;
  String _update_date;


  POType(
      this._PO_name,
      this._PO_amount,
      this._PO_date,
      this._created_by,
      this._updated_by,
      this._create_date,
      this._update_date);

  int get PO_id => _PO_id;

  set PO_id(int value) {
    this._PO_id = value;
  }

  String get update_date => _update_date;

  set update_date(String value) {
    this._update_date = value;
  }

  String get create_date => _create_date;

  set create_date(String value) {
    this._create_date = value;
  }

  String get updated_by => _updated_by;

  set updated_by(String value) {
    this._updated_by = value;
  }

  String get created_by => _created_by;

  set created_by(String value) {
    this._created_by = value;
  }

  String get PO_amount => _PO_amount;

  set PO_amount(String value) {
    this._PO_amount = value;
  }

  String get PO_name => _PO_name;

  set PO_name(String value) {
    this._PO_name = value;
  }

  String get PO_date => _PO_date;

  set PO_date(String value){
    this._PO_date = value;
  }


  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (PO_id != null) {
      map['PO_id'] = _PO_id;
    }
    map['PO_name'] = _PO_name;
    map['PO_amount'] = _PO_amount;
    map['PO_Date'] = _PO_date;
    map['created_by'] = _created_by;
    map['updated_by'] = _updated_by;
    map['createDate'] = _create_date;
    map['createDate'] = _update_date;
    return map;
  }
  // Extract a Note object from a Map object
  POType.fromMapObject(Map<String, dynamic> map) {
    this._PO_id = map['PO_id'];
    this._PO_name = map['PO_name'];
    this._PO_amount = map['PO_amount'];
    this._PO_date = map['PO_Date'];
    this._created_by = map['created_by'];
    this._updated_by = map['updated_by'];
    this._create_date = map['createDate'];
    this._update_date = map['createDate'];
  }

}