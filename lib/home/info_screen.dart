import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  String _displayText = '';

  void _onImageTap(int index) {
    setState(() {
      if (index == 0) {
        _displayText =
            'Aplicativo desenvolvido para o projeto final da disciplina de Laboratorio de dispositivos móveis.\n' +
                'Desenvolver o aplicativo Catálogo de Videos, que permite o usuário cadastrado criar, listar, editar e remover videos,' +
                '\nalém de pesquisar videos por gênero (Terror, Comédia, ...) e tipo (Filme, Série).';
      } else if (index == 1) {
        _displayText =
            '> Davi Santos\n> Guilherme Santos\n> Thiago Serra\n> Vitor Vieira';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informações'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Center(
              child: Text(
                _displayText,
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
          Divider(height: 1.0, color: Colors.black),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => _onImageTap(0),
                  child: Image.asset(
                    'assets/images/alvo.png',
                    width: 150.0,
                    height: 150.0,
                  ),
                ),
                GestureDetector(
                  onTap: () => _onImageTap(1),
                  child: Image.asset(
                    'assets/images/team.jpg',
                    width: 150.0,
                    height: 150.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
