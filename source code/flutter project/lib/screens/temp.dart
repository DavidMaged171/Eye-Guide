import 'package:flutter/material.dart';
import 'dart:io' as io;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:async';

class TempScreen extends StatefulWidget {
  const TempScreen({Key? key}) : super(key: key);

  @override
  State<TempScreen> createState() =>
      _TempScreenState();
}

class _TempScreenState extends State<TempScreen> {
  double width = 300.0;
  double height = 300.0;

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
                  onTap: ()
                  {

                  },
                  child: Ink.image(
                    image: AssetImage('assets/microphone.png'),
                    width: width,
                    height: height,
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
