import 'dart:ui';

import 'package:flutter/material.dart';

// Constantes para os valores que se repetem no código
const kBackgroundColor = Color.fromARGB(255, 112, 101, 101);
var kBoxShadowColor = Colors.black.withOpacity(0.2);
const kBoxShadowBlurRadius = 10.0;
const kBoxShadowOffset = Offset(0.0, 5.0);
const kBoxWidth = 400.0;
const kBoxHeight = 250.0;
const kBoxDuration = Duration(milliseconds: 15);
const kBoxCurve = Curves.easeOut;
var kBoxBorderRadius = BorderRadius.circular(10.0);
const kTextFontSize = 18.0;
const kTextAlign = TextAlign.center;
const kIconSize = 150.0;
const kIconColor = Colors.white;
const kIconShape = BoxShape.circle;
const kIconPadding = EdgeInsets.all(10.0);
const kSpacingHeight = 20.0;
const kLabelFontSize = 16.0;
const kLabelFontWeight = FontWeight.bold;

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
            'Aplicativo desenvolvido para o projeto final da disciplina de Laboratorio de dispositivos móveis. Desenvolver o aplicativo Catálogo de Videos, que permite o usuário cadastrado criar, listar, editar e remover videos, além de pesquisar videos por gênero (Terror, Comédia, ...) e tipo (Filme, Série).';
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
        title: const Text('Informações'),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Center(
                  child: AnimatedContainer(
                    duration: kBoxDuration,
                    curve: kBoxCurve,
                    width: _displayText.isEmpty ? 0.0 : kBoxWidth,
                    height: _displayText.isEmpty ? 0.0 : kBoxHeight,
                    decoration: BoxDecoration(
                      color: kBackgroundColor,
                      borderRadius: kBoxBorderRadius,
                      boxShadow: [
                        BoxShadow(
                          color: kBoxShadowColor,
                          blurRadius: kBoxShadowBlurRadius,
                          offset: kBoxShadowOffset,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        _displayText,
                        style: TextStyle(fontSize: kTextFontSize),
                        textAlign: kTextAlign,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(height: 1.0, color: Colors.black),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () => _onImageTap(0),
                          style: TextButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.zero,
                          ),
                          child: const Icon(
                            Icons.golf_course_sharp,
                            size: kIconSize,
                            color: kIconColor,
                          ),
                        ),
                        SizedBox(height: kSpacingHeight),
                        const Text(
                          'Objetivo',
                          style: TextStyle(
                            fontSize: kLabelFontSize,
                            fontWeight: kLabelFontWeight,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () => _onImageTap(1),
                          style: TextButton.styleFrom(
                              shape: CircleBorder(), padding: EdgeInsets.zero),
                          child: Container(
                            width: kIconSize,
                            height: kIconSize,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/team.jpg'))),
                          ),
                        ),
                        SizedBox(height: kSpacingHeight),
                        const Text('Equipe',
                            style: TextStyle(
                                fontSize: kLabelFontSize,
                                fontWeight: kLabelFontWeight)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
