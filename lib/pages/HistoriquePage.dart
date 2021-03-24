import 'package:flutter/material.dart';
import 'package:scanqrcode/model/Historique.dart';
import 'package:scanqrcode/model/Promotion.dart';
import 'package:scanqrcode/model/dto/HistoData.dart';


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
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900, color: Colors.black),
                  ),
                  textAlign: TextAlign.center,
                )
            ),
            if(histos.isEmpty)
              Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.30),
                  child:
                  RichText(
                    text: TextSpan(
                      text: "Aucun élément à afficher : ",
                      style: TextStyle(fontSize: 22.0, color: Colors.black),
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
                                  elevation: 5.0,
                                  color: Colors.black26,
                                  child:
                                  ListTile(
                                      title: RichText(
                                        text: TextSpan(
                                          text: '${promos[i].codePromo} : ${promos[i].detail} \n ${histos[i].dateScan}',
                                          style: TextStyle(fontSize: 15.0, color: Colors.white),
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