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
    required this.onImage,
  }) : super(key: key);

  final String? text;
  final Function(InputImage inputImage) onImage;

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  File? image;
  ImagePicker? imagePicker;

  @override
  void initState() {
    super.initState();

    imagePicker = ImagePicker();
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
                    Image.file(image!),
                  ],
                ),
              )
            : Icon(
                Icons.image,
                size: 200,
              ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ElevatedButton(
            child: Text('From Gallery'),
            onPressed: () => _getImage(ImageSource.gallery),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ElevatedButton(
            child: Text('Take a picture'),
            onPressed: () => _getImage(ImageSource.camera),
          ),
        ),
        if (image != null)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('${widget.text ?? ''}'),
          ),
      ],
    );
  }

  Future _getImage(ImageSource source) async {
    setState(() {
      image = null;
    });
    final pickedFile = await imagePicker?.pickImage(source: source);
    if (pickedFile != null) {
      _processFile(pickedFile.path);
    }
  }

  Future _processFile(String path) async {
    setState(() {
      image = File(path);
    });
    final inputImage = InputImage.fromFilePath(path);
    widget.onImage(inputImage);
  }
}
