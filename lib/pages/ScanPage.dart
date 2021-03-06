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
  var _info = Container(
      child:
      Center(
        child:
        Text("Cliquez sur l'icone pour scanner",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
        ),
      )
  );

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
                _info,
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
    setState(() {
      _info =
          Container(
            child: CircularProgressIndicator(
              strokeWidth: 5.0,
            )
          );
    });
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
          ApiResponse responseCreate = await createHistorique(h);
          if (responseCreate.Data != null){
            // Insertion r??ussie
            HistoData.histos.add(h);
            getPromotion(h.idPromo).then((value) => HistoData.promos.add(value.Data));
            setState(() {
              _info = Container(
                  child:
                  Center(
                    child:
                    Text("Scan succes !",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
                    ),
                  )
              );
            });
          } else {
            setState(() {
              _info = Container(
                  child:
                  Center(
                    child:
                    Text("Erreur serveur",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
                    ),
                  )
              );
            });
          }
        } else {
          setState(() {
            _info = Container(
                child:
                Center(
                  child:
                  Text("Promotion d??j?? scan??e",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
                  ),
                )
            );
          });
        }
      } else {
        setState(() {
          _info = Container(
              child:
              Center(
                child:
                Text("La promotion li??e ?? ce code n'existe pas/plus",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
                ),
              )
          );
        });
      }
    } else{
      setState(() {
        _info = Container(
            child:
            Center(
              child:
              Text("Code non conforme ?? l'app",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
              ),
            )
        );
      });
    }
  }
}