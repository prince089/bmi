import 'dart:async';
import 'dart:io';
import 'package:jeetbmi/model/userModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

 class DatabaseHelper {
  // static late DatabaseHelper _databaseHelper;
  static late Database _database;

  String tableName = 'userbmi';
  String columnDate = 'date';
  String columnName = 'name';
  String columnHeight = 'height';
  String columnWeight = 'weight';

  // DatabaseHelper._createInstance();

  // factory DatabaseHelper() {
  //   if (_databaseHelper == null) {
  //     _databaseHelper = DatabaseHelper._createInstance();
  //   }
  //   return _databaseHelper;
  // }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'USERBMI.db');
    var database = await openDatabase(path, version: 2, onCreate: _createDb);
    return database;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''
      CREATE TABLE $tableName (
        $columnName TEXT,
        $columnWeight INTEGER,
        $columnHeight INTEGER,
        $columnDate TEXT
      )
    ''');
  }

  Future<List<Map<String, dynamic>>> getRecords() async {
    Database db = await initializeDatabase();

    var result = await db.query(tableName);
    // print(result);
    return result;
  }


  Future<void> insertRecord({String name="",String date="", int height = 0,int weight = 0}) async {
    // DatabaseHelper databaseHelper = DatabaseHelper();

    Database db = await initializeDatabase();
    print(">>>>>>>>>>>> ${name} + ${date} + ${height} + ${weight}");
    // Example data, replace with your own data
    Map<String, dynamic> record = {
      'name': '${name}',
      'weight': weight,
      'height': height,
      'date':'${date}'
    };

    int result = await db.insert(this.tableName, record);

    if (result != 0) {
      print('Record inserted successfully');
    } else {
      print('Failed to insert record');
    }
  }


  //     delete(String date) async
  // {
  //   Database db=await initializeDatabase();
  //   await db.delete(tableName, where: date = '?', whereArgs: [date]);
  //
  //     }
  Future<void> delete(String date) async {
    Database db = await initializeDatabase();
    await db.delete(tableName, where: '$columnDate = ?', whereArgs: [date]);
  }
  Future<void> updateuser(User user) async {
    Database db = await initializeDatabase();
    await db.update(  tableName ,user.toMap(),where: '$columnDate = ?', whereArgs: [user.date]);
  }

 }
