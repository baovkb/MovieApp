import 'package:flutter/cupertino.dart';
import 'package:movie_app/features/account/data/sources/local_data/database.dart';
import 'package:sqflite/sqflite.dart';

class SessionDB {
  final dbHelper = DatabaseHelper.instance;
  static const String tableName = 'session';


  Future<void> insertSession(String session) async {
    final db = await dbHelper.database;
    await db.insert(tableName, {
      'session': session
    },
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<String?> getSession() async {
    final db = await dbHelper.database;
    List<Map<String, Object?>> result = await db.query(
        tableName,
        orderBy: 'ID DESC');
    if (result.isNotEmpty) {
      return result[0]['session'] as String;
    }
    return null;
  }

  Future<void> deleteSession() async {
    final db = await dbHelper.database;
    await db.delete(tableName);
  }
}