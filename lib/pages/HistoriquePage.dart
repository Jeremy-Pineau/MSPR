import 'dart:developer';
import 'dart:io';
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
  List<Historique> histos = [];
  List<Promotion> promos = [];

  @override
  Widget build(BuildContext context) {
    setAll();
    return Scaffold(
          body:
              Column(
                children: [
                  Padding(padding: EdgeInsets.all(15.0),
                      child:
                      RichText(
                        text: TextSpan(
                          text: "Historique : ",
                          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
                        ),
                        textAlign: TextAlign.center,
                      )
                  ),
                  Container(
                      child: Expanded(
                          child:
                          Scrollbar(
                            child:
                            ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: histos.length,
                                itemBuilder: (context, i) {
                                  return Card(
                                      child:
                                      ListTile(
                                          title: RichText(
                                            text: TextSpan(
                                              text: '${promos[i].codePromo} : ${promos[i].detail} \n ${new DateFormat('yyyy-MM-dd hh:mm').format(histos[i].dateScan)}',
                                              style: TextStyle(fontSize: 15.0),
                                            ),
                                            textAlign: TextAlign.center,
                                          )
                                      )
                                  );
                                }
                            )
                          )
                      )
                  )
                ],
              )
    );
  }

  void setAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.get("id");
    histos.clear();
    promos.clear();

    ApiResponse resH = await getHistoriqueFromUser(id);
    if (resH.Data != null) {
      for(Historique h in resH.Data){
        histos.add(h);
        getPromotion(h.idPromo).then((value) => promos.add(value.Data));
      }
    }
  }
}