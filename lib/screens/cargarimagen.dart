import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class SubirImagen extends StatefulWidget {
  const SubirImagen({super.key, required this.title});

  final String title;

  @override
  State<SubirImagen> createState() => _SubirImagenState();
}

class _SubirImagenState extends State<SubirImagen> {
  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);

      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);

      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (e) {
      print('Failed to take image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subir una imagen'),
      ),
      body: Center(
        child: Column(
          children: [
            MaterialButton(
              color: Colors.blue,
              child: const Text(
                "Subir imagen de galeria",
                style: TextStyle(
                    color: Colors.white70, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                pickImage();
              },
            ),
            MaterialButton(
              color: Colors.blue,
              child: const Text(
                "Cargar imagen de camara",
                style: TextStyle(
                    color: Colors.white70, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                pickImageC();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            image != null
                ? Image.file(image!)
                : const Text('No se a selecionado imagen')
          ],
        ),
      ),
    );
  }
}
