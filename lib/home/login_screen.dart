import 'package:flutter/material.dart';
import 'package:projeto_final/videos/my_videos.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showPassword = false;
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Bem-vindo de volta! :)',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Usuário',
            ),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: _passwordController,
            obscureText: !_showPassword,
            decoration: InputDecoration(
              labelText: 'Senha',
              suffixIcon: IconButton(
                icon: Icon(
                  _showPassword ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: _togglePasswordVisibility,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          TextButton(
            onPressed: () {
              // Ação para o botão "Esqueci a senha"
            },
            child: const Text(
              'Esqueci a senha',
              style: TextStyle(
                color: Color.fromARGB(235, 255, 0, 0),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Ação para o botão "Entrar"
              // Você pode acessar os valores dos campos usando _passwordController.text e o valor do campo de usuário
              MaterialPageRoute(
                builder: (context) => MyVideosScreen(),
              );
            },
            child: const Text('Entrar'),
          ),
        ],
      ),
    );
  }
}
