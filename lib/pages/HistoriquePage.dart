import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scanqrcode/model/ApiResponse.dart';
import 'package:scanqrcode/model/Historique.dart';
import 'package:scanqrcode/model/Promotion.dart';
import 'package:scanqrcode/service/HistoriqueService.dart';
import 'package:scanqrcode/service/PromotionService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoriquePage extends StatefulWidget {
  @override
  _Historique createState() => _Historique();
}

class _Historique extends State<HistoriquePage> {
  var _historique = List.empty();

  @override
  Widget build(BuildContext context) {
    getHistorique();
    return Scaffold(
          body:
              ListView.builder(
                itemCount: _historique.length,
                itemBuilder: (context, i) {
                    var codePromo = "";
                    getPromo(_historique[i].idPromo).then((value) {
                        codePromo = value.codePromo;
                    });
                    return Card(
                      child:
                        ListTile(
                          title: RichText(
                            text: TextSpan(
                              text: "${_historique[i].id} $codePromo ${new DateFormat('yyyy-MM-dd hh:mm').format(_historique[i].dateScan)}",
                              style: TextStyle(fontSize: 15.0),
                            ),
                            textAlign: TextAlign.center,
                          )
                        )
                    );
                }
              )
          );
    }

    Future<Promotion> getPromo(int idPromo) async {
      ApiResponse res = await getPromotion(idPromo);
      return res.Data;
    }

    void getHistorique() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int id = prefs.get("id");
      ApiResponse res = await getHistoriqueFromUser(id);
      if (res.Data != null) {
        setState(() {
          _historique = res.Data;
        });
      }
    }
}