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
                IconButton(
                  icon: Icon(Icons.qr_code_scanner),
                  tooltip: 'Scanner',
                  onPressed: () {
                    _scan();
                  },
                  iconSize: 60,
                ),
                Container(
                    child:
                    new GestureDetector(
                      onTap: () {
                        _launch(qrCodeResult);
                      },
                      child: Center(
                        child:
                        Text(((qrCodeResult == null) || (qrCodeResult == "")) ? "Please Scan to show some result" : "Résultat : \n\n" + qrCodeResult,
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

  _launch(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch';
    }
  }

  Future<void> _scan() async {
    ScanResult codeSanner = await BarcodeScanner.scan(
      options: ScanOptions(
        useCamera: 0,
      ),
    );
    setState(() {
      qrCodeResult = codeSanner.rawContent;
    });
  }
}