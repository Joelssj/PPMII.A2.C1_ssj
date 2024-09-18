import 'package:flutter/material.dart';
//import 'package:flutter_application/screens/reto1.dart';
//import 'package:flutter_application/screens/reto2.dart';
import 'screens/imagen.dart';
import 'screens/texto.dart';
import 'screens/home.dart';
import 'screens/contact.dart';
import 'screens/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joelssj',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/contact': (context) => const ContactScreen(),
        '/reto1': (context) => const Reto1Screen(),
        '/reto2': (context) => const RandomImageScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}