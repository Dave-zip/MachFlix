import 'package:flutter/material.dart';
// import '../database/banco.dart';

// class SignupScreen extends StatefulWidget {
//   @override
//   _SignupScreenState createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   final _formKey = GlobalKey<FormState>();

//   final _nomeController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _senhaController = TextEditingController();

//   Future<void> _cadastrarUsuario() async {
//     if (_formKey.currentState!.validate()) {
//       String email = _emailController.text;

//       // Verificar se o email já existe no banco de dados
//       bool emailExists = await _verificarEmailExistente(email);

//       if (emailExists) {
//         // Se o email já existir, exibir uma mensagem de erro e não realizar o cadastro.
//         showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               title: Text('Erro'),
//               content: Text(
//                   'O email já está cadastrado. Por favor, insira um email diferente.'),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: Text('Ok'),
//                 ),
//               ],
//             );
//           },
//         );
//       } else {
//         // Se o email não existir no banco de dados, podemos prosseguir com o cadastro.
//         Map<String, dynamic> novoUsuario = {
//           'name': _nomeController.text,
//           'email': email,
//           'password': _senhaController.text,
//         };

//         await DatabaseHelper.instance.insertData(novoUsuario);

//         // Exibir a mensagem de cadastro bem-sucedido usando um SnackBar
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Cadastro realizado com sucesso!'),
//             duration: Duration(seconds: 2),
//           ),
//         );
//       }
//     }
//   }

//   Future<bool> _verificarEmailExistente(String email) async {
//     List<Map<String, dynamic>> usuarios =
//         await DatabaseHelper.instance.getAllData();
//     return usuarios.any((usuario) => usuario['email'] == email);
//   }

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
