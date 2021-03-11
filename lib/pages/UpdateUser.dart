import 'dart:developer';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:scanqrcode/model/ApiError.dart';
import 'package:scanqrcode/model/ApiResponse.dart';
import 'package:scanqrcode/model/User.dart';
import 'package:scanqrcode/service/UserService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AppHome.dart';
import 'Compte.dart';

class UpdateUser extends StatefulWidget {
  @override
  _UpdateUser createState() => _UpdateUser();
}

class _UpdateUser extends State<UpdateUser> {

  final _formKey = GlobalKey<FormState>();
  ApiResponse _apiResponse;
  String info = "";
  Key _scaffoldKey;
  final controllerNom = TextEditingController();
  final controllerPrenom = TextEditingController();
  final controllerAdresse = TextEditingController();
  final controllerMail = TextEditingController();
  final controllerMdp = TextEditingController();
  String nom;
  String prenom;
  String mail;
  String adresse;
  String mdp;

  @override
  Widget build(BuildContext context) {
    _setattributs();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Modification du compte'),
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
                          Text(
                            '$info',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.red,
                            ),
                          )
                      ),
                      TextFormField(
                        key: Key("_nom"),
                        decoration: InputDecoration(labelText: "Nom"),
                        controller: controllerNom,
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
                        controller: controllerPrenom,
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
                        controller: controllerAdresse,
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
                        controller: controllerMail,
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
                      ),
                      const SizedBox(height: 10.0),
                      ButtonBar(
                        children: <Widget>[
                          RaisedButton.icon(
                              onPressed: _updateUser,
                              icon: Icon(Icons.arrow_forward),
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

  void _setattributs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    controllerNom.text = prefs.get("nom");
    controllerPrenom.text = prefs.get("prenom");
    controllerMail.text = prefs.get("mail");
    controllerAdresse.text = prefs.get("adresse");
  }

  void _updateUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _formKey.currentState.save();
    if (_formKey.currentState.validate()) {
      _apiResponse = await updateUser(User(prefs.getInt("id"), nom, prenom, adresse, mail, mdp));
      if ((_apiResponse.ApiError as ApiError) == null) {
        if (_apiResponse.UpdateMdp) {
          prefs.clear();
          Navigator.pushNamedAndRemoveUntil(
              context, '/login', ModalRoute.withName('/login'));
        } else {
          User user = _apiResponse.Data;
          prefs.setString("nom", user.nom);
          prefs.setString("prenom", user.prenom);
          prefs.setString("mail", user.mail);
          prefs.setString("adresse", user.adresse);
          prefs.setString("mdp", user.mdp);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AppHome()));
        }
      }
    } else {
      setState(() {
        info = "Formulaire invalide";
      });
    }
  }
}