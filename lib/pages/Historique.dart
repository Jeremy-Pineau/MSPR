import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:scanqrcode/model/ApiResponse.dart';
import 'package:scanqrcode/model/Promotion.dart';
import 'package:scanqrcode/service/UserService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Historique extends StatefulWidget {
  @override
  _Historique createState() => _Historique();
}

class _Historique extends State<Historique> {
  List<Promotion> _historique;

  @override
  Widget build(BuildContext context) {
    getHistorique();
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            child: RichText(
              text: TextSpan(
                text: "Historique",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          for(Promotion p in _historique) Container(
            child:
              RichText(
                text: TextSpan(
                  text: "Code : ${p.codePromo} | Détail : ${p.detail}",
                  style: TextStyle(fontSize: 15.0),
                ),
                textAlign: TextAlign.center,
              )),
        ]
      ));
    }

    void getHistorique() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String mail = prefs.get("mail");
      ApiResponse res = await getHistoriqueFromUser(mail);
      if (res.Data != null) {
        setState(() {
          _historique = res.Data;
        });
      }
    }
}