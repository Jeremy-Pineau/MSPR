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
      title: 'QR Code',
      routes: {
        '/': (context) => Landing(),
        '/login': (context) => Login(),
        '/home': (context) => AppHome(),
      },
      theme: ThemeData(
        primaryColor: Colors.white,
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
    );
  }
}