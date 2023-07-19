import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                        validator: (value) => value!.isEmpty
                            ? 'Por favor, digite seu nome'
                            : null,
                        decoration: const InputDecoration(
                          labelText: 'Nome',
                        )),
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
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  String name = _nameController.text;
                  String email = _emailController.text;
                  String password = _passwordController.text;

                  print('Nome: $name');
                  print('Email: $email');
                  print('Senha: $password');

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Cadastro realizado com sucesso! Nome: $name, Email: $email'),
                      action: SnackBarAction(
                          label: 'Desfazer',
                          onPressed: () {
                            print('Cadastro desfeito');
                          }),
                    ),
                  );
                }
              },
              child: const Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
