import 'dart:async';
import 'package:movieproject/model/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'movies_database.db');
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  // automatically gets created if doesnt exist when instance is called
  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE movies (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        year INTEGER,
        type TEXT,
        poster TEXT
      )
    ''');
  }

  // gets movie by data
  Future<MovieModel?> getMovieByTitle(String title) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(
      'movies',
      where: 'title = ?',
      whereArgs: [title],
    );

    if (maps.isEmpty) {
      return null; // Movie not found
    }

    return MovieModel.fromMap(maps.first);
  }
}
