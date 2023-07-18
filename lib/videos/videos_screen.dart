import 'package:flutter/material.dart';

class Video {
  final String title;
  final String genre;
  final String type;

  Video({required this.title, required this.genre, required this.type});
}

class VideosScreen extends StatelessWidget {
  final List<Video> videos = [
    Video(title: 'Video 1', genre: 'Terror', type: 'Filme'),
    Video(title: 'Video 2', genre: 'Comédia', type: 'Série'),
    // Adicione mais vídeos à lista conforme necessário
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Vídeos'),
      ),
      body: ListView.builder(
        itemCount: videos.length,
        itemBuilder: (context, index) {
          final video = videos[index];
          return ListTile(
            title: Text(video.title),
            subtitle: Text('Gênero: ${video.genre} - Tipo: ${video.type}'),
          );
        },
      ),
    );
  }
}
