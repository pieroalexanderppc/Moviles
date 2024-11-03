import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Para gestionar el sistema
import '../screens/menu.dart'; // Asegúrate de que esta pantalla esté definida

void main() {
  // Asegúrate de bloquear la orientación en vertical
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login - Turismo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
        useMaterial3: true,
      ),
      home: const LoginPage(), // LoginPage como pantalla principal
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Imagen de fondo
          Image.asset(
            'assets/tarata_fondo.jpg', // Asegúrate de que el archivo esté en la carpeta assets
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.5), // Oscurece el fondo
          ),
          // Contenido de la pantalla
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logotipo en la parte superior
              Image.asset(
                'assets/tarata_logo.png', // Asegúrate de que el archivo esté en la carpeta assets
                height: 150,
              ),
              const SizedBox(height: 40),
              // Botón de inicio de sesión con Google
              ElevatedButton(
                onPressed: () {
                  // Lógica del botón de Google
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Funcionalidad de Google no implementada')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: const Text(
                  'Ingreso con cuenta Google',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              // Botón de inicio de sesión con correo electrónico
              ElevatedButton(
                onPressed: () {
                  // Lógica del botón de correo electrónico
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Funcionalidad de Correo no implementada')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: const Text(
                  'Ingreso con Correo Electrónico',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              // Botón de inicio de sesión (Sign In)
              ElevatedButton(
                onPressed: () {
                  // Navegar a MenuPage (pantalla principal)
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MenuPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: const Text(
                  'Sign In',
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
