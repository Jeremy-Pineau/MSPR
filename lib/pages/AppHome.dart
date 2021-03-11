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
    return Scaffold(
      appBar: AppBar(
        title: Text("TitleApp"),
        elevation: 0.7,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
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
        bottomNavigationBar: TabBar(
          controller: _tabController,
          indicator: ShapeDecoration (
              shape: UnderlineInputBorder (
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 5,
                    style: BorderStyle.solid
                  )
                ),
              gradient: LinearGradient(colors: [Colors.transparent, Colors.white]),
            ),
          tabs: <Widget>[
            Tab(icon: Icon(Icons.home_filled)),
            Tab(icon: Icon(Icons.history)),
            Tab(
            icon: Icon(Icons.person),
            ),
            Tab(
            icon: Icon(Icons.settings),
            ),
          ],
        ),
    );
  }
}