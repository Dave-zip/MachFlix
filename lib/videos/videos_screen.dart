import 'package:flutter/material.dart';
import 'package:projeto_final/database/video.dart';

import '../database/bancovideos.dart';

class VideosScreen extends StatefulWidget {
  @override
  _VideosScreenState createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  // Criei uma lista de objetos Video para simular os dados dos vídeos
  late Future<List<Map<String, dynamic>>> videos;

  @override
  void initState() {
    super.initState();
    videos = _fetchVideos();
  }

  Future<List<Map<String, dynamic>>> _fetchVideos() async {
    List<Map<String, dynamic>> videos =
        (await DatabaseHelperV.instance.getAllVideo());

    return videos;
  }

  // Criei um método para adicionar um novo vídeo à lista
  void addVideo(Map<String, dynamic> video) {
    setState(() {
      DatabaseHelperV.instance.insertVideo(video);
    });
  }

  // Criei um método para editar um vídeo na lista
  void editVideo(int index, Map<String, dynamic> video) {
    setState(() {
      DatabaseHelperV.instance.updateVideo(video);
    });
  }

  // Criei um método para excluir um vídeo da lista
  void deleteVideo(int index) {
    setState(() {
      DatabaseHelperV.instance.deleteVideo(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Vídeos'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
      future: videos,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          final List<Map<String, dynamic>> videoList = snapshot.data!;
          return ListView.builder(
            itemCount: videoList.length,
            itemBuilder: (context, index) {
              final video = videoList[index];
              return Card(
                child: ListTile(
                  // leading: Image.asset(video.image),
                  title: Text(video["name"]),
                  subtitle: Text('Gênero: ${video["genre"]} - Tipo: ${video["type"]}'),
                  // trailing: PopupMenuButton<String>(
                  //   onSelected: (value) {
                  //     if (value == 'Editar') {
                  //       // Ação para editar o vídeo
                  //       showEditDialog(context, index, video); // Chamei o método de exibir o diálogo de edição de vídeo
                  //     } else if (value == 'Excluir') {
                  //       // Ação para excluir o vídeo
                  //       deleteVideo(index); // Chamei o método de excluir o vídeo
                  //     }
                  //   },
                  //   itemBuilder: (context) => [
                  //     const PopupMenuItem<String>(
                  //       value: 'Editar',
                  //       child: Text('Editar'),
                  //     ),
                  //     const PopupMenuItem<String>(
                  //       value: 'Excluir',
                  //       child: Text('Excluir'),
                  //     ),
                  //   ],
                  // ),
                  onTap: () {
                    // Ação ao clicar no título do vídeo (exibir detalhes, etc.)
                    // Usei um widget AlertDialog para exibir as informações do vídeo
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(video["name"]),
                        content: Column(
                          mainAxisSize: MainAxisSize
                              .min, // Usei essa propriedade para ajustar o tamanho da coluna ao conteúdo
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Usei essa propriedade para alinhar o conteúdo à esquerda
                          children: [
                            Text('Descrição: ${video["description"]}'),
                            Text('Tipo: ${video["type"]}'),
                            Text('Classificação indicativa:${video["ageRestriction"]}'),
                            Text('Duração em minutos: ${video["durationMinutes"]}'),
                            Text('Data de lançamento: ${video["releaseDate"]}'),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              // Ação para fechar o diálogo
                              Navigator.pop(context);
                            },
                            child: const Text(
                                'Fechar'), // Usei um texto em vez de um ícone para o botão de fechar
                          ),
                        ],
                      ),
                    );
                  },
                  // child: Text('Deslogar'),
                ),
              );
            },
          );
        }
      },
      ),
    );
  }
}
