import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  Map<String, dynamic>? paymentIntentData;

  @override
  void initState() {
    super.initState();
    // Configuración inicial de Stripe
    stripe.Stripe.publishableKey = "pk_test_51QI20nIIsjRjLyuyQ8yUHWsUv0OtmPWh9gmpV9CM5LotMFBY7nXFiHVnqqwBniVWvKrdBJr8xiQzXHj5kkmc2tiw005AKKOJ7P";
  }

  Future<void> makePayment(String amount, String currency) async {
    try {
      // Crear un Payment Intent en Stripe
      paymentIntentData = await createPaymentIntent(amount, currency); // Monto y moneda
      await stripe.Stripe.instance.initPaymentSheet(
        paymentSheetParameters: stripe.SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          merchantDisplayName: 'Tu Negocio',
        ),
      );
      await displayPaymentSheet(amount, currency);
    } catch (e) {
      print('Error en el pago: \$e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error en el pago: \$e")),
      );
    }
  }

  displayPaymentSheet(String amount, String currency) async {
    try {
      // Presenta la hoja de pago de Stripe al usuario
      await stripe.Stripe.instance.presentPaymentSheet();

      // Si llega aquí, significa que el pago fue exitoso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("¡Pago completado!")),
      );

      // Generar el código QR después del pago exitoso
      if (paymentIntentData != null && paymentIntentData!.containsKey('id')) {
        await generateQRCode(paymentIntentData!['id'], amount, currency);
      } else {
        print("No se pudo generar el QR: paymentIntentData no contiene 'id'");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: No se pudo generar el código QR")),
        );
      }

      // Limpia los datos del intento de pago
      paymentIntentData = null;
    } catch (e) {
      // Si hay un error en la presentación del pago, mostramos "Pago cancelado"
      print("Error al mostrar la hoja de pago: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Pago cancelado o error en el pago")),
      );
    }
  }

  Future<void> generateQRCode(String paymentId, String amount, String currency) async {
    try {
      // Realiza la solicitud al backend para generar el QR
      final response = await http.post(
        Uri.parse('http://161.132.50.234:3000/api/procesar-pago'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'paymentId': paymentId,
          'amount': amount,
          'currency': currency,
        }),
      );

      // Manejo de la respuesta
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final qrCodeImage = data['qrCodeImage'];

        // Mostrar un diálogo emergente con el código QR
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Código QR del Pago"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.memory(base64Decode(qrCodeImage.split(',').last)),
                  SizedBox(height: 20),
                  Text("¡Código QR generado con éxito!")
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cerrar"),
                ),
              ],
            );
          },
        );
      } else {
        // Si el backend devuelve un error
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("Error al generar el código QR: ${response.statusCode}"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cerrar"),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Si ocurre un error en la solicitud
      print('Error en la generación del QR: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Error al conectar con el servidor"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cerrar"),
              ),
            ],
          );
        },
      );
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization': 'Bearer sk_test_51QI20nIIsjRjLyuy1A4wOfkKJUuLzo70uSX89W8w0JYfUuBP6vUHI4AuW81b1LWSNo8PCj8hUlq6eUN1bkdn44eG00pl9QrY9Z',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
      );
      return jsonDecode(response.body);
    } catch (err) {
      throw Exception('Error al crear el intento de pago: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Método de Pago")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                await makePayment('1000', 'PEN'); // Monto en centavos
              },
              child: Column(
                children: [
                  Image.asset('assets/unitario.png', height: 100),
                  SizedBox(height: 10),
                  Text('Paquete Individual - 10 PEN'),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await makePayment('1800', 'PEN'); // Monto en centavos
              },
              child: Column(
                children: [
                  Image.asset('assets/companero.png', height: 100),
                  SizedBox(height: 10),
                  Text('Paquete Acompañado - 18 PEN'),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await makePayment('3200', 'PEN'); // Monto en centavos
              },
              child: Column(
                children: [
                  Image.asset('assets/familiar.png', height: 100),
                  SizedBox(height: 10),
                  Text('Paquete Familiar - 32 PEN'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QrDisplayScreen extends StatelessWidget {
  final String qrCodeImage;

  QrDisplayScreen({required this.qrCodeImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Código QR del Pago")),
      body: Center(
        child: Image.memory(
          base64Decode(qrCodeImage.split(',').last),
        ),
      ),
    );
  }
}
