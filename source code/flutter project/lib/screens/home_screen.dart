import 'package:flutter/material.dart';
import 'package:eye_guide/screens/features_screen.dart';

class HomeScreen extends StatefulWidget
{

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF090F32),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 50.0),
            child: Image.asset(
              'assets/logo.png',
              width: 300.0,
              height: 300.0,
              color: Colors.white,
            ),
          ),
          FlatButton(
            onPressed: ()
            {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FeaturesScreen())
              );
            },
            child: Text(
              'Eye Guide',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
