import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelperV {
  static final DatabaseHelperV instance = DatabaseHelperV._();
  static Database? _database;

  DatabaseHelperV._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'my_video.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
    CREATE TABLE video(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      user_id INTEGER NOT NULL,
      name VARCHAR(2) NOT NULL,
      description TEXT NOT NULL,
      type INTEGER NOT NULL,
      ageRestriction VARCHAR NOT NULL,
      durationMinutes INTEGER NOT NULL,
      thumbnailImageId VARCHAR NOT NULL,
      releaseDate TEXT NOT NULL
    )
  ''');
  }

  Future<int> insertVideo(Map<String, dynamic> video) async {
    Database db = await instance.database;
    return await db.insert('video', video);
  }

  Future<List<Map<String, dynamic>>> getAllVideo() async {
    Database db = await instance.database;
    return await db.query('video');
  }

  Future<int> updateVideo(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row['id'];
    return await db.update('video', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteVideo(int id) async {
    Database db = await instance.database;
    return await db.delete('video', where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> isVideoDatabaseEmpty() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.query('video', limit: 1);
    return result.isEmpty;
  }

  Future<List<Map<String, dynamic>>> getMyVideos(int userId) async {
    Database db = await instance.database;
    return await db.query('video', where: 'user_id = ?', whereArgs: [userId]);
  }
}
