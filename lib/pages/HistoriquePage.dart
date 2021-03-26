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
                      text: "Aucun élément à afficher ",
                      style: TextStyle(fontSize: 22.0, color: Colors.black),
                    ),
                    textAlign: TextAlign.center,
                  )
              ),
            if(histos.isNotEmpty)
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
                                return Padding(padding: EdgeInsets.only(bottom: 10.0),
                                  child:
                                    Card(
                                      elevation: 5.0,
                                      color: Color(0xffAAE0FE),
                                      child:
                                      ListTile(
                                        onTap: () {
                                          Widget cancelButton = TextButton(
                                            child: Text("Ok"),
                                            onPressed:  () {Navigator.of(context).pop();},
                                          );
                                          // set up the AlertDialog
                                          AlertDialog alert = AlertDialog(
                                            title: Text("Promotion :"),
                                            content: Text("Code : \n ${promos[i].codePromo} \n\n"
                                                          "Date de scan : \n ${histos[i].dateScan} \n\n"
                                                          "Détail : \n ${promos[i].detail}"),
                                            actions: [cancelButton],
                                          );
                                          // show the dialog
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return alert;
                                            },
                                          );
                                        },
                                          title: RichText(
                                            text: TextSpan(
                                              text: '${promos[i].codePromo} : ${promos[i].detail} \n ${histos[i].dateScan}',
                                              style: TextStyle(fontSize: 15.0, color: Color(0xff3C3B3A),),
                                            ),
                                            textAlign: TextAlign.center,
                                          )
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