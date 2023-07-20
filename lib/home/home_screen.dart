import 'package:flutter/material.dart';
import 'package:projeto_final/home/login_screen.dart';
import 'package:projeto_final/home/signup_screen.dart';
import 'package:projeto_final/home/info_screen.dart';
import 'package:projeto_final/videos/videos.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(initialPage: 0);

  // Criei um método para navegar para a tela MyVideosScreen
  void goToMyVideos(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyVideosScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MachFlix'),
        automaticallyImplyLeading: false, // Remover o botão de voltar
      ),
      body: Stack(
        children: [
          // Adicionando o widget ColorFiltered com o widget Image para o fundo
          ColorFiltered(
            colorFilter: ColorFilter.mode(Colors.grey, BlendMode.darken),
            // Adicionando um argumento child com um widget Image
            child: Image.asset('assets/background.jpg', fit: BoxFit.cover),
          ),
          // Adicionando o widget PageView para os widgets LoginScreen e SignupScreen
          PageView(
            controller: _pageController,
            children: [
              // Usando o widget Scaffold com a propriedade backgroundColor para os campos de usuário e senha
              Scaffold(
                backgroundColor: const Color.fromARGB(255, 11, 98, 170),
                body: LoginScreen(),
              ),
              // Usando o widget Scaffold com a propriedade backgroundColor para os campos de usuário e senha
              Scaffold(
                backgroundColor: Color.fromARGB(255, 55, 75, 157),
                body: SignupScreen(),
              ),
              Scaffold(
                backgroundColor: Color.fromARGB(255, 80, 17, 174),
                body: InfoScreen(),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyVideosScreen(),
                  ),
                );
              },
              child: const Text('Continuar sem login'),
            ),
            TextButton(
              onPressed: () {
                _pageController.animateToPage(
                  0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                _pageController.animateToPage(
                  1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: const Text('Cadastro'),
            ),
          ],
        ),
      ),
      floatingActionButton:
          // Usando o widget Align para posicionar o botão de informação
          Align(
        alignment: Alignment.bottomRight,
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InfoScreen(),
              ),
            );
          },
          // Usando um ícone em vez de texto para o botão de informação
          child: Icon(Icons.info),
        ),
      ),
    );
  }
}
