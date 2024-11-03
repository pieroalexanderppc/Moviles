import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi perfil'),
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
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFD194), Color(0xFFFFA751)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/usuario.jpeg'), // Imagen del perfil
              ),
              const SizedBox(height: 20),
              const Text(
                'Nombre',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text('Mi plan de viaje', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 30),
              const Text('Mis Qrs', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 20),
              Image.asset('assets/qr.jpeg', width: 150, height: 150), // Usar el QR como JPG
            ],
          ),
        ),
      ),
    );
  }
}
