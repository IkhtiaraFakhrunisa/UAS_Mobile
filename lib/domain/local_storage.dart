// domain/local_storage.dart

import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/UserProfile.dart';

class DatabaseHelper {
  static Database? _database;
  static final String tableName = 'users';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(path, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE $tableName(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          email TEXT,
          password TEXT
        )
      ''');
    }, version: 1);
  }

  Future<int> saveUser(UserProfile user) async {
    final db = await database;
    return db.insert(tableName, user.toMap());
  }

  Future<bool> checkUser(String name, String password) async {
    final db = await database;
    var result = await db.query(
      tableName,
      where: 'name = ? AND password = ?',
      whereArgs: [name, password],
      limit: 1,
    );
    return result.isNotEmpty;
  }

  Future<UserProfile?> getUserById(int id) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return UserProfile.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updateUser(UserProfile user) async {
    final db = await database;
    return await db.update(
      tableName,
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(int id) async {
    final db = await database;
    return await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
