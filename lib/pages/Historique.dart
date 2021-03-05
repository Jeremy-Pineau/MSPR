import 'package:flutter/material.dart';

class Historique extends StatefulWidget {
  @override
  _Historique createState() => _Historique();
}

class _Historique extends State<Historique> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: RichText(
            text: TextSpan(
              text: "Historique",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
            ),
            textAlign: TextAlign.center,
          ),
        ));
    }
}