import 'package:flutter/material.dart';
import 'menu.dart'; // Importa la pantalla del menú
import 'rutas.dart'; // Importa la pantalla del menú
import 'senderismo.dart'; // Importa la pantalla del menú
import 'yunga.dart'; // Importa la pantalla del menú
import 'maps.dart';
import 'relax.dart';
import 'profile.dart';
import '../main.dart'; // Importa el archivo main.dart donde está la clase MyApp
void main() {
  runApp(const RutasAccesoPage()); // Ejecuta directamente la página de Rutas de Acceso
}

class RutasAccesoPage extends StatelessWidget {
  const RutasAccesoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rutas de Acceso',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent), // Mismo esquema de color que Relax y Senderismo
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Rutas de Acceso'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE07C24), Color(0xFFE6B800)], // Mismos colores que las otras páginas
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
              colors: [Color(0xFFFFD194), Color(0xFFFFA751)], // Mismo gradiente que Relax y Senderismo
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildSection(
                  context,
                  'Plaza de Armas',
                  'Visita la emblemática Plaza de Armas, punto central de la ciudad.',
                  'assets/plaza.png',
                  '''
                  La plaza de Tarata se encuentra situado a una altitud de 3070 metros sobre el nivel del mar 
                  La actual Plaza Principal fue inaugurada el 7 de junio de 1956, 
                  Consta de un busto principal en el 
                  que se encuentra plasmado el Centauro de las Vilcas, Coronel Gregorio Albarracín Lanchipa; dos 
                  astas que sirven para izar el Pabellón Nacional y la bandera de Tarata: tiene también una Lámpara 
                  Votiva.
                  Se encuentra rodeada por cuatro jardines con dos glorietas en la parte superior y dos piletas 
                  ornamentales en la parte inferior. En el centro de la plaza en un robusto eucalipto se hizo la bandera 
                  peruana, al retornar a la patria después de años en poder de Chile durante la Guerra del Pacífico.

                  ''',
                ),
                _buildSection(
                  context,
                  'Iglesia Tarucachi',
                  'Explora la Iglesia Tarucachi, una joya arquitectónica de la región.',
                  'assets/iglesia.jpg',
                  '''
                  El templo San Benedicto se encuentra situado a una altitud de 3077 metros sobre el nivel del 
                  mar (msnm).
                  El templo San Benedicto de Tarata, de origen colonial y uno de los más antiguos de la región Tacna, 
                  fue reconocido como Patrimonio Cultural de la Nación por el Ministerio de Cultura.
                  El templo de San Benedicto de Tarata, es una de las más antiguas del departamento de Tacna. Su 
                  construcción se inició en 1611 y fue inaugurada el 3 de enero de 1741 y referenciada en el 
                  Inventario de la Iglesia de Tarata de 1904.

                  ''',
                ),
                _buildSection(
                  context,
                  'Municipalidad Provincial de Tarata',
                  'La sede administrativa más importante de Tarata.',
                  'assets/municipalidad.png',
                  '''
                  Miguel Grau, Tarata 23200- Frente a la plaza principal de Tarata
                  Se encuentra situado a una altitud de 3076 metros sobre el nivel del mar 8 (msnm).
                  La municipalidad provincial de Tarata tiene como misión organizar y conducir la gestión pública de
                  acuerdo a sus competencias basadas en la ampliación de fuentes de trabajo estable y formal, con 
                  mejoramiento de la calidad educativa

                  ''',
                ),
                _buildSection(
                  context,
                  'Mercado Central',
                  'Descubre el Mercado Central y disfruta de los productos locales.',
                  'assets/mercado.png',
                  '''
                  El Mercado Central de Abastos Tarata es un centro de abastecimiento zonal de tipo Minorista que 
                  Es tradicional en su comunidad.

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
