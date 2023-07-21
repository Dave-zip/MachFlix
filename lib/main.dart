import 'package:flutter/material.dart';
import 'package:projeto_final/home/home_screen.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData(
      brightness: Brightness.dark,
    );
    return MaterialApp(
      title: 'MachFlix',
      debugShowCheckedModeBanner: false,
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Colors.greenAccent[700],
          secondary: Colors.red,
        ),
      ),
      home: HomeScreen(),
    );
  }
}
