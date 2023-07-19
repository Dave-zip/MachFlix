// import 'package:projeto_final/database/dbhelper.dart';

// class User {
//   final int id;
//   final String name;
//   final String email;
//   final String password;

//   User({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.password,
//   });

//   // Criei um construtor que recebe um Map<String, dynamic> e converte os valores para os atributos da classe
//   User.fromMap(Map<String, dynamic> map)
//       : id = map[DatabaseHelper.columnUserId],
//         name = map[DatabaseHelper.columnUserName],
//         email = map[DatabaseHelper.columnUserEmail],
//         password = map[DatabaseHelper.columnUserPassword];

//   // Criei um método que converte os atributos da classe em um Map<String, dynamic>
//   Map<String, dynamic> toMap() {
//     return {
//       DatabaseHelper.columnUserId: id,
//       DatabaseHelper.columnUserName: name,
//       DatabaseHelper.columnUserEmail: email,
//       DatabaseHelper.columnUserPassword: password,
//     };
//   }
// }
