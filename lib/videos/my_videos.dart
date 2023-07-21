import 'package:flutter/material.dart';
import '../database/bancovideos.dart';
import '../home/home_screen.dart';
import '../home/login_screen.dart';
import './meusvideos.dart'; // Importe a tela MeusVideos.dart
import 'package:projeto_final/database/video.dart';

class MyVideosScreen extends StatefulWidget {
  @override
  _MyVideosScreenState createState() => _MyVideosScreenState();
}

class _MyVideosScreenState extends State<MyVideosScreen> {
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

  void addVideo(Map<String, dynamic> video) {
    setState(() {
      DatabaseHelperV.instance.insertVideo(video);
    });
  }

  void editVideo(int index, Map<String, dynamic> video) {
    setState(() {
      DatabaseHelperV.instance.updateVideo(video);
    });
  }

  void deleteVideo(int index) {
    setState(() {
      DatabaseHelperV.instance.deleteVideo(index);
    });
  }

  void showEditDialog(
      BuildContext context, int index, Map<String, dynamic> video) {
    final nameController = TextEditingController(text: video["name"]);
    final descriptionController =
        TextEditingController(text: video["description"]);
    final genreController = TextEditingController(text: video["genre"]);
    final typeController = TextEditingController(text: video["type"]);
    final ageRestrictionController =
        TextEditingController(text: video["ageRestriction"]);
    final durationMinutesController =
        TextEditingController(text: video["durationMinutes"].toString());
    final releaseDateController =
        TextEditingController(text: video["releaseDate"]);

    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Editar Vídeo'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Nome'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite o nome do vídeo';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Descrição'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite a descrição do vídeo';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: genreController,
                  decoration: InputDecoration(labelText: 'Gênero'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite o gênero do vídeo';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: typeController,
                  decoration: InputDecoration(labelText: 'Tipo'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite o tipo do vídeo';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: ageRestrictionController,
                  decoration:
                      InputDecoration(labelText: 'Classificação indicativa'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite a classificação indicativa do vídeo';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: durationMinutesController,
                  decoration: InputDecoration(labelText: 'Duração em minutos'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite a duração em minutos do vídeo';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: releaseDateController,
                  decoration: InputDecoration(labelText: 'Data de lançamento'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite a data de lançamento do vídeo';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Map<String, dynamic> editedVideo = {
                  "id": video["id"],
                  "name": nameController.text,
                  "description": descriptionController.text,
                  "genre": genreController.text,
                  "type": typeController.text,
                  "ageRestriction": ageRestrictionController.text,
                  "durationMinutes": int.parse(durationMinutesController.text),
                  "releaseDate": releaseDateController.text,
                };
                editVideo(index, editedVideo);
                Navigator.pop(context);
              }
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vídeos'),
        automaticallyImplyLeading: false, // Removendo o botão de voltar
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
                    subtitle: Text(
                        'Gênero: ${video["genre"]} - Tipo: ${video["type"]}'),
                    // Removendo o ícone de overflow menu
                    trailing: null,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(video["name"]),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Descrição: ${video["description"]}'),
                              Text('Tipo: ${video["type"]}'),
                              // Restante dos campos do AlertDialog
                              // ...
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Fechar'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MeusVideosScreen()),
              );
            },
            child: Icon(Icons.arrow_forward), // Definindo o texto do botão
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
            child: Icon(Icons.home),
          ),
        ],
      ),
    );
  }
}
