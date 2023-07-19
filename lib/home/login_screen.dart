import 'package:flutter/material.dart';
import 'package:projeto_final/videos/my_videos.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showPassword = false;
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                decoration: const InputDecoration(
                  labelText: 'Usuário',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, digite o seu usuário';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
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
                  // Ação para o botão "Entrar"
                  // Você pode acessar os valores dos campos usando _passwordController.text e o valor do campo de usuário
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyVideosScreen(),
                      ),
                    );
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
