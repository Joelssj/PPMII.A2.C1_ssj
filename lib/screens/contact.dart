import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Biblioteca para manejar URLs como llamadas telefónicas y mensajes de texto.

void main() => runApp(const ContactApp());

class ContactApp extends StatelessWidget {
  const ContactApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.lightBlueAccent, // Azul claro
          elevation: 0,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF90CAF9), // Botón flotante en azul claro
        ),
      ),
      home: const ContactScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<Map<String, String>> _names = [];
  final List<Map<String, String>> _predefinedNames = [
    {'name': 'Joel de Jesus Lopez Ruiz', 'matricula': '221204', 'phone': '9661130883'},
    {'name': 'Carlos Eduardo Gumeta Navarro', 'matricula': '221199', 'phone': '9711315960'},
    {'name': 'Jesus Alejandro Guillen Luna', 'matricula': '221198', 'phone': '9651052289'}
  ];

  @override
  void initState() {
    super.initState();
    // Inicializamos la lista con los contactos al iniciar la pantalla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (int i = 0; i < _predefinedNames.length; i++) {
        _names.add(_predefinedNames[i]);
        _listKey.currentState?.insertItem(i, duration: const Duration(milliseconds: 500));
      }
    });
  }

  // Método para enviar un mensaje de texto a un número específico.
  void _sendMessage(String number) async {
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: number,
    );
    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      throw 'No se pudo enviar el mensaje a $number';
    }
  }

  // Método para realizar una llamada telefónica a un número específico.
  void _makeCall(String number) async {
    final Uri telUri = Uri(
      scheme: 'tel',
      path: number,
    );
    if (await canLaunchUrl(telUri)) {
      await launchUrl(telUri);
    } else {
      throw 'No se pudo realizar la llamada a $number';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, 
      appBar: AppBar(
        title: const Text('Contactos', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // Acción de búsqueda
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onSelected: (String value) {
              // Acción de menú seleccionada
            },
            itemBuilder: (BuildContext context) {
              return {'Configurar', 'Ayuda'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
        backgroundColor: Colors.lightBlueAccent, // Fondo azul claro
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Fondo con color sólido
          Container(
            color: Colors.blue[50], // Fondo azul muy claro
          ),
          // Lista animada de contactos
          Padding(
            padding: const EdgeInsets.only(top: 100.0), // Ajuste para dejar espacio al AppBar
            child: AnimatedList(
              key: _listKey,
              initialItemCount: _names.length,
              itemBuilder: (context, index, animation) {
                return _buildItem(_names[index], animation);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aquí puedes agregar una funcionalidad si lo deseas, pero no es necesario para mostrar contactos
        },
        tooltip: 'Agregar Contactos',
        child: const Icon(Icons.add, color: Colors.black), // Icono negro
        backgroundColor: Colors.lightBlueAccent, // Azul claro personalizado
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        color: Colors.white, // Fondo blanco
        elevation: 10,
        child: Container(
          height: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.home, color: Colors.black),
                onPressed: () {
                  // Acción para ir a la pantalla de inicio
                },
              ),
              const SizedBox(width: 30), // Espacio para el botón flotante
              IconButton(
                icon: const Icon(Icons.chat_bubble_outline, color: Colors.black),
                onPressed: () {
                  // Acción para ir a la pantalla de contactos
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem(Map<String, String> contact, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 6, // Elevación para sombras suaves
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.lightBlueAccent, // Fondo azul claro
            child: Text(
              contact['name']![0], // Inicial del nombre
              style: const TextStyle(color: Colors.white),
            ),
          ),
          title: Text(contact['name']!),
          subtitle: Text('Matrícula: ${contact['matricula']}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.call, color: Colors.green),
                onPressed: () {
                  _makeCall(contact['phone']!); // Realizar llamada
                },
              ),
              IconButton(
                icon: const Icon(Icons.message, color: Colors.blue),
                onPressed: () {
                  _sendMessage(contact['phone']!); // Enviar mensaje
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackbarMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
