// // import 'package:flutter/material.dart';
// // import 'package:projeto_final/database/video.dart';

// // class MyVideosScreen extends StatefulWidget {
// //   @override
// //   _MyVideosScreenState createState() => _MyVideosScreenState();
// // }

// // class _MyVideosScreenState extends State<MyVideosScreen> {
// //   // Criei uma lista de objetos Video para simular os dados dos vídeos
// //   final List<Video> videos = [
// //     Video(
// //       id: 1,
// //       name: 'Video 1',
// //       description: 'Descrição do Video 1',
// //       genre: 'Action',
// //       type: 'Filme',
// //       ageRestriction: 'Livre',
// //       durationMinutes: 120,
// //       image: 'assets/images/boom.jpg',
// //       releaseDate: '01/01/2020',
// //     ),
// //     Video(
// //       id: 2,
// //       name: 'Video 2',
// //       description: 'Descrição do Video 2',
// //       genre: 'Horror',
// //       type: 'Série',
// //       ageRestriction: '16 anos',
// //       durationMinutes: 60,
// //       image: 'assets/images/equipe.jpg',
// //       releaseDate: '01/02/2020',
// //     ),
// //   ];

// //   // Criei um método para adicionar um novo vídeo à lista
// //   void addVideo(Video video) {
// //     setState(() {
// //       videos.add(video);
// //     });
// //   }

// //   // Criei um método para editar um vídeo na lista
// //   void editVideo(int index, Video video) {
// //     setState(() {
// //       videos[index] = video;
// //     });
// //   }

// //   // Criei um método para excluir um vídeo da lista
// //   void deleteVideo(int index) {
// //     setState(() {
// //       videos.removeAt(index);
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Meus Vídeos'),
// //       ),
// //       body: ListView.builder(
// //         itemCount: videos.length,
// //         itemBuilder: (context, index) {
// //           final video = videos[index];
// //           return Card(
// //             child: ListTile(
// //               leading: Image.asset(video.image),
// //               title: Text(video.name),
// //               subtitle: Text('Gênero: ${video.genre} - Tipo: ${video.type}'),
// //               trailing: PopupMenuButton<String>(
// //                 onSelected: (value) {
// //                   if (value == 'Editar') {
// //                     // Ação para editar o vídeo
// //                     // Crie um novo objeto Video com os dados que você quiser
// //                     Video editedVideo = Video(
// //                       id: video.id,
// //                       name: video.name + ' editado', // Mudei o nome do vídeo
// //                       description: video.description +
// //                           ' editado', // Mudei a descrição do vídeo
// //                       genre:
// //                           video.genre + ' editado', // Mudei o gênero do vídeo
// //                       type: video.type + ' editado', // Mudei o tipo do vídeo
// //                       ageRestriction: video.ageRestriction +
// //                           '+', // Mudei a restrição de idade do vídeo
// //                       durationMinutes: video.durationMinutes +
// //                           10, // Mudei a duração do vídeo
// //                       image: video.image, // Mantive a mesma imagem do vídeo
// //                       releaseDate: video
// //                           .releaseDate, // Mantive a mesma data de lançamento do vídeo
// //                     );
// //                     editVideo(index,
// //                         editedVideo); // Chamei o método de editar o vídeo
// //                   } else if (value == 'Excluir') {
// //                     // Ação para excluir o vídeo
// //                     deleteVideo(index); // Chamei o método de excluir o vídeo
// //                   }
// //                 },
// //                 itemBuilder: (context) => [
// //                   PopupMenuItem<String>(
// //                     value: 'Editar',
// //                     child: Text('Editar'),
// //                   ),
// //                   PopupMenuItem<String>(
// //                     value: 'Excluir',
// //                     child: Text('Excluir'),
// //                   ),
// //                 ],
// //               ),
// //               onTap: () {
// //                 // Ação ao clicar no título do vídeo (exibir detalhes, etc.)
// //                 // Usei um widget AlertDialog para exibir as informações do vídeo
// //                 showDialog(
// //                   context: context,
// //                   builder: (context) => AlertDialog(
// //                     title: Text(video.name),
// //                     content: Column(
// //                       mainAxisSize: MainAxisSize
// //                           .min, // Usei essa propriedade para ajustar o tamanho da coluna ao conteúdo
// //                       crossAxisAlignment: CrossAxisAlignment
// //                           .start, // Usei essa propriedade para alinhar o conteúdo à esquerda
// //                       children: [
// //                         Text('Descrição: ${video.description}'),
// //                         Text('Tipo: ${video.type}'),
// //                         Text(
// //                             'Classificação indicativa: ${video.ageRestriction}'),
// //                         Text('Duração em minutos: ${video.durationMinutes}'),
// //                         Text('Data de lançamento: ${video.releaseDate}'),
// //                       ],
// //                     ),
// //                     actions: [
// //                       TextButton(
// //                         onPressed: () {
// //                           // Ação para fechar o diálogo
// //                           Navigator.pop(context);
// //                         },
// //                         child: Text(
// //                             'Fechar'), // Usei um texto em vez de um ícone para o botão de fechar
// //                       ),
// //                     ],
// //                   ),
// //                 );
// //               },
// //             ),
// //           );
// //         },
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         // Adicionei um botão flutuante para adicionar um novo vídeo
// //         child: Icon(Icons.add),
// //         onPressed: () {
// //           // Crie um novo objeto Video com os dados que você quiser
// //           Video newVideo = Video(
// //             id: 3,
// //             name: 'Video 3',
// //             description: 'Descrição do Video 3',
// //             genre: 'Comedy',
// //             type: 'Filme',
// //             ageRestriction: '12 anos',
// //             durationMinutes: 90,
// //             image: 'assets/images/alvo.png',
// //             releaseDate: '01/03/2020',
// //           );
// //           addVideo(newVideo); // Chamei o método de adicionar o vídeo
// //         },
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:projeto_final/database/video.dart';

// class MyVideosScreen extends StatefulWidget {
//   @override
//   _MyVideosScreenState createState() => _MyVideosScreenState();
// }

// class _MyVideosScreenState extends State<MyVideosScreen> {
//   // Criei uma lista de objetos Video para simular os dados dos vídeos
//   final List<Video> videos = [
//     Video(
//       id: 1,
//       name: 'Video 1',
//       description: 'Descrição do Video 1',
//       genre: 'Action',
//       type: 'Filme',
//       ageRestriction: 'Livre',
//       durationMinutes: 120,
//       image: 'assets/images/boom.jpg',
//       releaseDate: '01/01/2020',
//     ),
//     Video(
//       id: 2,
//       name: 'Video 2',
//       description: 'Descrição do Video 2',
//       genre: 'Horror',
//       type: 'Série',
//       ageRestriction: '16 anos',
//       durationMinutes: 60,
//       image: 'assets/images/equipe.jpg',
//       releaseDate: '01/02/2020',
//     ),
//   ];

//   // Criei um método para adicionar um novo vídeo à lista
//   void addVideo(Video video) {
//     setState(() {
//       videos.add(video);
//     });
//   }

//   // Criei um método para editar um vídeo na lista
//   void editVideo(int index, Video video) {
//     setState(() {
//       videos[index] = video;
//     });
//   }

//   // Criei um método para excluir um vídeo da lista
//   void deleteVideo(int index) {
//     setState(() {
//       videos.removeAt(index);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Meus Vídeos'),
//       ),
//       body: ListView.builder(
//         itemCount: videos.length,
//         itemBuilder: (context, index) {
//           final video = videos[index];
//           return Card(
//             child: ListTile(
//               leading: Image.asset(video.image),
//               title: Text(video.name),
//               subtitle: Text('Gênero: ${video.genre} - Tipo: ${video.type}'),
//               trailing: PopupMenuButton<String>(
//                 onSelected: (value) {
//                   if (value == 'Editar') {
//                     // Ação para editar o vídeo
//                     // Crie um novo objeto Video com os dados que você quiser
//                     Video editedVideo = Video(
//                       id: video.id,
//                       name: video.name + ' editado', // Mudei o nome do vídeo
//                       description: video.description +
//                           ' editado', // Mudei a descrição do vídeo
//                       genre:
//                           video.genre + ' editado', // Mudei o gênero do vídeo
//                       type: video.type + ' editado', // Mudei o tipo do vídeo
//                       ageRestriction: video.ageRestriction +
//                           '+', // Mudei a restrição de idade do vídeo
//                       durationMinutes: video.durationMinutes +
//                           10, // Mudei a duração do vídeo
//                       image: video.image, // Mantive a mesma imagem do vídeo
//                       releaseDate: video
//                           .releaseDate, // Mantive a mesma data de lançamento do vídeo
//                     );
//                     editVideo(index,
//                         editedVideo); // Chamei o método de editar o vídeo
//                   } else if (value == 'Excluir') {
//                     // Ação para excluir o vídeo
//                     deleteVideo(index); // Chamei o método de excluir o vídeo
//                   }
//                 },
//                 itemBuilder: (context) => [
//                   PopupMenuItem<String>(
//                     value: 'Editar',
//                     child: Text('Editar'),
//                   ),
//                   PopupMenuItem<String>(
//                     value: 'Excluir',
//                     child: Text('Excluir'),
//                   ),
//                 ],
//               ),
//               onTap: () {
//                 // Ação ao clicar no título do vídeo (exibir detalhes, etc.)
//                 // Usei um widget AlertDialog para exibir as informações do vídeo
//                 showDialog(
//                   context: context,
//                   builder: (context) => AlertDialog(
//                     title: Text(video.name),
//                     content: Column(
//                       mainAxisSize: MainAxisSize
//                           .min, // Usei essa propriedade para ajustar o tamanho da coluna ao conteúdo
//                       crossAxisAlignment: CrossAxisAlignment
//                           .start, // Usei essa propriedade para alinhar o conteúdo à esquerda
//                       children: [
//                         Text('Descrição: ${video.description}'),
//                         Text('Tipo: ${video.type}'),
//                         Text(
//                             'Classificação indicativa: ${video.ageRestriction}'),
//                         Text('Duração em minutos: ${video.durationMinutes}'),
//                         Text('Data de lançamento: ${video.releaseDate}'),
//                       ],
//                     ),
//                     actions: [
//                       TextButton(
//                         onPressed: () {
//                           // Ação para fechar o diálogo
//                           Navigator.pop(context);
//                         },
//                         child: Text(
//                             'Fechar'), // Usei um texto em vez de um ícone para o botão de fechar
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         // Adicionei um botão flutuante para adicionar um novo vídeo
//         child: Icon(Icons.add),
//         onPressed: () {
//           // Crie um novo objeto Video com os dados que você quiser
//           Video newVideo = Video(
//             id: 3,
//             name: 'Video 3',
//             description: 'Descrição do Video 3',
//             genre: 'Comedy',
//             type: 'Filme',
//             ageRestriction: '12 anos',
//             durationMinutes: 90,
//             image: 'assets/images/alvo.png',
//             releaseDate: '01/03/2020',
//           );
//           addVideo(newVideo); // Chamei o método de adicionar o vídeo
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:projeto_final/database/video.dart';

class MyVideosScreen extends StatefulWidget {
  @override
  _MyVideosScreenState createState() => _MyVideosScreenState();
}

class _MyVideosScreenState extends State<MyVideosScreen> {
  // Criei uma lista de objetos Video para simular os dados dos vídeos
  final List<Video> videos = [
    Video(
      id: 1,
      name: 'Video 1',
      description: 'Descrição do Video 1',
      genre: 'Action',
      type: 'Filme',
      ageRestriction: 'Livre',
      durationMinutes: 120,
      image: 'assets/images/boom.jpg',
      releaseDate: '01/01/2020',
    ),
    Video(
      id: 2,
      name: 'Video 2',
      description: 'Descrição do Video 2',
      genre: 'Horror',
      type: 'Série',
      ageRestriction: '16 anos',
      durationMinutes: 60,
      image: 'assets/images/equipe.jpg',
      releaseDate: '01/02/2020',
    ),
  ];

  // Criei um método para adicionar um novo vídeo à lista
  void addVideo(Video video) {
    setState(() {
      videos.add(video);
    });
  }

  // Criei um método para editar um vídeo na lista
  void editVideo(int index, Video video) {
    setState(() {
      videos[index] = video;
    });
  }

  // Criei um método para excluir um vídeo da lista
  void deleteVideo(int index) {
    setState(() {
      videos.removeAt(index);
    });
  }

  // Criei um método para exibir o diálogo de edição de vídeo
  void showEditDialog(BuildContext context, int index, Video video) {
    // Criei um TextEditingController para cada campo que eu quero editar
    final nameController = TextEditingController(text: video.name);
    final descriptionController =
        TextEditingController(text: video.description);
    final genreController = TextEditingController(text: video.genre);
    final typeController = TextEditingController(text: video.type);
    final ageRestrictionController =
        TextEditingController(text: video.ageRestriction);
    final durationMinutesController =
        TextEditingController(text: video.durationMinutes.toString());
    final releaseDateController =
        TextEditingController(text: video.releaseDate);

    // Criei uma variável para armazenar a chave do formulário
    final formKey = GlobalKey<FormState>();

    // Usei um widget showDialog para exibir o diálogo de edição de vídeo
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Editar Vídeo'),
        content: Form(
          // Usei um widget Form para validar os campos
          key: formKey,
          child: SingleChildScrollView(
            // Usei um widget SingleChildScrollView para evitar o overflow do conteúdo
            child: Column(
              mainAxisSize: MainAxisSize
                  .min, // Usei essa propriedade para ajustar o tamanho da coluna ao conteúdo
              children: [
                // Usei um widget TextFormField para cada campo que eu quero editar
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Nome'),
                  validator: (value) {
                    // Usei uma função de validação para verificar se o campo está vazio
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite o nome do vídeo';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Descrição'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite a descrição do vídeo';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: genreController,
                  decoration: InputDecoration(labelText: 'Gênero'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite o gênero do vídeo';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: typeController,
                  decoration: InputDecoration(labelText: 'Tipo'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite o tipo do vídeo';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: ageRestrictionController,
                  decoration:
                      InputDecoration(labelText: 'Classificação indicativa'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite a classificação indicativa do vídeo';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: durationMinutesController,
                  decoration: InputDecoration(labelText: 'Duração em minutos'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite a duração em minutos do vídeo';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: releaseDateController,
                  decoration: InputDecoration(labelText: 'Data de lançamento'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite a data de lançamento do vídeo';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Ação para fechar o diálogo sem salvar as alterações
              Navigator.pop(context);
            },
            child: Text(
                'Cancelar'), // Usei um texto em vez de um ícone para o botão de cancelar
          ),
          TextButton(
            onPressed: () {
              // Ação para salvar as alterações se o formulário for válido
              if (formKey.currentState!.validate()) {
                // Criei um novo objeto Video com os valores dos campos editados
                Video editedVideo = Video(
                  id: video.id,
                  name: nameController
                      .text, // Usei o nameController para obter o valor do campo nome
                  description: descriptionController
                      .text, // Usei o descriptionController para obter o valor do campo descrição
                  genre: genreController
                      .text, // Usei o genreController para obter o valor do campo gênero
                  type: typeController
                      .text, // Usei o typeController para obter o valor do campo tipo
                  ageRestriction: ageRestrictionController
                      .text, // Usei o ageRestrictionController para obter o valor do campo classificação indicativa
                  durationMinutes: int.parse(durationMinutesController
                      .text), // Usei o durationMinutesController para obter o valor do campo duração em minutos e converti para int
                  image: video.image, // Mantive a mesma imagem do vídeo
                  releaseDate: releaseDateController
                      .text, // Usei o releaseDateController para obter o valor do campo data de lançamento
                );
                editVideo(
                    index, editedVideo); // Chamei o método de editar o vídeo
                Navigator.pop(context); // Fechei o diálogo
              }
            },
            child: Text(
                'Salvar'), // Usei um texto em vez de um ícone para o botão de salvar
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Vídeos'),
      ),
      body: ListView.builder(
        itemCount: videos.length,
        itemBuilder: (context, index) {
          final video = videos[index];
          return Card(
            child: ListTile(
              leading: Image.asset(video.image),
              title: Text(video.name),
              subtitle: Text('Gênero: ${video.genre} - Tipo: ${video.type}'),
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'Editar') {
                    // Ação para editar o vídeo
                    showEditDialog(context, index,
                        video); // Chamei o método de exibir o diálogo de edição de vídeo
                  } else if (value == 'Excluir') {
                    // Ação para excluir o vídeo
                    deleteVideo(index); // Chamei o método de excluir o vídeo
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem<String>(
                    value: 'Editar',
                    child: Text('Editar'),
                  ),
                  PopupMenuItem<String>(
                    value: 'Excluir',
                    child: Text('Excluir'),
                  ),
                ],
              ),
              onTap: () {
                // Ação ao clicar no título do vídeo (exibir detalhes, etc.)
                // Usei um widget AlertDialog para exibir as informações do vídeo
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(video.name),
                    content: Column(
                      mainAxisSize: MainAxisSize
                          .min, // Usei essa propriedade para ajustar o tamanho da coluna ao conteúdo
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // Usei essa propriedade para alinhar o conteúdo à esquerda
                      children: [
                        Text('Descrição: ${video.description}'),
                        Text('Tipo: ${video.type}'),
                        Text(
                            'Classificação indicativa:${video.ageRestriction}'),
                        Text('Duração em minutos: ${video.durationMinutes}'),
                        Text('Data de lançamento: ${video.releaseDate}'),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          // Ação para fechar o diálogo
                          Navigator.pop(context);
                        },
                        child: Text(
                            'Fechar'), // Usei um texto em vez de um ícone para o botão de fechar
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        // Adicionei um botão flutuante para adicionar um novo vídeo
        child: Icon(Icons.add),
        onPressed: () {
          // Crie um novo objeto Video com os dados que você quiser
          Video newVideo = Video(
            id: 3,
            name: 'Video 3',
            description: 'Descrição do Video 3',
            genre: 'Comedy',
            type: 'Filme',
            ageRestriction: '12 anos',
            durationMinutes: 90,
            image: 'assets/images/alvo.png',
            releaseDate: '01/03/2020',
          );
          addVideo(newVideo); // Chamei o método de adicionar o vídeo
        },
      ),
    );
  }
}
