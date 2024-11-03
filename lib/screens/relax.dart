import 'package:flutter/material.dart';
import 'menu.dart';
import 'rutas.dart';
import 'senderismo.dart';
import 'yunga.dart';
import 'maps.dart';
import 'profile.dart';
import '../main.dart';

void main() {
  runApp(const RelaxPage());
}

class RelaxPage extends StatelessWidget {
  const RelaxPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Relax',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Relax'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE07C24), Color(0xFFE6B800)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          leading: _buildPopupMenu(context),
          actions: [_buildProfileMenu(context)],
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFFD194), Color(0xFFFFA751)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildSection(
                  context,
                  'Baños termales de Putina - Ticaco',
                  'Disfruta de pozas de agua caliente rodeadas de naturaleza.',
                  'assets/banos_termales.jpg',
                  '''
                  Ubicación: 3200 msnm, 13.5 km de Tarata.
                  Tarifas: S/10.00 (extranjeros) y S/7.00 (nacionales) para pozas; S/5.00 para la piscina.
                  Ideal para todos, especialmente adultos mayores con reumatismo.
                  ''',
                ),
                _buildSection(
                  context,
                  'Taller de Cerámica',
                  'Participa en talleres de cerámica y alfarería.',
                  'assets/taller_ceramica.jpg',
                  '''
                  Ubicado al lado de la plaza principal de Ticaco. 
                  Aprende técnicas ancestrales y contribuye a la artesanía local.
                  ''',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PopupMenuButton<String> _buildPopupMenu(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.menu),
      onSelected: (String result) {
        _navigateToPage(context, result);
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem(value: 'Menu', child: Text('Menu')),
        const PopupMenuItem(value: 'Senderismo', child: Text('Senderismo')),
        const PopupMenuItem(value: 'Relax', child: Text('Relax')),
        const PopupMenuItem(value: 'Rutas', child: Text('Rutas')),
        const PopupMenuItem(value: 'Yunga', child: Text('Yunga')),
        const PopupMenuItem(value: 'GPS', child: Text('GPS')),
      ],
    );
  }

  void _navigateToPage(BuildContext context, String page) {
    // Implement navigation logic here based on page value
  }

  PopupMenuButton<String> _buildProfileMenu(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const CircleAvatar(
        backgroundImage: AssetImage('assets/usuario.png'),
      ),
      onSelected: (String result) {
        if (result == 'Mi perfil') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ProfilePage()),
          );
        } else if (result == 'Cerrar sesión') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MyApp()),
          );
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem(value: 'Mi perfil', child: Text('Mi perfil')),
        const PopupMenuItem(
            value: 'Cerrar sesión', child: Text('Cerrar sesión')),
      ],
    );
  }

  Widget _buildSection(BuildContext context, String title, String description,
      String imagePath, String details) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                height: 150.0,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.8,
                              child: Scrollbar(
                                thickness: 4.0,
                                thumbVisibility: true,
                                radius: const Radius.circular(10),
                                child: SingleChildScrollView(
                                  padding: const EdgeInsets.all(16.0),
                                  physics: const ClampingScrollPhysics(),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.arrow_back),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          Text(
                                            title,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8.0),
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        child: Image.asset(
                                          imagePath,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Text(
                                        details,
                                        textAlign: TextAlign.justify,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: const Text('Más información'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
