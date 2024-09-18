import 'package:flutter/material.dart';

class Reto1Screen extends StatefulWidget {
  const Reto1Screen({Key? key}) : super(key: key);

  @override
  _Reto1ScreenState createState() => _Reto1ScreenState();
}

class _Reto1ScreenState extends State<Reto1Screen> {
  final TextEditingController _textController = TextEditingController();
  String _inputText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[300],
        title: const Text(
          'Escribir texto',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 5,
        shadowColor: Colors.black45,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 255, 255, 255), Color.fromARGB(255, 228, 224, 222)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Campo de texto con mejor diseño
              Card(
                elevation: 8,
                shadowColor: Colors.black12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: CustomTextField(
                    controller: _textController,
                    onChanged: (value) {
                      setState(() {
                        _inputText = value;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Botón personalizado con animación
              CustomButton(
                text: 'Mostrar Texto',
                onPressed: () {
                  if (_inputText.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Texto ingresado: $_inputText'),
                        duration: const Duration(seconds: 2),
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Por favor ingrese algo de texto.'),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({Key? key, required this.text, required this.onPressed}) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: _isHovered
            ? [BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(0, 8))]
            : [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        onHover: (hovering) {
          setState(() {
            _isHovered = hovering;
          });
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.lightBlue[300]), // Fondo azul claro
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          overlayColor: MaterialStateProperty.all(Colors.lightBlueAccent), // Color de animación de toque
          elevation: MaterialStateProperty.all(10), // Elevación para mejor efecto 3D
        ),
        child: Text(
          widget.text,
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const CustomTextField({Key? key, required this.controller, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlueAccent), // Azul claro para el borde
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlueAccent), // Azul claro para el borde habilitado
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlueAccent), // Azul claro para el borde cuando está enfocado
        ),
        labelText: 'Ingresa el texto',
        labelStyle: TextStyle(color: Colors.lightBlueAccent), // Azul claro para la etiqueta
      ),
      style: const TextStyle(color: Colors.black), // Texto negro ingresado
      cursorColor: Colors.lightBlue[300], // Azul claro para el cursor
    );
  }
}
