import 'package:flutter/material.dart';
import '../database/banco.dart';

class SignupScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _cadastrarUsuario(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String email = _emailController.text;
      String password = _passwordController.text;

      bool emailExists = await _verificarEmailExistente(email);

      if (emailExists) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'O email já está cadastrado. Por favor, insira um email diferente.'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        Map<String, dynamic> novoUsuario = {
          'name': name,
          'email': email,
          'password': password,
        };

        await DatabaseHelper.instance.insertData(novoUsuario);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Cadastro realizado com sucesso! Nome: $name, Email: $email'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Future<bool> _verificarEmailExistente(String email) async {
    List<Map<String, dynamic>> usuarios =
        await DatabaseHelper.instance.getAllData();
    return usuarios.any((usuario) => usuario['email'] == email);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(33.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Cadastre-se já',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      validator: (value) =>
                          value!.isEmpty ? 'Por favor, digite seu nome' : null,
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: TextFormField(
                        controller: _emailController,
                        validator: (value) => value!.isEmpty
                            ? 'Por favor, digite seu email'
                            : null,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      validator: (value) =>
                          value!.isEmpty ? 'Por favor, digite sua senha' : null,
                      decoration: const InputDecoration(
                        labelText: 'Senha',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => _cadastrarUsuario(context),
              child: const Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
