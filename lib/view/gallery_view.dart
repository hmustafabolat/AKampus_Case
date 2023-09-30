import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:image_picker/image_picker.dart';

class GalleryView extends StatefulWidget {
  GalleryView({
    Key? key,
    this.text,
    required this.onImage, //Resim işleme işlemini gerçekleştirecek değişken.
    required this.point,
    required this.resetImage, //Resmi sıfırlamak için oluşturulan değişken.
  }) : super(key: key);

  final String? text;
  final int point;
  final Function(InputImage inputImage) onImage;
  final Function() resetImage;

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  File? image; //Seçilen veya çekilen resmi saklamak için oluşturduğum değişken.
  ImagePicker? imagePicker; //Resim seçme ve çekme işlemleri için bir nesne.

  @override
  void initState() {
    super.initState();

    imagePicker = ImagePicker();
  }

  void _restartImage() {
    setState(() {
      image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        image != null
            ? SizedBox(
                height: 400,
                width: 400,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image.file(image!), //Seçilen resmi görüntüleme.
                  ],
                ),
              )
            : Icon(
                Icons.image,
                size: 200,
              ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
            child: Text('From Gallery'),
            onPressed: () => _getImage(ImageSource.gallery), //Galeriden resim seçmek için çağırılan işlev.
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 25),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
            child: Text('Take a picture'),
            onPressed: () => _getImage(ImageSource.camera), //Resim çekmek için çağırılan işlev.
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 25),
            child: Text(
              "Puan: ${widget.point}",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
          child: ElevatedButton.icon(
            onPressed: () {
              setState(() {
                image = null; // Resmi sıfırla
              });
              widget.resetImage(); // Reset işlevini çağır
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
            icon: Icon(Icons.refresh), // İkon eklemek için icon parametresi
            label: Text('Sıfırla'), // Metin eklemek için label parametresi
          ),
        ),

        if (image != null)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('${widget.text ?? ''}'), //Tanımlanan metni görüntüleme.
          ),
      ],
    );
  }

  Future _getImage(ImageSource source) async {
    setState(() {
      image = null;
    });
    final pickedFile = await imagePicker?.pickImage(source: source); //Resmi seçme veya çekme işlemi.
    if (pickedFile != null) {
      _processFile(pickedFile.path); //Seçilen veya çekilen resmi işleme işlemi.
    }
  }

  Future _processFile(String path) async {
    setState(() {
      image = File(path); //Seçilen veya çekilen resmi saklama.
    });
    final inputImage = InputImage.fromFilePath(path);
    widget.onImage(inputImage); //Resim işleme işlemini çağırma.
  }
}
