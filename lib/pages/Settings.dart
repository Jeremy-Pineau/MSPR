import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:settings_ui/settings_ui.dart';
import '../service/UserService.dart' as us;
import 'CGUs.dart';
import 'Licence.dart';
import 'UpdateUser.dart';

class Settings extends StatefulWidget {
  @override
  _Settings createState() => _Settings();
}

class _Settings extends State<Settings> {
  bool digit = false;
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        SettingsList(
          backgroundColor: Colors.white,
          sections: [
            SettingsSection(
              title: '\nGénéral',
              tiles: [
                SettingsTile(
                  title: 'Langue',
                  subtitle: 'Français',
                  leading: Icon(Icons.language),
                )
              ],
            ),
            SettingsSection(
              title: 'Compte',
              tiles: [
                SettingsTile(title: 'Modifier le compte', leading: Icon(Icons.create_rounded), onPressed: (context){Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateUser()));},),
                SettingsTile(title: 'Déconnection', leading: Icon(Icons.exit_to_app), onPressed: (context) => _handleLogout()),
                SettingsTile(title: 'Supprimer le compte', leading: Icon(Icons.delete), onPressed: (context) => _deleteUser()),
              ],
            ),
            SettingsSection(
              title: 'Sécurité',
              tiles: [
                SettingsTile.switchTile(
                    title: 'Reconnaissance digitale',
                    subtitle: 'Allow application to access stored fingerprint IDs.',
                    leading: Icon(Icons.fingerprint),
                    switchValue: digit,
                    onToggle: (bool value) {
                      setState(() {
                        digit = value;
                      });
                    },
                ),
                SettingsTile.switchTile(
                  title: 'Activer les notifications',
                  leading: Icon(Icons.notifications_active),
                  switchValue: notificationsEnabled,
                  onToggle: (bool value) {
                    setState(() {
                      notificationsEnabled = value;
                    });
                  },
                ),
              ],
            ),
            SettingsSection(
              title: 'Autres',
              tiles: [
                SettingsTile(
                    title: 'Conditions générales',
                    leading: Icon(Icons.description), onPressed: (context) {Navigator.push(context, MaterialPageRoute(builder: (context) => CGUs()));},),
                SettingsTile(
                    title: 'Licence',
                    leading: Icon(Icons.collections_bookmark), onPressed: (context) {Navigator.push(context, MaterialPageRoute(builder: (context) => Licence()));},),
              ],
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
        us.deleteUser(prefs.getInt("id"));
        prefs.clear();
        Navigator.pushNamedAndRemoveUntil(context, '/login', ModalRoute.withName('/login'));
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