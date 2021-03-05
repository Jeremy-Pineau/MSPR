import 'package:flutter/material.dart';

class Accueil extends StatefulWidget {
  @override
  _Accueil createState() => _Accueil();
}

class _Accueil extends State<Accueil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: RichText(
            text: TextSpan(
              text: "Accueil",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
            ),
            textAlign: TextAlign.center,
          ),
        ));
    }
}