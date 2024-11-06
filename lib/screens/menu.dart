import 'package:aplicacion_boceto/screens/payment_page.dart';
import 'package:aplicacion_boceto/screens/profile.dart';
import 'package:aplicacion_boceto/screens/rutas.dart';
import 'package:aplicacion_boceto/screens/senderismo.dart';
import 'package:aplicacion_boceto/screens/yunga.dart';
import 'package:flutter/material.dart';
import 'maps.dart'; // Importa la pantalla de mapas
import 'relax.dart'; // Importa la pantalla de Relax
import '../main.dart'; // Importa el archivo main.dart donde está la clase MyApp

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú Principal'),
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
            }else if (result == 'Pago') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PaymentPage()),
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
            const PopupMenuItem<String>(
              value: 'Pago',
              child: Text('Pago'),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: PopupMenuButton<String>(
              icon: const CircleAvatar(
                backgroundImage: AssetImage('assets/usuario.png'),
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
      backgroundColor: const Color(0xFFFFD194),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildMenuCard(
                context, 'Yunga', 'assets/yunga.jpg', 'Descripción de Yunga'),
            _buildMenuCard(context, 'Senderismo', 'assets/senderismo.jpg',
                'Descripción de Senderismo'),
            _buildMenuCard(
                context, 'Relax', 'assets/relax.jpg', 'Descripción de Relax'),
            _buildMenuCard(
                context, 'Rutas', 'assets/rutas.jpg', 'Descripción de Rutas'),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, String title, String imagePath,
      String description) {
    return GestureDetector(
      onTap: () {
        if (title == 'Relax') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RelaxPage()),
          );
        } else if (title == 'Yunga') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const YungaPage()),
          );
        } else if (title == 'Senderismo') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SenderismoPage()),
          );
        } else if (title == 'Rutas') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RutasAccesoPage()),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
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
