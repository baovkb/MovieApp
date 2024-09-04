import 'package:flutter/cupertino.dart';
import 'package:movie_app/features/account/data/sources/local_data/database.dart';
import 'package:sqflite/sqflite.dart';

class AccountDB {
  final dbHelper = DatabaseHelper.instance;
  static const String tableName = 'account';

  Future<int> insert({int? account_id, String? session}) async {
    final db = await dbHelper.database;
    return await db.insert(tableName, {
      'account_id': account_id,
      'session': session
    },
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, Object?>?> getRecord({lastRecord = true, id = 0}) async {
    if (lastRecord) {
      return await _getLastRecord();
    } else {
      final db = await dbHelper.database;
      final result = await db.query(
          tableName,
          where: 'id = $id');
      return result.isNotEmpty ? result[0] : null;
    }
  }

  Future<int> update(Map<String, Object?> values) async {
    final db = await dbHelper.database;
    final lastRecord = await _getLastRecord();
    return await db.update(tableName, values, where: 'id = ${lastRecord?['id']}');
  }

  Future<void> deleteAccount() async {
    final db = await dbHelper.database;
    await db.delete(tableName);
  }

  Future<Map<String, Object?>?> _getLastRecord() async {
    final db = await dbHelper.database;
    final result = await db.query(
        tableName,
        orderBy: 'ID DESC');
    return result.isNotEmpty ? result[0] : null;
  }
}