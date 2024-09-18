import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RandomImageScreen extends StatefulWidget {
  const RandomImageScreen({Key? key}) : super(key: key);

  @override
  _RandomImageState createState() => _RandomImageState();
}

class _RandomImageState extends State<RandomImageScreen> {
  late Future<String> _imageUrl;

  @override
  void initState() {
    super.initState();
    _imageUrl = fetchRandomImage();
  }

  Future<String> fetchRandomImage() async {
    final response = await http.get(Uri.parse('https://api.thecatapi.com/v1/images/search'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      
      if (jsonResponse.isNotEmpty) {
        return jsonResponse[0]['url'] as String;
      } else {
        throw Exception('No image found');
      }
    } else {
      throw Exception('Failed to load image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Cat Images'),
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: _imageUrl,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Image.network(snapshot.data ?? '');
            }
          },
        ),
      ),
    );
  }
}
