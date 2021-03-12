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
            Padding(padding: EdgeInsets.only(top: 15.0),
                child:
                RichText(
                  text: TextSpan(
                    text: "Compte : ",
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
                  ),
                  textAlign: TextAlign.center,
                )
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.60,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYmGZO_o8W8nOdixsSxkmRPvgswXslVRBqpQ&usqp=CAU"),
                      radius: 50.0
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      '$_nom $_prenom',
                      style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.white,
                      ),
                      ),
                    SizedBox(
                      height: 10.0
                    ),
                    Card(
                      margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                      clipBehavior: Clip.antiAlias,
                      color: Colors.white,
                      elevation: 5.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 15.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                              children: [
                                Text(
                                "Mail",
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  '$_mail',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.pinkAccent,
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
                        margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                        clipBehavior: Clip.antiAlias,
                        color: Colors.white,
                        elevation: 5.0,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 15.0),
                            child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          "Adresse",
                                          style: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          '$_adresse',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.pinkAccent,
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
                    colors: [Colors.grey, Colors.white]
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                    alignment: Alignment.center,
                    child: Text("Modifier",
                      style: TextStyle(color: Colors.pinkAccent, fontSize: 26.0, fontWeight:FontWeight.w300),
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