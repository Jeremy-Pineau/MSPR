import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/UserService.dart' as us;

class Settings extends StatefulWidget {
  @override
  _Settings createState() => _Settings();
}

class _Settings extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
                  child: Center(
                    child:
                    Text("Settings :",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              RaisedButton.icon(
                  onPressed: _handleLogout,
                  icon: Icon(Icons.logout),
                  label: Text('Logout')
              ),
            RaisedButton.icon(
                onPressed: _deleteUser,
                icon: Icon(Icons.delete),
                label: Text('Supprimer le compte')
            ),
            ],
        )
    );
  }

  void _handleLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Widget cancelButton = FlatButton(
      child: Text("Annuler"),
      onPressed:  () {Navigator.of(context).pop();},
    );
    Widget continueButton = FlatButton(
      child: Text("Continuer"),
      onPressed:  () {
        prefs.clear();
        Navigator.pushNamedAndRemoveUntil(context, '/login', ModalRoute.withName('/login'));
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Déconnection"),
      content: Text("Voulez-vous vraiment vous déconnecter ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _deleteUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Annuler"),
      onPressed:  () {Navigator.of(context).pop();},
    );
    Widget continueButton = FlatButton(
      child: Text("Continuer"),
      onPressed:  () {
        us.deleteUser(prefs.getString("mail"));
        _handleLogout();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alerte !"),
      content: Text("Voulez-vous vraiment supprimer votre compte ? (Cela est définitif)"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}