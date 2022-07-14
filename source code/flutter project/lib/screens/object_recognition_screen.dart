import 'package:flutter/material.dart';
import 'dart:io' as io;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter_tts/flutter_tts.dart';

class ObjectRecognitionScreen extends StatefulWidget {
  const ObjectRecognitionScreen({Key? key}) : super(key: key);

  @override
  State<ObjectRecognitionScreen> createState() => _ObjectRecognitionScreenState();
}

class _ObjectRecognitionScreenState extends State<ObjectRecognitionScreen> {
  io.File? _image;
  final picker = ImagePicker();
  String message = '';
  double width = 300.0;
  double height = 300.0;
  FlutterTts flutterTts = FlutterTts();
  String msg = '';

  void speak() async
  {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(0.6);
    await flutterTts.speak(msg);
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    _image = io.File(pickedFile!.path);
    String base64Image = base64Encode(_image!.readAsBytesSync());
    // THE IPv4 ADDRESS MUST BE CHANGED WHEN CHANGING THE LAPTOP/PC !!!!!!!!!!!!
    var url = 'http://192.168.1.2:5000/';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(
          {
            'task': 'recognize objects',
            'image': base64Image
          }
      ),
      headers: {'Content-Type': "application/json"},
    );
    print('Status Code: +${response.statusCode}');
    print('Return Data: +${response.body}');
    setState(() {
      _image = _image;
      width = height = 0;
      message = msg = response.body;
    });
    if(message == '')
      {
        message = msg = 'No objects have been recognized !';
      }
    speak();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Object Recognition'),
            backgroundColor: Color(0xFF090F32),
          ),
          backgroundColor: Color(0xFF141A3C),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _image == null
                    ? Center(
                    child: Text(
                      'No Image Selected !',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                      ),
                    ))
                    : Center(child: Image.file(_image!)),
                SizedBox(
                  height: 15.0,
                ),
                InkWell(
                  onTap: getImage,
                  child: Ink.image(
                    image: AssetImage('assets/camera.png'),
                    width: width,
                    height: height,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 3.0,
                ),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
