import 'package:flutter/material.dart';
import '../database/bancovideos.dart';
import '../home/home_screen.dart';
import '../home/login_screen.dart';
import './meusvideos.dart'; // Importe a tela MeusVideos.dart

class MyVideosScreen extends StatefulWidget {
  @override
  _MyVideosScreenState createState() => _MyVideosScreenState();
}

class _MyVideosScreenState extends State<MyVideosScreen> {
  late Future<List<Map<String, dynamic>>> _videosFuture;

  @override
  void initState() {
    super.initState();
    print(userId);
    _videosFuture = _fetchVideos();
  }

  Future<List<Map<String, dynamic>>> _fetchVideos() async {
    List<Map<String, dynamic>> videos =
        await DatabaseHelperV.instance.getAllVideo();

    return videos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Vídeos'),
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
                          'Imagem da Thumbnail: ${videoData['thumbnailImageId']}'),
                      Text('Data de Lançamento: ${videoData['releaseDate']}'),
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
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to the MeusVideos screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MeusVideosScreen()),
                );
              },
              child: Text('Meus Vídeos'),
            ),
            SizedBox(width: 16.0), // Add some spacing between buttons if needed
            ElevatedButton(
              onPressed: () {
                // Navigates back to the HomeScreen
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (Route<dynamic> route) => false,
                );
              },
              child: Text('Deslogar'),
            ),
          ],
        ),
      ),
    );
  }
}
