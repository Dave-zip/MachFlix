import 'package:flutter/material.dart';
import '../database/banco.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  Future<void> _cadastrarUsuario() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;

      // Verificar se o email já existe no banco de dados
      bool emailExists = await _verificarEmailExistente(email);

      if (emailExists) {
        // Se o email já existir, exibir uma mensagem de erro e não realizar o cadastro.
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Erro'),
              content: Text(
                  'O email já está cadastrado. Por favor, insira um email diferente.'),
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
      } else {
        // Se o email não existir no banco de dados, podemos prosseguir com o cadastro.
        Map<String, dynamic> novoUsuario = {
          'name': _nomeController.text,
          'email': email,
          'password': _senhaController.text,
        };

        await DatabaseHelper.instance.insertData(novoUsuario);

        // Exibir a mensagem de cadastro bem-sucedido usando um SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Cadastro realizado com sucesso!'),
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
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Cadastre-se já',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _nomeController,
              decoration: InputDecoration(
                labelText: 'Nome',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Digite o nome';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Digite o email';
                }
                // Aqui você pode adicionar validações adicionais para o formato do email, se necessário.
                return null;
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _senhaController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Digite a senha';
                }
                // Aqui você pode adicionar validações adicionais para a senha, se necessário.
                return null;
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _cadastrarUsuario,
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
