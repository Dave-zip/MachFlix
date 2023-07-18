import 'package:flutter/material.dart';

class MyVideosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Vídeos'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Video 1'),
            subtitle: Text('Descrição do Video 1'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                // Ação para excluir o vídeo
              },
            ),
            onTap: () {
              // Ação ao clicar no título do vídeo (exibir detalhes, etc.)
            },
          ),
          ListTile(
            title: Text('Video 2'),
            subtitle: Text('Descrição do Video 2'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                // Ação para excluir o vídeo
              },
            ),
            onTap: () {
              // Ação ao clicar no título do vídeo (exibir detalhes, etc.)
            },
          ),
          // Adicione mais ListTiles conforme necessário para exibir outros vídeos
        ],
      ),
    );
  }
}
