import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:eye_guide/screens/face_recognition_screen.dart';
import 'package:eye_guide/screens/object_recognition_screen.dart';
import 'package:eye_guide/screens/currency_recognition_screen.dart';
import 'package:eye_guide/screens/ocr_screen.dart';

class FeaturesScreen extends StatefulWidget
{
  const FeaturesScreen({Key? key}) : super(key: key);

  @override
  State<FeaturesScreen> createState() =>
      _FeaturesScreenState();
}

class _FeaturesScreenState extends State<FeaturesScreen> {

  FlutterTts flutterTts = FlutterTts();
  String msg = 'Welcome to Eye Guide application. I will tell you the app options, please listen carefully. Say 1 for face recognition, 2 for object recognition, 3 for currency recognition, or 4 for OCR';
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _Text = '';

  void speak() async
  {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(0.6);
    await flutterTts.speak(msg);
  }

  @override
  void initState() {
    speak();
    _speech = stt.SpeechToText();
  }

  void takeAction()
  {
    List one_list = ['1','one','when'];
    List two_list = ['2','two','to','too','do'];
    List three_list = ['3','three'];
    List four_list = ['4','four','for'];
    if(_Text!='')
      {
        if(one_list.contains(_Text))
          {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FaceRecognitionScreen()),
            );
          }
        else if(two_list.contains(_Text))
          {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ObjectRecognitionScreen()),
            );
          }
        else if(three_list.contains(_Text))
        {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CurrencyRecognitionScreen()),
          );
        }
        else if(four_list.contains(_Text))
        {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OCR_Screen()),
          );
        }
      }
  }

  void _listen() async
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
                takeAction();
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Home Page'),
            backgroundColor: Color(0xFF090F32),
          ),
          backgroundColor: Color(0xFF141A3C),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text(
                    'Feature Selection',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                InkWell(
                  onTap: _listen,
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
