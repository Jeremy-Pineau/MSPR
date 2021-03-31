import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'UpdateUser.dart';

class Compte extends StatefulWidget {
  @override
  _Compte createState() => _Compte();
}

class _Compte extends State<Compte> {
  String _nom = "";
  String _prenom = "";
  String _mail = "";
  String _adresse = "";

  @override
  Widget build(BuildContext context) {
    _setattributs();
    return Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.60,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints.tightFor(width: MediaQuery.of(context).size.width/3.5, height: MediaQuery.of(context).size.height/5.5),
                      child:
                        FloatingActionButton(
                          onPressed: (){},
                          backgroundColor: Color(0xffAAE0FE),
                          child: Icon(Icons.person, size: 80),
                        )
                      ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      '$_nom $_prenom',
                      style: TextStyle(
                      fontSize: 22.0,
                      ),
                      ),
                    SizedBox(
                      height: 15.0
                    ),
                    Card(
                      margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                      clipBehavior: Clip.antiAlias,
                      elevation: 5.0,
                      color: Colors.white70,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 7.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                              children: [
                                Text(
                                "Mail",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff3C3B3A),
                                ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  '$_mail',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Color(0xff3C3B3A),
                                  ),
                                )
                              ],
                              ),
                            ),
                        ]
                        )
                      )
                    ),
                    Card(
                        margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 0.0),
                        clipBehavior: Clip.antiAlias,
                        color: Colors.white70,
                        elevation: 5.0,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 7.0),
                            child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          "Adresse",
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff3C3B3A),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          '$_adresse',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: Color(0xff3C3B3A),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ]
                            )
                        )
                    ),
                ],
                )
              )
            ),
            SizedBox(
            height: 20.0,
            ),
            Container(
              width: 300.00,
              // ignore: deprecated_member_use
              child: RaisedButton(
                onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateUser()));},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0)
                ),
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [Colors.lightBlueAccent, Colors.lightBlue]
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Container(
                    constraints: BoxConstraints(minHeight: 40.0),
                    alignment: Alignment.center,
                    child: Text("Modifier",
                      style: TextStyle(fontSize: 22.0, fontWeight:FontWeight.w300, color: Colors.white),
                      ),
                    )
                  )
                )
              )
        ])
        );
  }

  void _setattributs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _nom = prefs.get("nom");
    _prenom = prefs.get("prenom");
    _mail = prefs.get("mail");
    _adresse = prefs.get("adresse");
  }
}