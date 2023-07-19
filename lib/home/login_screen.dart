import 'package:flutter/material.dart';
import 'package:projeto_final/videos/my_videos.dart';
import '../database/banco.dart'; // Importe o arquivo do banco de dados

int userId = -1;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showPassword = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  Future<void> _entrar() async {
    String email = _emailController.text;
    String senha = _passwordController.text;

    // Verify the credentials in the database
    userId =
        await DatabaseHelper.instance.getUserIdFromCredentials(email, senha);

    if (userId != -1) {
      // If the credentials are correct, update _loggedInUserId and navigate to MyVideosScreen

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyVideosScreen(),
        ),
      );
    } else {
      // If the credentials are incorrect, show an error message
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Erro'),
            content:
                Text('Email ou senha inválidos. Verifique suas credenciais.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Ok'),
              ),
            ],
          );
        },
      );
    }
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
          TextField(
            controller: _emailController,
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
            onPressed: _entrar, // Chama a função para verificar as credenciais
            child: const Text('Entrar'),
          ),
        ],
      ),
    );
  }
}
