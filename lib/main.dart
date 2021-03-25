import 'package:flutter/material.dart';
import 'package:scanqrcode/pages/Login.dart';
import 'pages/AppHome.dart';
import 'Landing.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QRScanner',
      routes: {
        '/': (context) => Landing(),
        '/login': (context) => Login(),
        '/home': (context) => AppHome(),
      },
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Color(0xffEDEDED),//Color(0xff3C3B3A),
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.black,
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }
}