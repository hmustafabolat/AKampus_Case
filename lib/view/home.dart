import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import 'gallery_view.dart';
import 'dart:io';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeViewState();
}

class _HomeViewState extends State<Home> {
  List allowedList = ['pantene', 'gilete'];
  var _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  bool _isBusy = false;
  String? _text;

  int point = 0;

  @override
  void dispose() async {
    _textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Detector'),
        actions: [
          Center(
            child: Text("Puan : ${point}"),
          ),
        ],
      ),
      body: GalleryView(
        text: _text,
        onImage: _processImage,
      ),
    );
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (_isBusy) return;
    _isBusy = true;

    setState(() {
      _text = '';
    });

    final recognizedText = await _textRecognizer.processImage(inputImage);
    bool findWord = false;
    List textList = recognizedText.text
        .split(RegExp(r'\s+|\n+'))
        .map((e) => e.toLowerCase())
        .toList();

    allowedList.forEach((element) {
      if (textList.contains(element)) {
        point += 10;
        findWord = true;
      }
    });

    if (findWord) {
      _text = 'Recognized text:\n\n${recognizedText.text}';
    } else {
      _showDialog(context);
    }

    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning'),
          content: Text("IPA files are expected."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
