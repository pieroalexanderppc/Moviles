import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async'; // Necesario para el Completer
import 'package:geolocator/geolocator.dart'; // Para obtener la ubicación del usuario
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
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verificar si los servicios de ubicación están habilitados
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Los servicios de ubicación no están habilitados, no se puede continuar
      return;
    }

    // Verificar el permiso de ubicación
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Los permisos están denegados, no se puede continuar
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Los permisos están denegados para siempre, no se puede continuar
      return;
    }

    // Obtener la posición actual del usuario
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = position;
      _markers.add(
        Marker(
          markerId: MarkerId('mi_ubicacion'),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: InfoWindow(title: 'Mi Ubicación'),
        ),
      );
    });
  }

  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  final Set<Marker> _markers = {
    Marker(
      markerId: MarkerId('camino_inca'),
      position: LatLng(-17.473298384128178, -70.03273902200424),
      infoWindow: InfoWindow(title: 'Camino Inca'),
    ),
    Marker(
      markerId: MarkerId('cuevas_qala_qala'),
      position: LatLng(-17.468029819268292, -70.0377206851032),
      infoWindow: InfoWindow(title: 'Cuevas Qala Qala'),
    ),
    Marker(
      markerId: MarkerId('yunga_parque_extremo'),
      position: LatLng(-17.476600713977973, -70.04102428839693),
      infoWindow: InfoWindow(title: 'Yunga Parque Extremo'),
    ),
    Marker(
      markerId: MarkerId('banos_termales_putina_ticaco'),
      position: LatLng(-17.43414200794719, -70.0383996902475),
      infoWindow: InfoWindow(title: 'Baños Termales de Putina Ticaco'),
    ),
    Marker(
      markerId: MarkerId('taller_ceramica_alfebreria'),
      position: LatLng(-17.4444429341109, -70.0478549883975),
      infoWindow: InfoWindow(title: 'Taller de Cerámica y Alfarería'),
    ),
  };

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-17.473298384128178, -70.03273902200424), // Ajusta la posición inicial
    zoom: 14.0,
  );

  int _currentIndex = 0;

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
            } else if (result == 'Pago') {
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
                  markers: _markers,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ],
            )
          : _buildSavedPlaces(),
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
        ],
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black,
        backgroundColor: Color(0xFFFFD194),
      ),
    );
  }

  Widget _buildSavedPlaces() {
    List<Marker> markersList = _markers.toList();
    return ListView.builder(
      itemCount: markersList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(markersList[index].infoWindow.title ?? 'Lugar sin nombre'),
          onTap: () async {
            final GoogleMapController controller = await _controller.future;
            await controller.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: markersList[index].position,
                  zoom: 18.0,
                ),
              ),
            );
            setState(() {
              _currentIndex = 0;
            });
          },
        );
      },
    );
  }
}
