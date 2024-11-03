import 'package:flutter/material.dart';
import 'menu.dart'; // Importa la pantalla del menú
import 'rutas.dart'; // Importa la pantalla del menú
import 'senderismo.dart'; // Importa la pantalla del menú
import 'yunga.dart'; // Importa la pantalla del menú
import 'relax.dart';
import 'maps.dart';
import 'profile.dart';
import '../main.dart'; // Importa el archivo main.dart donde está la clase MyApp
void main() {
  runApp(const SenderismoPage()); // Ejecuta directamente la página de Senderismo
}

class SenderismoPage extends StatelessWidget {
  const SenderismoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Senderismo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent), // Mismo esquema de color que Relax
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Senderismo'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE07C24), Color(0xFFE6B800)], // Mismos colores que Relax
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          leading: PopupMenuButton<String>(
          icon: const Icon(Icons.menu),
          onSelected: (String result) {
            if (result == 'Menu') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MenuPage()),
              );
            } else if (result == 'Senderismo') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SenderismoPage()),
              );
            } else if (result == 'Relax') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RelaxPage()),
              );
            } else if (result == 'Rutas') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RutasAccesoPage()),
              );
            } else if (result == 'Yunga') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const YungaPage()),
              );
            } else if (result == 'GPS') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MapsPage()),
              );
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'Menu',
              child: Text('Menu'),
            ),
            const PopupMenuItem<String>(
              value: 'Senderismo',
              child: Text('Senderismo'),
            ),
            const PopupMenuItem<String>(
              value: 'Relax',
              child: Text('Relax'),
            ),
            const PopupMenuItem<String>(
              value: 'Rutas',
              child: Text('Rutas'),
            ),
            const PopupMenuItem<String>(
              value: 'Yunga',
              child: Text('Yunga'),
            ),
            const PopupMenuItem<String>(
              value: 'GPS',
              child: Text('GPS'),
            ),
          ],
        ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: PopupMenuButton<String>(
                icon: const CircleAvatar(
                  backgroundImage: AssetImage('assets/usuario.png'), // Asegúrate de tener este archivo en assets
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
                  const PopupMenuItem<String>(
                    value: 'Mi perfil',
                    child: Text('Mi perfil'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Cerrar sesión',
                    child: Text('Cerrar sesión'),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFFD194), Color(0xFFFFA751)], // Mismo gradiente que Relax
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildSection(
                  context,
                  'Camino Inca',
                  'Recorre el histórico Camino Inca, lleno de paisajes impresionantes.',
                  'assets/camino.png',
                  '''
                  Un sendero antiguo que conecta las maravillas arqueológicas.
                  ''',
                ),
                _buildSection(
                  context,
                  'Qala Qala',
                  'Descubre los misterios de las antiguas ruinas de Qala Qala.',
                  'assets/qala.png',
                  '''
                  Un sitio lleno de historia y energía ancestral.
                  ''',
                ),
                _buildSection(
                  context,
                  'Sitio Arqueológico',
                  'Explora el Sitio Arqueológico y sus secretos ocultos.',
                  'assets/sitio.png',
                  '''
                  Uno de los lugares más impresionantes de la región.
                  ''',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String description, String imagePath, String details) {
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                            style: Theme.of(context).textTheme.bodyMedium,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8.0),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15.0),
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
                                        style: Theme.of(context).textTheme.bodyMedium,
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
