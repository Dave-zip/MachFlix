import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'my_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE user(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name VARCHAR NOT NULL,
      email VARCHAR NOT NULL,
      password VARCHAR NOT NULL
)
    ''');
  }

  Future<int> insertData(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('user', row);
  }

  Future<List<Map<String, dynamic>>> getAllData() async {
    Database db = await instance.database;
    return await db.query('user');
  }

  Future<int> updateData(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row['id'];
    return await db.update('user', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteData(int id) async {
    Database db = await instance.database;
    return await db.delete('user', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> insertVideo(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('video', row);
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

  Future<bool> checkCredentials(String email, String password) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.query(
      'user',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    return result.isNotEmpty;
  }

  Future<int> getUserIdFromCredentials(String email, String senha) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> resultado = await db.query(
      'user',
      columns: ['id'],
      where: 'email = ? AND password = ?',
      whereArgs: [email, senha],
    );

    if (resultado.isNotEmpty) {
      return resultado[0]['id'];
    } else {
      return -1; // Usuário não encontrado ou credenciais inválidas
    }
  }
}
