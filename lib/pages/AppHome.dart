import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'Accueil.dart';
import 'Compte.dart';
import 'HistoriquePage.dart';
import 'ScanPage.dart';
import 'Settings.dart';

class AppHome extends StatefulWidget {
  AppHome();

  @override
  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: 0, length: 4);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        child:
          Scaffold(
            appBar: AppBar(
              title: Text("QRScanner"),
              elevation: 0.7,
              actions: <Widget>[
                FloatingActionButton(
                  backgroundColor: Colors.black12,
                  child: Icon(Icons.qr_code_scanner, size: 30),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ScanPage()));
                  },
                )
              ],
            ),
            body: TabBarView(
              controller: _tabController,
              children: <Widget>[
                Accueil(),
                HistoriquePage(),
                Compte(),
                Settings(),
              ],
            ),
            bottomNavigationBar:
              ConvexAppBar(
                backgroundColor: Color(0xff3C3B3A),
                color: Colors.white,
                controller: _tabController,
                items: [
                  TabItem(icon: Icons.home_filled, title: 'Accueil'),
                  TabItem(icon: Icons.history, title: 'Historique'),
                  TabItem(icon: Icons.person, title: 'Profil'),
                  TabItem(icon: Icons.settings, title: 'Paramètres'),
                ],
                initialActiveIndex: 0,//optional, default as 0
              )
          )
        ,length: 4
    );
  }
}