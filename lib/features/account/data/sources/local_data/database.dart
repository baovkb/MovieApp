//using singleton pattern to ensure only one instance

import 'package:movie_app/features/account/data/sources/local_data/session_db.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  Database? _db;
  final String _dbName = 'movie_app.db';
  final int _dbVersion = 1;

  static final DatabaseHelper _instance = DatabaseHelper._();

  static DatabaseHelper get instance => _instance;

  DatabaseHelper._();

  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }
    else {
      _db = await _initDB();
      return _db!;
    }
  }

  Future<Database> _initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), _dbName),
      version: _dbVersion,
      onCreate: _onCreate
    );
  }

  Future<void> _onCreate (Database db, int version) async {
    return await db.execute('''
          CREATE TABLE ${SessionDB.tableName} (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            session TEXT NOT NULL
          )
        ''');
  }

  Future<void> deleteDB() async {
    return await databaseFactory.deleteDatabase(join(await getDatabasesPath(), _dbName));
  }
}