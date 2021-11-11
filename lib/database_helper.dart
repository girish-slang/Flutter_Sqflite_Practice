import 'package:path/path.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _dbName = "test.db";
  static final _tableName = "myTable";
  static final _columnId = "_id";
  static final _columnName = "name";
  static final _dbVersion = 1;
  static Database? _database;


  static get columnId => _columnId;

  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initialiseDatabase();
    }
    return _database;
  }

  Future<Database> _initialiseDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: _onCreate,
      version: _dbVersion,
    );
  }

  Future _onCreate(Database db, int version) {
    return db.execute(
      '''
      CREATE TABLE $_tableName (
      $_columnId INTEGER PRIMARY KEY, 
      $_columnName TEXT NOT NULL)
      ''',
    );
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(_tableName, row);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.update(_tableName, row,
        where: '$_columnId = ?', whereArgs: [row[_columnId]]);
  }

  Future delete(int id) async {
    Database? db = await instance.database;
    return await db!
        .delete(_tableName, where: '$_columnId = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> queryAll() async{
    Database? db = await instance.database;
    return await db!.query(_tableName);
    
  }

  static get columnName => _columnName;
}
