import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:scanqrcode/model/ApiError.dart';
import 'package:scanqrcode/model/ApiResponse.dart';
import 'package:scanqrcode/model/User.dart';
import 'package:scanqrcode/service/UserService.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          title: Text('Login'),
        ),
        body: Column(
            children: <Widget>[
              Container(
                child: Center(
                  child:
                  Text(
                    '$_info',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
          SafeArea(
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
                          TextFormField(
                            key: Key("_username"),
                            decoration: InputDecoration(labelText: "Username"),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (String value) {
                              _username = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Username is required';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: "Password"),
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            onSaved: (String value) {
                              _password = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Password is required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10.0),
                          ButtonBar(
                            children: <Widget>[
                              RaisedButton.icon(
                                  onPressed: _handleSubmitted,
                                  icon: Icon(Icons.arrow_forward),
                                  label: Text('Sign in')),
                            ],
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
          ),
      ])
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
        _info = "aaaaaaaaa";
      }
    }
  }

  void _saveAndRedirectToHome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("nom", (_apiResponse.Data as User).nom);
    await prefs.setString("prenom", (_apiResponse.Data as User).prenom);
    await prefs.setString("mail", (_apiResponse.Data as User).mail);
    await prefs.setString("adresse", (_apiResponse.Data as User).adresse);
    await prefs.setString("mdp", (_apiResponse.Data as User).mdp);
    Navigator.pushNamedAndRemoveUntil(
        context, '/home', ModalRoute.withName('/home'),
        arguments: (_apiResponse.Data as User));
  }
}