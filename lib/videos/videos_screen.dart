import 'package:flutter/material.dart';
import 'package:projeto_final/database/video.dart';

class VideosScreen extends StatefulWidget {
  @override
  _VideosScreenState createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  // Criei uma lista de objetos Video para simular os dados dos vídeos
  final List<Video> videos = [
    Video(
      id: 1,
      name: 'Video 1',
      description: 'Descrição do Video 1',
      genre: 'Action',
      type: 'Filme',
      ageRestriction: 'Livre',
      durationMinutes: 120,
      image: 'assets/images/boom.jpg',
      releaseDate: '01/01/2020',
    ),
    Video(
      id: 2,
      name: 'Video 2',
      description: 'Descrição do Video 2',
      genre: 'Horror',
      type: 'Série',
      ageRestriction: '16 anos',
      durationMinutes: 60,
      image: 'assets/images/equipe.jpg',
      releaseDate: '01/02/2020',
    ),
  ];

  // Criei um método para adicionar um novo vídeo à lista
  void addVideo(Video video) {
    setState(() {
      videos.add(video);
    });
  }

  // Criei um método para editar um vídeo na lista
  void editVideo(int index, Video video) {
    setState(() {
      videos[index] = video;
    });
  }

  // Criei um método para excluir um vídeo da lista
  void deleteVideo(int index) {
    setState(() {
      videos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos os Vídeos'),
      ),
      body: ListView.builder(
        itemCount: videos.length,
        itemBuilder: (context, index) {
          final video = videos[index];
          return Card(
            child: ListTile(
              leading: Image.asset(video.image),
              title: Text(video.name),
              subtitle: Text('Gênero: ${video.genre} - Tipo: ${video.type}'),
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'Editar') {
                    // Ação para editar o vídeo
                    // Crie um novo objeto Video com os dados que você quiser
                    Video editedVideo = Video(
                      id: video.id,
                      name: video.name + ' editado', // Mudei o nome do vídeo
                      description: video.description +
                          ' editado', // Mudei a descrição do vídeo
                      genre:
                          video.genre + ' editado', // Mudei o gênero do vídeo
                      type: video.type + ' editado', // Mudei o tipo do vídeo
                      ageRestriction: video.ageRestriction +
                          '+', // Mudei a restrição de idade do vídeo
                      durationMinutes: video.durationMinutes +
                          10, // Mudei a duração do vídeo
                      image: video.image, // Mantive a mesma imagem do vídeo
                      releaseDate: video
                          .releaseDate, // Mantive a mesma data de lançamento do vídeo
                    );
                    editVideo(index,
                        editedVideo); // Chamei o método de editar o vídeo
                  } else if (value == 'Excluir') {
                    // Ação para excluir o vídeo
                    deleteVideo(index); // Chamei o método de excluir o vídeo
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem<String>(
                    value: 'Editar',
                    child: Text('Editar'),
                  ),
                  PopupMenuItem<String>(
                    value: 'Excluir',
                    child: Text('Excluir'),
                  ),
                ],
              ),
              onTap: () {
                // Ação ao clicar no título do vídeo (exibir detalhes, etc.)
                // Usei um widget AlertDialog para exibir as informações do vídeo
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(video.name),
                    content: Column(
                      mainAxisSize: MainAxisSize
                          .min, // Usei essa propriedade para ajustar o tamanho da coluna ao conteúdo
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // Usei essa propriedade para alinhar o conteúdo à esquerda
                      children: [
                        Text('Descrição: ${video.description}'),
                        Text('Tipo: ${video.type}'),
                        Text(
                            'Classificação indicativa: ${video.ageRestriction}'),
                        Text('Duração em minutos: ${video.durationMinutes}'),
                        Text('Data de lançamento: ${video.releaseDate}'),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          // Ação para fechar o diálogo
                          Navigator.pop(context);
                        },
                        child: Text(
                            'Fechar'), // Usei um texto em vez de um ícone para o botão de fechar
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        // Adicionei um botão flutuante para adicionar um novo vídeo
        child: Icon(Icons.add),
        onPressed: () {
          // Crie um novo objeto Video com os dados que você quiser
          Video newVideo = Video(
            id: 3,
            name: 'Video 3',
            description: 'Descrição do Video 3',
            genre: 'Comedy',
            type: 'Filme',
            ageRestriction: '12 anos',
            durationMinutes: 90,
            image: 'assets/images/alvo.png',
            releaseDate: '01/03/2020',
          );
          addVideo(newVideo); // Chamei o método de adicionar o vídeo
        },
      ),
    );
  }
}
