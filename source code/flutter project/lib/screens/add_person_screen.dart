import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'dart:io' as io;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class AddPersonScreen extends StatefulWidget
{
  const AddPersonScreen({Key? key}) : super(key: key);

  @override
  State<AddPersonScreen> createState() =>
      _AddPersonScreenState();
}

class _AddPersonScreenState extends State<AddPersonScreen> {

  FlutterTts flutterTts = FlutterTts();
  String msg = '';
  late stt.SpeechToText _speech;
  bool _isListening = false;
  late String _Text;

  void speak() async
  {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(0.6);
    await flutterTts.speak(msg);
  }

  @override
  void initState() {
    _speech = stt.SpeechToText();
  }

  Future _listen() async
  {
    if(!_isListening)
    {
      bool available = await _speech.initialize(
          onStatus: (val) => print('onStatus: $val'),
          onError: (val) => print('onError: $val')
      );
      if(available)
      {
        setState(() {
          _isListening = true;
          _speech.listen(
              onResult: (val) => setState(() {
                _Text = val.recognizedWords;
              })
          );
        });
      }
    }
    else
    {
      setState(() {
        _isListening = false;
      });
      _speech.stop();
    }
    print('Text: $_Text');
  }

  Future getName() async {
    await _listen();
    String name = _Text;
    // THE IPv4 ADDRESS MUST BE CHANGED WHEN CHANGING THE LAPTOP/PC !!!!!!!!!!!!
    var url = 'http://192.168.1.2:5000/';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(
          {
            'task': 'add a person',
            'name' : name
          }),
      headers: {'Content-Type': "application/json"},
    );
    print('Status Code: +${response.statusCode}');
    print('Return Data: +${response.body}');
    setState(() {
      msg = response.body;
    });
    speak();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Add a New Person'),
            backgroundColor: Color(0xFF090F32),
          ),
          backgroundColor: Color(0xFF141A3C),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InkWell(
                  onTap: getName,
                  child: Ink.image(
                    image: AssetImage('assets/microphone.png'),
                    width: 300.0,
                    height: 300.0,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 3.0,
                ),
              ],
            ),
          )),
    );
  }
}
