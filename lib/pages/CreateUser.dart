import 'package:flutter/material.dart';
import 'package:scanqrcode/model/dto/ApiError.dart';
import 'package:scanqrcode/model/dto/ApiResponse.dart';
import 'package:scanqrcode/model/User.dart';
import 'package:scanqrcode/service/UserService.dart';
import 'package:email_validator/email_validator.dart';

import 'Login.dart';

class CreateUser extends StatefulWidget {
  @override
  _CreateUser createState() => _CreateUser();
}

class _CreateUser extends State<CreateUser> {

  final _formKey = GlobalKey<FormState>();
  ApiResponse _apiResponse;
  Key _scaffoldKey;
  String nom;
  String prenom;
  String mail;
  String adresse;
  String mdp;
  String info = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Création de compte'),
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Form(
          // ignore: deprecated_member_use
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
                      Center(
                        child:
                        Padding(padding: EdgeInsets.only(top: 10.0),
                            child:
                            RichText(
                              text: TextSpan(
                                text: '$info',
                                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900, color: Colors.red),
                              ),
                              textAlign: TextAlign.center,
                            )
                        ),
                      ),
                      TextFormField(
                        key: Key("_nom"),
                        decoration: InputDecoration(labelText: "Nom"),
                        keyboardType: TextInputType.text,
                        onSaved: (String value) {
                          nom = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Nom manquant';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        key: Key("_prenom"),
                        decoration: InputDecoration(labelText: "Prénom"),
                        onSaved: (String value) {
                          prenom = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Prénom manquant';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        key: Key("_adresse"),
                        decoration: InputDecoration(labelText: "Adresse"),
                        keyboardType: TextInputType.text,
                        onSaved: (String value) {
                          adresse = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Adresse manquante';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        key: Key("_mail"),
                        decoration: InputDecoration(labelText: "Mail"),
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (String value) {
                          mail = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Mail manquant';
                          } else {
                            if (!EmailValidator.validate(value)) {
                              return "Mail invalide";
                            }
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        key: Key("_mdp"),
                        decoration: InputDecoration(labelText: "Mot de passe"),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        onSaved: (String value) {
                          mdp = value;
                        },
                        validator: (value) {
                          if (value.length <= 5) {
                            return '6 caractères minimum';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10.0),
                      ButtonBar(
                        children: <Widget>[
                          ElevatedButton.icon(
                              onPressed: _createUser,
                              icon: Icon(Icons.check),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white38, // background
                                onPrimary: Colors.black, // foreground
                              ),
                              label: Text('Valider')),
                        ],
                      ),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  void _createUser() async {
    _formKey.currentState.save();
    if (_formKey.currentState.validate()) {
      _apiResponse = await createUser(User(null, nom, prenom, adresse, mail, mdp));
      if ((_apiResponse.ApiError as ApiError) != null) {
        setState(() {
          info = "Mail déjà existant";
        });
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      }
    } else {
      setState(() {
        info = "Formulaire invalide";
      });
    }
  }
}