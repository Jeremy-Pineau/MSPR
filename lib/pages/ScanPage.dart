import 'package:flutter/cupertino.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scanqrcode/model/dto/ApiResponse.dart';
import 'package:scanqrcode/model/Historique.dart';
import 'package:scanqrcode/model/dto/HistoData.dart';
import 'package:scanqrcode/service/HistoriqueService.dart';
import 'package:scanqrcode/service/PromotionService.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String qrCodeResult;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Scan de QR Code"),
        ),
        body:
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Center(
                child: ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: MediaQuery.of(context).size.width/3, height: MediaQuery.of(context).size.height/5),
                      child:
                      FloatingActionButton(
                        backgroundColor: Colors.black26,
                        elevation: 20,
                        onPressed: () {
                          _scan();
                        },
                        child: Icon(Icons.qr_code_scanner, size: 55.0),
                      ),
                    )),
                Container(
                    child:
                    new GestureDetector(
                      child: Center(
                        child:
                        Text(((qrCodeResult == null) || (qrCodeResult == "")) ? "Cliquez sur l'icone pour scanner" : qrCodeResult,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
                        ),
                      ),
                    )
                )
              ],
          )
    );
  }

  Future<void> _scan() async {
    ScanResult codeSanner = await BarcodeScanner.scan(
      options: ScanOptions(
        useCamera: 0,
      ),
    );

    // parse le qrcode
    var code = codeSanner.rawContent.split(";");
    if (code[0] == "qrScanAppMspr"){
      // QrCode valide
      ApiResponse response = await getPromotion(int.parse(code[1]));
      if(response.Data != null){
        // Promotion existe
        SharedPreferences prefs = await SharedPreferences.getInstance();
        int id = prefs.get("id");
        ApiResponse res = await getHistoriqueFromUserAndPromo(id, int.parse(code[1]));
        if (res.Data == null){
          // Promotion pas dans l'historique de l'user
          Historique h = Historique(null, int.parse(code[1]), id, DateFormat("yyyy-MM-ddTHH:mm:ss").format(DateTime.now()).toString());
          var responseCreate = await createHistorique(h);
          if (responseCreate.Data == 1){
            // Insertion réussie
            HistoData.histos.add(h);
            getPromotion(h.idPromo).then((value) => HistoData.promos.add(value.Data));
            setState(() {
              qrCodeResult = "Scan succes !";
            });
          } else {
            setState(() {
              qrCodeResult = "Erreur serveur";
            });
          }
        } else {
          setState(() {
            qrCodeResult = "Promotion déjà scanée";
          });
        }
      } else {
        setState(() {
          qrCodeResult = "La promotion liée à ce code n'existe pas/plus";
        });
      }
    } else{
      setState(() {
        qrCodeResult = "Code non conforme à l'app";
      });
    }
  }
}