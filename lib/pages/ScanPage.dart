import 'package:flutter/cupertino.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
                        Text(((qrCodeResult == null) || (qrCodeResult == "")) ? "Cliquer sur l'icone pour scanner" : "Résultat : \n\n" + qrCodeResult,
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
    // parse le qrcode, si bon type envoyer requete api
    setState(() {
      qrCodeResult = codeSanner.rawContent;
    });
  }
}