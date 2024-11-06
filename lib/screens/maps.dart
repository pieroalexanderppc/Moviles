import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async'; // Necesario para el Completer
import 'maps.dart'; // Importa la pantalla de mapas
import 'relax.dart'; // Importa la pantalla de Relax
import 'menu.dart'; // Importa la pantalla del menú
import 'rutas.dart'; // Importa la pantalla del menú
import 'senderismo.dart'; // Importa la pantalla del menú
import 'yunga.dart'; // Importa la pantalla del menú
import '../main.dart'; // Importa el archivo main.dart donde está la clase MyApp
import 'package:aplicacion_boceto/screens/payment_page.dart';

void main() {
  runApp(const MapsPage());
}

class MapsPage extends StatelessWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Turismo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
        useMaterial3: true,
      ),
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-12.0464, -77.0428), // Cambié las coordenadas a las tuyas
    zoom: 14.0,
  );

  static const CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );

  int _currentIndex = 0;

  List<String> savedPlaces = ['Lugar A', 'Lugar B'];
  List<String> favoritePlaces = ['Lugar C', 'Lugar D'];

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa de Turismo'),
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
                  // Acción para "Mi perfil"
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
      body: _currentIndex == 0
          ? Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  right: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Ingresa tu búsqueda',
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: FloatingActionButton.extended(
                    onPressed: _goToTheLake,
                    label: const Text('To the lake!'),
                    icon: const Icon(Icons.directions_boat),
                  ),
                ),
              ],
            )
          : _currentIndex == 1
              ? _buildSavedPlaces()
              : _buildFavoritePlaces(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.location_pin, color: Colors.red),
            label: 'Mapa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border, color: Colors.black),
            label: 'Guardado',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border, color: Colors.yellow),
            label: 'Favoritos',
          ),
        ],
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black,
        backgroundColor: Color(0xFFFFD194),
      ),
    );
  }

  Widget _buildSavedPlaces() {
    return ListView.builder(
      itemCount: savedPlaces.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(savedPlaces[index]),
        );
      },
    );
  }

  Widget _buildFavoritePlaces() {
    return ListView.builder(
      itemCount: favoritePlaces.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(favoritePlaces[index]),
        );
      },
    );
  }
}
