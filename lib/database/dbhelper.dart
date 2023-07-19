import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Crie constantes para os nomes das tabelas e das colunas
const tableUser = 'user';
const columnUserId = '_id';
const columnUserName = 'name';
const columnUserEmail = 'email';
const columnUserPassword = 'password';

const tableVideo = 'video';
const columnVideoId = '_id';
const columnVideoName = 'name';
const columnVideoDescription = 'description';
const columnVideoType = 'type';
const columnVideoAgeRestriction = 'age_restriction';
const columnVideoDurationMinutes = 'duration_minutes';
const columnVideoThumbnailImageId = 'thumbnail_image_id';
const columnVideoReleaseDate = 'release_date';

const tableUserVideo = 'user_video';
const columnUserVideoUserId = 'user_id';
const columnUserVideoVideoId = 'video_id';

// Crie uma classe para gerenciar o banco de dados
class DatabaseHelper {
  // Crie uma instância privada da classe
  DatabaseHelper._privateConstructor();

  // Crie uma instância pública da classe
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Crie uma variável para armazenar a referência ao banco de dados
  static Database? _database;

  // Crie um método para obter a referência ao banco de dados
  Future<Database> get database async {
    // Se a variável já tiver um valor, retorne esse valor
    if (_database != null) return _database!;

    // Se a variável não tiver um valor, crie o banco de dados e atribua à variável
    _database = await _initDatabase();
    return _database!;
  }

  // Crie um método para criar o banco de dados
  _initDatabase() async {
    // Obtenha o caminho do diretório onde o banco de dados será armazenado
    String path = join(await getDatabasesPath(), 'machflix.db');

    // Abra o banco de dados e crie as tabelas se elas não existirem
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Crie um método para criar as tabelas no banco de dados
  Future _onCreate(Database db, int version) async {
    // Crie a tabela user com as colunas id, name, email e password
    await db.execute('''
          CREATE TABLE $tableUser (
            $columnUserId INTEGER PRIMARY KEY,
            $columnUserName TEXT NOT NULL,
            $columnUserEmail TEXT NOT NULL,
            $columnUserPassword TEXT NOT NULL
          )
          ''');

    // Crie a tabela video com as colunas id, name, description, type, age_restriction, duration_minutes, thumbnail_image_id e release_date
    await db.execute('''
          CREATE TABLE $tableVideo (
            $columnVideoId INTEGER PRIMARY KEY,
            $columnVideoName TEXT NOT NULL,
            $columnVideoDescription TEXT NOT NULL,
            $columnVideoType TEXT NOT NULL,
            $columnVideoAgeRestriction TEXT NOT NULL,
            $columnVideoDurationMinutes INTEGER NOT NULL,
            $columnVideoThumbnailImageId TEXT NOT NULL,
            $columnVideoReleaseDate TEXT NOT NULL
          )
          ''');

    // Crie a tabela user_video com as colunas user_id e video_id que são chaves estrangeiras das tabelas user e video respectivamente
    await db.execute('''
          CREATE TABLE $tableUserVideo (
            $columnUserVideoUserId INTEGER NOT NULL,
            $columnUserVideoVideoId INTEGER NOT NULL,
            FOREIGN KEY ($columnUserVideoUserId) REFERENCES $tableUser ($columnUserId),
            FOREIGN KEY ($columnUserVideoVideoId) REFERENCES $tableVideo ($columnVideoId)
          )
          ''');
  }

  // Crie um método que insere um usuário na tabela user e retorna o id do usuário inserido
  Future<int> insertUser(Map<String, dynamic> row) async {
    // Obtenha a referência ao banco de dados
    Database db = await instance.database;
    // Insira o usuário na tabela user e retorne o id do usuário inserido
    return await db.insert(tableUser, row);
  }

  // Crie um método que retorna todos os usuários da tabela user
  Future<List<Map<String, dynamic>>> queryAllUsers() async {
    // Obtenha a referência ao banco de dados
    Database db = await instance.database;
    // Faça uma consulta na tabela user e retorne todos os registros
    return await db.query(tableUser);
  }

  // Crie um método que deleta um usuário da tabela user usando o id do usuário como condição
  Future<int> deleteUser(int id) async {
    // Obtenha a referência ao banco de dados
    Database db = await instance.database;
    // Delete o usuário da tabela user usando o id do usuário como condição e retorne o número de registros afetados
    return await db.delete(
      tableUser,
      where: '$columnUserId = ?',
      whereArgs: [id],
    );
  }

  // Crie um método que insere um vídeo na tabela video e retorna o id do vídeo inserido
  Future<int> insertVideo(Map<String, dynamic> row) async {
    // Obtenha a referência ao banco de dados
    Database db = await instance.database;
    // Insira o vídeo na tabela video e retorne o id do vídeo inserido
    return await db.insert(tableVideo, row);
  }

  // Crie um método que retorna todos os vídeos da tabela video
  Future<List<Map<String, dynamic>>> queryAllVideos() async {
    // Obtenha a referência ao banco de dados
    Database db = await instance.database;
    // Faça uma consulta na tabela video e retorne todos os registros
    return await db.query(tableVideo);
  }

  // Crie um método que deleta um vídeo da tabela video usando o id do vídeo como condição
  Future<int> deleteVideo(int id) async {
    // Obtenha a referência ao banco de dados
    Database db = await instance.database;
    // Delete o vídeo da tabela video usando o id do vídeo como condição e retorne o número de registros afetados
    return await db.delete(
      tableVideo,
      where: '$columnVideoId = ?',
      whereArgs: [id],
    );
  }

  // Crie um método que insere um registro na tabela user_video usando o id do usuário e o id do vídeo como valores
  Future<int> insertUserVideo(int userId, int videoId) async {
    // Obtenha a referência ao banco de dados
    Database db = await instance.database;
    // Crie um mapa com os valores do id do usuário e do id do vídeo
    Map<String, dynamic> row = {
      columnUserVideoUserId: userId,
      columnUserVideoVideoId: videoId,
    };
    // Insira o registro na tabela user_video e retorne o número de registros afetados
    return await db.insert(tableUserVideo, row);
  }

  // Crie um método que deleta um registro da tabela user_video usando o id do usuário e o id do vídeo como condições
  Future<int> deleteUserVideo(int userId, int videoId) async {
    // Obtenha a referência ao banco de dados
    Database db = await instance.database;
    // Delete o registro da tabela user_video usando o id do usuário e o id do vídeo como condições e retorne o número de registros afetados
    return await db.delete(
      tableUserVideo,
      where: '$columnUserVideoUserId = ? AND $columnUserVideoVideoId = ?',
      whereArgs: [userId, videoId],
    );
  }

  // Crie um método que retorna todos os vídeos upados pelo usuário
  Future<List<Map<String, dynamic>>> queryUserVideos() async {
    // Obtenha a referência ao banco de dados
    Database db = await database;
    // Crie uma variável para armazenar o id do usuário logado
    int userId =
        1; // Você pode mudar esse valor de acordo com a sua lógica de login
    // Faça uma consulta na tabela user_video usando o id do usuário como condição
    List<Map<String, dynamic>> userVideos = await db.query(
      tableUserVideo,
      where: '$columnUserVideoUserId = ?',
      whereArgs: [userId],
    );
    // Crie uma lista vazia para armazenar os vídeos do usuário
    List<Map<String, dynamic>> videos = [];
    // Percorra cada registro da tabela user_video e obtenha o vídeo correspondente da tabela video
    for (Map<String, dynamic> userVideo in userVideos) {
      // Obtenha o id do vídeo
      int videoId = userVideo[columnUserVideoVideoId];
      // Faça uma consulta na tabela video usando o id do vídeo como condição
      List<Map<String, dynamic>> videoRows = await db.query(
        tableVideo,
        where: '$columnVideoId = ?',
        whereArgs: [videoId],
      );
      // Verifique se a consulta retornou algum resultado
      if (videoRows.isNotEmpty) {
        // Adicione o primeiro resultado à lista de vídeos do usuário
        videos.add(videoRows.first);
      }
    }
    // Retorne a lista de vídeos do usuário
    return videos;
  }
}
