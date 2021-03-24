import 'package:flutter/material.dart';
import 'package:scanqrcode/model/Historique.dart';
import 'package:scanqrcode/model/Promotion.dart';

import '../main.dart';

class HistoriquePage extends StatefulWidget {
  @override
  _Historique createState() => _Historique();
}

class _Historique extends State<HistoriquePage> {
  List<Historique> histos = HistoData.histos;
  List<Promotion> promos = HistoData.promos;

  @override
  Widget build(BuildContext context) {
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
                                          text: '${promos[i].codePromo} : ${promos[i].detail} \n ${histos[i].dateScan}',
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


}