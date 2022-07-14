import 'package:flutter/material.dart';

class FeatureButton extends StatelessWidget {

  String image;
  String feature;
  VoidCallback function;

  FeatureButton({required this.image, required this.feature, required this.function});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.only(left: 26.0,top: 3.0,right: 26.0,bottom: 3.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFE0167),
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        child: Column(
          children: [
            Image.asset(
              image,
              color: Colors.white,
              width: 123.0,
              height: 123.0,
            ),
            SizedBox(
              height: 15.0,
            ),
            FlatButton(
              onPressed: function,
              child: Text(
                feature,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}