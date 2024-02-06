
import 'package:intl/intl.dart';

class User {

  int ?_id;

  String _height;
  String _weight;
  String _date;


  User( this._date,  this._height, this._weight);
  User.withId(this._id, this._date,  this._height, this._weight);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }

    map['height'] = _height;
    map['weight'] = _weight;
    map['date'] = _date;

    return map;
  }
  int get id => _id??-1;


  String get height => _height;
  String get weight => _weight;

  String get date => _date;
  set date(String newDate) {
    _date = newDate;
  }
  set height(String newheight) {
    _height = newheight;
  }
  set weight(String newweight) {
    _weight = newweight;
  }


  // Extract a User object from a Map object
  factory User.fromMapObject(Map<String, dynamic> map) {
    return User.withId(
      map['id'],

      map['date'] ?? DateFormat('yMd').format(DateTime.now()),
      map['height'],
      map['weight'],
    );
  }

}







