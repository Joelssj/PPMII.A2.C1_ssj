import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[300],
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.contact_page, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, '/contact');
            },
          ),
          IconButton(
            icon: const Icon(Icons.text_fields, color: Colors.white), // Ícono de texto para Reto 1
            onPressed: () {
              Navigator.pushNamed(context, '/reto1');
            },
          ),
          IconButton(
            icon: const Icon(Icons.image, color: Colors.white), // Ícono de imagen para Reto 2
            onPressed: () {
              Navigator.pushNamed(context, '/reto2');
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: false,

      body: Stack(
        children: [
          // Fondo con color sólido
          Container(
            color: Colors.blue[50], // Fondo azul claro
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100.0), // Ajuste para dejar espacio para los íconos
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Barra de búsqueda
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Buscar...",
                        icon: Icon(Icons.search, color: Colors.black87),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30), // Ajustar espacio entre la barra de búsqueda y los iconos
                // Filas de categorías con iconos (Retos)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0), // Ajustar márgenes
                  child: SizedBox(
                    height: 100, // Aumentar la altura para que los iconos se vean completos
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildCategoryItem(Icons.text_fields, 'Texto', context, '/reto1'),
                        _buildCategoryItem(Icons.image, 'Imagen', context, '/reto2'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // Imagen para reemplazar el texto de bienvenida
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 45.0),
                  child: Center(
                    child: Image(
                      image: AssetImage('lib/assets/gokucito.png'), // Asegúrate de tener una imagen en tu carpeta assets
                      height: 200, // Ajusta el tamaño de la imagen
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.lightBlueAccent, // Color azul claro para el botón flotante
        child: const Icon(Icons.add, color: Colors.black), // Cambié el ícono a color negro
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0, // Reduce el espacio entre el botón y la barra
        color: Colors.white, // Color blanco para que contraste mejor
        elevation: 10, // Más elevación para mayor sombra
        child: Container(
          height: 60.0, // Ajusta el tamaño de la barra inferior
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.home, color: Colors.black),
                onPressed: () {
                  Navigator.pushNamed(context, '/home'); // Redirige a HomeScreen
                },
              ),
              const SizedBox(width: 30), // Espacio para el botón flotante
              IconButton(
                icon: const Icon(Icons.chat_bubble_outline, color: Colors.black),
                onPressed: () {
                  Navigator.pushNamed(context, '/contact');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget para construir una categoría de reto con icono y texto
  Widget _buildCategoryItem(IconData icon, String label, BuildContext context, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.lightBlue[100], // Fondo azul claro
            radius: 25,
            child: Icon(icon, color: Colors.black), // Ícono negro
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.black87), // Texto negro
          ),
        ],
      ),
    );
  }
}
