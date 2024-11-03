import 'package:flutter/material.dart';
import 'maps.dart';
import 'relax.dart';
import '../main.dart';
import 'profile.dart';

import 'rutas.dart';
import 'menu.dart';
import 'profile.dart';
import '../main.dart'; // Importa el archivo main.dart donde está la clase MyAppu6th ntgyhj
import 'senderismo.dart';

void main() {
  runApp(const YungaPage());
}

class YungaPage extends StatelessWidget {
  const YungaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yunga Parque Ferial',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.orangeAccent), // Colores conservados de menu.dart
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Yunga Parque Ferial'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFE07C24),
                  Color(0xFFE6B800)
                ], // Conservando los colores del AppBar de menu.dart
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
                  MaterialPageRoute(
                      builder: (context) => const SenderismoPage()),
                );
              } else if (result == 'Relax') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RelaxPage()),
                );
              } else if (result == 'Rutas') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RutasAccesoPage()),
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
                  backgroundImage: AssetImage(
                      'assets/usuario.png'), // Asegúrate de tener este archivo en assets
                ),
                onSelected: (String result) {
                  if (result == 'Mi perfil') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePage()),
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
              colors: [
                Color(0xFFFFD194),
                Color(0xFFFFA751)
              ], // Conservando el fondo de menu.dart
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Elimina o reduce el espacio superior
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 3.0, vertical: 8.0), // Reduciendo el padding
                  child: Image.asset(
                    'assets/juegos_extremos.gif', // Carga el GIF desde assets
                    height: 100.0, // Ajusta el tamaño del GIF
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                    height:
                        3), // Ajusta este valor para reducir o eliminar espacio
                _buildActivityCard(
                  context,
                  'Canopy',
                  'Disfruta de la adrenalina pura al volar por el aire con nuestro canopy.',
                  'assets/canopy.jpg',
                ),
                _buildActivityCard(
                  context,
                  'Zipline Bike',
                  'Siente la emoción de montar una bicicleta por los cielos.',
                  'assets/zipline_bike.jpg',
                ),
                _buildActivityCard(
                  context,
                  'Puente Tibetano',
                  'Cruza un emocionante puente colgante con vistas impresionantes.',
                  'assets/puente_tibetano.jpg',
                ),
                _buildActivityCard(
                  context,
                  'Columpio Extremo',
                  'Desafía la gravedad y siente la emoción en nuestro columpio extremo.',
                  'assets/columpio_extremo.jpg',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActivityCard(BuildContext context, String title,
      String description, String imagePath) {
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
                imagePath, // Cargar la imagen desde assets
                fit: BoxFit.cover,
                height: 150.0, // Altura estándar para las imágenes
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
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    description,
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.bodyMedium,
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
