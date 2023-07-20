import 'package:flutter/material.dart';
import 'package:projeto_final/videos/my_videos.dart';
import '../database/banco.dart';
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
  final _formKey = GlobalKey<FormState>();

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
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
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
              TextFormField(
                controller: _emailController, // Connect to the email controller
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, digite o seu email de usuário';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller:
                    _passwordController, // Connect to the password controller
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, digite a sua senha';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              PopupMenuButton(
                child: Text('Esqueci a senha'),
                onSelected: (value) {
                  // Ação para cada opção selecionada
                  if (value == 'try') {
                    // Exibir um SnackBar com a mensagem "Tente lembrar"
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Tente lembrar'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  } else if (value == 'reset') {
                    // Resetar a senha
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text('Tentar lembrar'),
                    value: 'try',
                  ),
                  //   PopupMenuItem(
                  //     child: Text('Resetar senha'),
                  //     value: 'reset',
                  //   ),
                ],
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _entrar();
                  }
                },
                child: const Text('Entrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
