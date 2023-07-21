import 'package:flutter/material.dart';
import '../database/banco.dart';
import '../home/login_screen.dart';
import './my_videos.dart'; // Importe a tela MyVideosScreen.dart
import 'package:intl/intl.dart';

class MeusVideosScreen extends StatefulWidget {
  @override
  _MeusVideosScreenState createState() => _MeusVideosScreenState();
}

class _MeusVideosScreenState extends State<MeusVideosScreen> {
  late Future<List<Map<String, dynamic>>> _videosFuture;

  get genreList => DatabaseHelper.instance.getAllGenre();

  @override
  void initState() {
    super.initState();
    _videosFuture = _fetchVideos();
  }

  void addVideo(Map<String, dynamic> video, String genre) {
    setState(() {
      DatabaseHelper.instance.insertVideoGenre({'videoid': video['id'], 'genreid': int.parse(genre)});
      DatabaseHelper.instance.insertVideo(video);
    });
  }

  void editVideo(Map<String, dynamic> video) {
    setState(() {
      DatabaseHelper.instance.updateVideo(video);
    });
  }

  Future<String> getVideoGenre(Map<String, dynamic> video) {
    return DatabaseHelper.instance.getVideoGenre(video['id']);
  }

  Future<List<Map<String, dynamic>>> _fetchVideos() async {
    List<Map<String, dynamic>> videos =
        await DatabaseHelper.instance.getMyVideos(userId);

    return videos;
  }

  Future<String?> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      // Format the selected date as 'dd-MM-yyyy'
      return '${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year.toString()}';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Vídeos'),
        automaticallyImplyLeading: false, // Removendo o botão de voltar
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _videosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Build the list of videos using the retrieved data
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final videoData = snapshot.data![index];
                return ListTile(
                  title: Text(videoData['name']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Descrição: ${videoData['description']}'),
                      Text('Tipo: ${videoData['type']}'),
                      Text(
                          'Restrição de Idade: ${videoData['ageRestriction']}'),
                      Text(
                          'Duração (minutos): ${videoData['durationMinutes']}'),
                      Text(
                          'Imagem da Thumbnail: ${videoData['thumbnailImageUrl']}'),
                      Text('Data de Lançamento: ${videoData['releaseDate']}'),
                      Text('Gênero: ${getVideoGenre(videoData)}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showUpdateVideoForm(context, videoData);
                        },
                        child: Icon(Icons.edit),
                      ),
                      SizedBox(width: 16.0),
                      GestureDetector(
                        onTap: () {
                          _showDeleteVideoDialog(videoData['id']);
                        },
                        child: Icon(Icons.delete),
                      ),
                    ],
                  ),
                  onTap: () {
                    // Add code here to handle tapping on the video tile
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateVideoForm(context);
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // Navigates back to MyVideosScreen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyVideosScreen()),
            );
          },
          child: Text('Voltar'),
        ),
      ),
    );
  }

  void _showCreateVideoForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        String name = '';
        String description = '';
        int type = 0; // Default to 0
        String ageRestriction = 'N';
        int durationMinutes = 0;
        String thumbnailImageUrl = '';
        String releaseDate = '';

        // Obter a data de hoje
        DateTime currentDate = DateTime.now();
        // Formatar a data para o formato desejado (dia/mês/ano)
        String formattedDate = DateFormat('dd-MM-yyyy').format(currentDate);

        // Definir a data de hoje como a data de lançamento padrão
        releaseDate = formattedDate;

        String genre = '';
        return AlertDialog(
          title: Text('Novo Vídeo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                onChanged: (value) => name = value,
                decoration: InputDecoration(labelText: 'Nome'),
              ),
              TextFormField(
                onChanged: (value) => description = value,
                decoration: InputDecoration(labelText: 'Descrição'),
              ),
              TextFormField(
                onChanged: (value) => ageRestriction = value.toUpperCase(),
                decoration: InputDecoration(labelText: 'Restrição de Idade'),
              ),
              TextFormField(
                onChanged: (value) =>
                    durationMinutes = int.tryParse(value) ?? 0,
                decoration: InputDecoration(labelText: 'Duração (minutos)'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                onChanged: (value) => thumbnailImageUrl = value,
                decoration: InputDecoration(labelText: 'Imagem da Thumbnail'),
              ),
              TextFormField(
                initialValue: formattedDate, // Mostrar a data de hoje no campo
                onChanged: (value) => releaseDate = value,
                readOnly: true, // Tornar o TextFormField não editável
                decoration: InputDecoration(labelText: 'Data de Lançamento'),
              ),
              TextFormField(
                onChanged: (value) {
                  // Validar se o tipo é 0 ou 1
                  if (value == '0' || value == '1') {
                    type = int.parse(value);
                  }
                },
                decoration: InputDecoration(labelText: 'Tipo (0 ou 1)'),
              ),
              // DropdownButtonFormField<String>(
              //   value: genreList,
              //   onChanged: (value) => genre = value!,
              //   items: genreList
              //       .map((genre) => DropdownMenuItem<String>(
              //             value: genre['id'],
              //             child: Text(genre),
              //           ))
              //       .toList(),
              //   hint: Text('Selecione o gênero'),
              //   decoration: InputDecoration(labelText: 'Gênero'),
              // ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                // Salvar as informações do vídeo no banco de dados
                Map<String, dynamic> video = {
                  'user_id': userId,
                  'name': name,
                  'description': description,
                  'type': type,
                  'ageRestriction': ageRestriction,
                  'durationMinutes': durationMinutes,
                  'thumbnailImageUrl': thumbnailImageUrl,
                  'releaseDate': releaseDate,
                };

                // Validar os dados do vídeo antes de inserir no banco de dados
                if (_validateVideoData(video)) {
                  addVideo(video, genre);
                  // Fechar o diálogo
                  Navigator.of(context).pop();
                  // Atualizar a lista de vídeos
                  setState(() {
                    _videosFuture = _fetchVideos();
                  });
                } else {
                  // Mostrar uma mensagem de erro se os dados forem inválidos
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Erro'),
                      content:
                          Text('Por favor, preencha os campos corretamente.'),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  bool _validateVideoData(Map<String, dynamic> video) {
    if (video['name'].isEmpty ||
        video['description'].isEmpty ||
        (video['ageRestriction'] != 'S' &&
            video['ageRestriction'] != 'N') || // Nova validação
        video['durationMinutes'] <= 0 ||
        video['thumbnailImageUrl'].isEmpty ||
        video['releaseDate'].isEmpty) {
      return false;
    }

    if (video['type'] != 0 && video['type'] != 1) {
      return false;
    }

    return _isValidDateFormat(video['releaseDate']);
  }

  bool _isValidDateFormat(String date) {
    try {
      final parts = date.split('-');
      if (parts.length != 3) return false;

      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      if (day < 1 ||
          day > 31 ||
          month < 1 ||
          month > 12 ||
          year < 1000 ||
          year > 9999) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  void _showUpdateVideoForm(BuildContext context, Map<String, dynamic> video) {
    showDialog(
      context: context,
      builder: (context) {
        String name = video['name'];
        String description = video['description'];
        int type = video['type'];
        String ageRestriction = video['ageRestriction'];
        int durationMinutes = video['durationMinutes'];
        String thumbnailImageUrl = video['thumbnailImageUrl'];
        String releaseDate = video['releaseDate'];

        return AlertDialog(
          title: Text('Atualizar Vídeo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: name,
                onChanged: (value) => name = value,
                decoration: InputDecoration(labelText: 'Nome'),
              ),
              TextFormField(
                initialValue: description,
                onChanged: (value) => description = value,
                decoration: InputDecoration(labelText: 'Descrição'),
              ),
              TextFormField(
                initialValue: ageRestriction,
                onChanged: (value) => ageRestriction = value,
                decoration: InputDecoration(labelText: 'Restrição de Idade'),
              ),
              TextFormField(
                initialValue: durationMinutes.toString(),
                onChanged: (value) =>
                    durationMinutes = int.tryParse(value) ?? 0,
                decoration: InputDecoration(labelText: 'Duração (minutos)'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                initialValue: thumbnailImageUrl,
                onChanged: (value) => thumbnailImageUrl = value,
                decoration: InputDecoration(labelText: 'Imagem da Thumbnail'),
              ),
              TextFormField(
                initialValue: releaseDate,
                onChanged: (value) => releaseDate = value,
                decoration: InputDecoration(labelText: 'Data de Lançamento'),
              ),
              TextFormField(
                initialValue: type.toString(),
                onChanged: (value) {
                  if (value == '0' || value == '1') {
                    type = int.parse(value);
                  }
                },
                decoration: InputDecoration(labelText: 'Tipo (0 ou 1)'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                // Save the updated video information to the database
                Map<String, dynamic> updatedVideo = {
                  'id': video['id'],
                  'user_id': userId,
                  'name': name,
                  'description': description,
                  'type': type,
                  'ageRestriction': ageRestriction,
                  'durationMinutes': durationMinutes,
                  'thumbnailImageUrl': thumbnailImageUrl,
                  'releaseDate': releaseDate,
                };

                // Validate updated video data before updating the database
                if (_validateVideoData(updatedVideo)) {
                  editVideo(updatedVideo);
                  // Close the dialog
                  Navigator.of(context).pop();
                  // Refresh the videos list
                  setState(() {
                    _videosFuture = _fetchVideos();
                  });
                } else {
                  // Show an error message if the data is invalid
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Erro'),
                      content:
                          Text('Por favor, preencha os campos corretamente.'),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteVideoDialog(int videoId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Remover Vídeo'),
          content: Text('Deseja remover este vídeo?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Remove the video from the database
                await DatabaseHelper.instance.deleteVideo(videoId);
                // Close the dialog
                Navigator.of(context).pop();
                // Refresh the videos list
                setState(() {
                  _videosFuture = _fetchVideos();
                });
              },
              child: Text('Remover'),
            ),
          ],
        );
      },
    );
  }
}
