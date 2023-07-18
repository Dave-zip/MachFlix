import 'package:flutter/material.dart';
import 'package:projeto_final/home/login_screen.dart';
import 'package:projeto_final/home/signup_screen.dart';
import 'package:projeto_final/home/info_screen.dart';
import 'package:projeto_final/videos/videos_screen.dart';

class HomeScreen extends StatelessWidget {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seu App'),
      ),
      body: PageView(
        controller: _pageController,
        children: [
          LoginScreen(),
          SignupScreen(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InfoScreen(),
                  ),
                );
              },
              child: const Text('Info'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideosScreen(),
                  ),
                );
              },
              child: const Text('Continuar sem login'),
            ),
            ElevatedButton(
              onPressed: () {
                _pageController.animateToPage(
                  0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: const Text('Login'),
            ),
            ElevatedButton(
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
    );
  }
}
