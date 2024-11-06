import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
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
    Stripe.publishableKey = "pk_test_51QI20nIIsjRjLyuyQ8yUHWsUv0OtmPWh9gmpV9CM5LotMFBY7nXFiHVnqqwBniVWvKrdBJr8xiQzXHj5kkmc2tiw005AKKOJ7P"; // Reemplaza con tu clave pública
  }

  Future<void> makePayment() async {
    try {
      // Crear un Payment Intent en Stripe
      paymentIntentData = await createPaymentIntent('100', 'USD'); // Monto y moneda
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          merchantDisplayName: 'Tu Negocio',
        ),
      );
      await displayPaymentSheet();
    } catch (e) {
      print('Error en el pago: $e');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("¡Pago completado!")),
      );
      paymentIntentData = null;
    } catch (e) {
      print("Error al mostrar la hoja de pago: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Pago cancelado")),
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
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await makePayment();
          },
          child: Text("Pagar ahora"),
        ),
      ),
    );
  }
}
