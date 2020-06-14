class CategoryType
{

  int _category_id;
  String _category_name;
  String _created_by;
  String _updated_by;
  String _create_date;
  String _update_date;

  CategoryType(this._category_name, this._created_by,
      this._updated_by, this._create_date, this._update_date);

  int get category_id => _category_id;

  set category_id(int value) {
    this._category_id = value;
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

  String get category_name => _category_name;

  set category_name(String value) {
    this._category_name = value;
  }


  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (category_id != null) {
      map['category_id'] = _category_id;
    }
    map['category_name'] = _category_name;
    map['created_by'] = _created_by;
    map['updated_by'] = _updated_by;
    map['createDate'] = _create_date;
    map['createDate'] = _update_date;
    return map;
  }

  // Extract a Note object from a Map object
  CategoryType.fromMapObject(Map<String, dynamic> map) {
    this._category_id = map['category_id'];
    this._category_name = map['category_name'];
    this._created_by = map['created_by'];
    this._updated_by = map['updated_by'];
    this._create_date = map['createDate'];
    this._update_date = map['createDate'];
  }
}