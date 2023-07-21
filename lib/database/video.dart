// Crie uma classe para representar os dados de um vídeo
class Video {
  // Crie os atributos da classe com os mesmos nomes e tipos das colunas da tabela video
  final int id;
  final String name;
  final String description;
  final String genre;
  final String type;
  final String ageRestriction;
  final int durationMinutes;
  final String image;
  final String releaseDate;

  // Crie um construtor que recebe todos os atributos como argumentos
  Video({
    required this.id,
    required this.name,
    required this.description,
    required this.genre,
    required this.type,
    required this.ageRestriction,
    required this.durationMinutes,
    required this.image,
    required this.releaseDate,
  });
}




// import 'package:projeto_final/database/dbhelper.dart';

// class Video {
//   final int id;
//   final String name;
//   final String description;
//   final int type;
//   final String ageRestriction;
//   final int durationMinutes;
//   final String thumbnailImageUrl;
//   final String releaseDate;

//   Video({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.type,
//     required this.ageRestriction,
//     required this.durationMinutes,
//     required this.thumbnailImageUrl,
//     required this.releaseDate,
//   });

//   // Criei um construtor que recebe um Map<String, dynamic> e converte os valores para os atributos da classe
//   Video.fromMap(Map<String, dynamic> map)
//       : id = map[DatabaseHelper.columnVideoId],
//         name = map[DatabaseHelper.columnVideoName],
//         description = map[DatabaseHelper.columnVideoDescription],
//         type = map[DatabaseHelper.columnVideoType],
//         ageRestriction = map[DatabaseHelper.columnVideoAgeRestriction],
//         durationMinutes = map[DatabaseHelper.columnVideoDurationMinutes],
//         thumbnailImageUrl = map[DatabaseHelper.columnVideothumbnailImageUrl],
//         releaseDate = map[DatabaseHelper.columnVideoReleaseDate];

//   Null get image => null;

//   get genre => null;

//   // Criei um método que converte os atributos da classe em um Map<String, dynamic>
//   Map<String, dynamic> toMap() {
//     return {
//       DatabaseHelper.columnVideoId: id,
//       DatabaseHelper.columnVideoName: name,
//       DatabaseHelper.columnVideoDescription: description,
//       DatabaseHelper.columnVideoType: type,
//       DatabaseHelper.columnVideoAgeRestriction: ageRestriction,
//       DatabaseHelper.columnVideoDurationMinutes: durationMinutes,
//       DatabaseHelper.columnVideothumbnailImageUrl: thumbnailImageUrl,
//       DatabaseHelper.columnVideoReleaseDate: releaseDate,
//     };
//   }
// }


