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
  List allowedList = [
    'pantene',
    'gilette',
    'orkid'
  ]; //Aranmasını istediğim kelimeleri bir listede tutuyorum.
  var _textRecognizer = TextRecognizer(
      script: TextRecognitionScript
          .latin); //Google ML Kit Text Recognition'ı kullanmak için bir nesne üretiyorum.
  bool _isBusy =
      false; //İşlemlerin devam edip etmediğini kontrol eden değişken.
  String? _text; //Tanımlanan metni tutan değişken.
  int point = 0; //Alınan puanı tutan değişken.

  @override
  void dispose() async {
    _textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Text Detector'),
      ),
      body: GalleryView(
        text: _text, //Tanımlanan metin
        onImage: _processImage, //Resim işleme özelliği
        point: point, //Puanı aktardık
        resetImage: _restartImage, //Resmin sıfırlanması için çağırılan özellik
      ),
    );
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (_isBusy)
      return; //İşlemin meşguliyet durumuna göre diğer işlemi bekliyoruz.
    _isBusy = true;

    setState(() {
      _text = ''; //Tanımlanan metni temizler.
    });

    final recognizedText = await _textRecognizer
        .processImage(inputImage); //Resimdeki metni tanımlayan işlem.
    bool findWord =
        false; //Dizide tanımladığımız kelimelerin bulunup bulunmadığını kontrol eden değişken.
    List textList = recognizedText.text
        .split(RegExp(r'\s+|\n+'))
        .map((e) => e.toLowerCase())
        .toList();
    //Tanımlanan metni küçük harflere ayırıp liste yapar.

    //Tanımlanan metin dizi içerisinde istenen kelimeleri bulunduruyorsa eğer kullanıcı puanına 10 ekle ve kelime bulundu diye işaretle.
    allowedList.forEach((element) {
      if (textList.contains(element)) {
        point += 10;
        findWord = true;
      }
    });

    if (findWord) {
      _text =
          'Recognized text:\n\n${recognizedText.text}'; //Tanınan metni sakla
    } else {
      _showDialog(context); //Kelime bulunmazsa eğer bildirim penceresi aç.
    }

    //Bütün işlemi serbest bırakan yapı.
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

  //Resmi, puanı ve çıktıyı sıfırlayan fonksiyon.
  void _restartImage() {
    setState(() {
      point = 0;
      _text = null;
    });
  }
}
