class ProductType
{

  int _product_id;
  int _category_id;
  String _product_name;
  String _product_cost_price;
  String _product_sell_price;
  String _created_by;
  String _updated_by;
  String _create_date;
  String _update_date;


  ProductType(
      this._product_id,
      this._category_id,
      this._product_name,
      this._product_cost_price,
      this._product_sell_price,
      this._created_by,
      this._updated_by,
      this._create_date,
      this._update_date);

  int get product_id => _product_id;

  set product_id(int value) {
    _product_id = value;
  }

  String get update_date => _update_date;

  set update_date(String value) {
    _update_date = value;
  }

  String get create_date => _create_date;

  set create_date(String value) {
    _create_date = value;
  }

  String get updated_by => _updated_by;

  set updated_by(String value) {
    _updated_by = value;
  }

  String get created_by => _created_by;

  set created_by(String value) {
    _created_by = value;
  }

  String get product_sell_price => _product_sell_price;

  set product_sell_price(String value) {
    _product_sell_price = value;
  }

  String get product_cost_price => _product_cost_price;

  set product_cost_price(String value) {
    _product_cost_price = value;
  }

  String get product_name => _product_name;

  set product_name(String value) {
    _product_name = value;
  }

  int get category_id => _category_id;

  set category_id(int value) {
    _category_id = value;
  }


  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (product_id != null) {
      map['product_id'] = _product_id;
    }
    map['category_id'] = _category_id;
    map['product_name'] = _product_name;
    map['product_cost_price'] = _product_cost_price;
    map['product_sell_price'] = _product_sell_price;
    map['created_by'] = _created_by;
    map['updated_by'] = _updated_by;
    map['create_date'] = _create_date;
    map['update_date'] = _update_date;
    return map;
  }
  // Extract a Note object from a Map object
  ProductType.fromMapObject(Map<String, dynamic> map) {
    this._product_id = map['product_id'];
    this._category_id = map['category_id'];
    this._product_name = map['product_name'];
    this._product_cost_price = map['product_cost_price'];
    this._product_sell_price = map['product_sell_price'];
    this._created_by = map['created_by'];
    this._updated_by = map['updated_by'];
    this._create_date = map['create_date'];
    this._update_date = map['update_date'];
  }

}