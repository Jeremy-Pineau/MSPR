import 'package:flutter/material.dart';
import 'package:scanqrcode/model/dto/ApiResponse.dart';
import 'package:scanqrcode/model/Historique.dart';
import 'package:scanqrcode/model/User.dart';
import 'package:scanqrcode/model/dto/HistoData.dart';
import 'package:scanqrcode/service/HistoriqueService.dart';
import 'package:scanqrcode/service/PromotionService.dart';
import 'package:scanqrcode/service/UserService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CreateUser.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {

  String _username;
  String _password;
  final _formKey = GlobalKey<FormState>();
  Key _scaffoldKey;
  ApiResponse _apiResponse;
  String _info = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Connexion'),
        ),
        body: Column(
            children: <Widget>[
              SizedBox(
                  height: 10.0
              ),
              SafeArea(
                top: false,
                bottom: false,
                child: Form(
                  autovalidate: true,
                  key: _formKey,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextFormField(
                                key: Key("_username"),
                                decoration: InputDecoration(labelText: "Adresse mail"),
                                keyboardType: TextInputType.emailAddress,
                                onSaved: (String value) {
                                  _username = value;
                                },
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "Mot de passe"),
                                obscureText: true,
                                keyboardType: TextInputType.visiblePassword,
                                onSaved: (String value) {
                                  _password = value;
                                },
                              ),
                              const SizedBox(height: 10.0),
                              Container(
                                child:
                                Padding(padding: EdgeInsets.only(top: 10.0),
                                    child:
                                    RichText(
                                      text: TextSpan(
                                        text: '$_info',
                                        style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w900, color: Colors.red),
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                ),
                              ),
                              ButtonBar(
                                children: <Widget>[
                                  ElevatedButton.icon(
                                      onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => CreateUser()));},
                                      icon: Icon(Icons.add),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.white38, // background
                                        onPrimary: Colors.black, // foreground
                                      ),
                                      label: Text('Inscription')),
                                  ElevatedButton.icon(
                                      onPressed: _handleSubmitted,
                                      icon: Icon(Icons.arrow_forward),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.white38, // background
                                        onPrimary: Colors.black, // foreground
                                      ),
                                      label: Text('Connection')),
                                ],
                              ),
                            ],
                          ),
                        ]),
                  ),
                ),
              ),
            ]
        )
    );
  }

  void _handleSubmitted() async {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      _apiResponse = await authenticateUser(_username, _password);
      if (_apiResponse.ApiError == null) {
        _saveAndRedirectToHome();
      } else {
        setState(() {
          _info = "Identifiant ou mot de passe incorrect";
        });
      }
    }
  }

  void _saveAndRedirectToHome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("id", (_apiResponse.Data as User).id);
    await prefs.setString("nom", (_apiResponse.Data as User).nom);
    await prefs.setString("prenom", (_apiResponse.Data as User).prenom);
    await prefs.setString("mail", (_apiResponse.Data as User).mail);
    await prefs.setString("adresse", (_apiResponse.Data as User).adresse);
    await prefs.setString("mdp", (_apiResponse.Data as User).mdp);

    HistoData.histos.clear();
    HistoData.promos.clear();
    ApiResponse resH = await getHistoriqueFromUser((_apiResponse.Data as User).id);
    if (resH.Data != null) {
      for(Historique h in resH.Data){
        HistoData.histos.add(h);
        getPromotion(h.idPromo).then((value) => HistoData.promos.add(value.Data));
      }
    }

    Navigator.pushNamedAndRemoveUntil(
        context, '/home', ModalRoute.withName('/home'),
        arguments: (_apiResponse.Data as User));
  }
}