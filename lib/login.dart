import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart'; // Importa el paquete de íconos
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/menu.dart';
import '../admin/admihome.dart'; // Importar la pantalla de administrador
import 'registro.dart'; // Importar la pantalla de registro

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  // Función para redirigir al usuario según su rol
  Future<void> _redirectUser(BuildContext context, User user) async {
    try {
      // Obtener el documento del usuario desde Firestore
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        final String? role = userDoc['rol'];

        if (role == 'admin') {
          // Redirigir a AdminHome
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const AdminHome()),
          );
        } else if (role == 'usuario') {
          // Redirigir a MenuPage
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MenuPage()),
          );
        } else {
          throw Exception('Rol no definido');
        }
      } else {
        throw Exception('Documento de usuario no encontrado');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al redirigir usuario: $e')),
      );
    }
  }

  // Función para manejar el inicio de sesión con Google
  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        // El usuario canceló el inicio de sesión
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Crear una nueva credencial con el token de Google
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Iniciar sesión con Firebase
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Redirigir según el rol del usuario
      await _redirectUser(context, userCredential.user!);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error de inicio de sesión: $error')),
      );
    }
  }

  // Función para manejar el inicio de sesión con correo electrónico
  Future<void> _signInWithEmail(BuildContext context) async {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    // Mostrar un cuadro de diálogo para ingresar correo y contraseña
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ingreso con Correo Electrónico'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Correo Electrónico',
                ),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  // Intentar iniciar sesión con Firebase Auth
                  final UserCredential userCredential = await FirebaseAuth
                      .instance
                      .signInWithEmailAndPassword(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  );

                  // Redirigir según el rol del usuario
                  await _redirectUser(context, userCredential.user!);
                } catch (e) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e')),
                  );
                }
              },
              child: const Text('Ingresar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/tarata_fondo.jpg',
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/tarata_logo.png',
                height: 150,
              ),
              const SizedBox(height: 40),
              // Botón de Google con ícono de flutter_icons_null_safety
              ElevatedButton.icon(
                onPressed: () => _signInWithGoogle(context),
                icon: const Icon(Icons.report_gmailerrorred, color: Colors.white), // Ícono de Google
                label: const Text('Ingreso con cuenta Google', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[700], // Color de fondo de Google
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
              const SizedBox(height: 20),
              // Botón de Correo Electrónico con ícono de Flutter
              ElevatedButton.icon(
                onPressed: () => _signInWithEmail(context),
                icon: const Icon(Icons.email, color: Colors.white), // Ícono de correo
                label: const Text('Ingreso con Correo Electrónico', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700], // Color de fondo del botón
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
              const SizedBox(height: 20),
              // Botón de Registrarse
              ElevatedButton(
                onPressed: () {
                  // Redirige al registro
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegistroPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700], // Color verde para registrarse
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: const Text(
                  'Registrarse',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
