import 'package:flutter/material.dart';

class Accueil extends StatefulWidget {
  @override
  _Accueil createState() => _Accueil();
}

class _Accueil extends State<Accueil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            children: [
              Padding(padding: EdgeInsets.all(15.0),
                child:
                  RichText(
                    text: TextSpan(
                      text: "Accueil : ",
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900, color: Colors.black),
                    ),
                    textAlign: TextAlign.center,
                  )
              ),
              Container(

              )
            ])
    );
  }
}