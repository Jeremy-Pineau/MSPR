import 'package:flutter/material.dart';
import 'package:scanqrcode/model/ApiResponse.dart';
import 'package:scanqrcode/model/ApiError.dart';
import 'package:scanqrcode/model/User.dart';
import 'package:scanqrcode/service/UserService.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  String _userId = "";

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userId = (prefs.getString('userId') ?? "");
    if (_userId == "") {
      Navigator.pushNamedAndRemoveUntil(
          context, '/login', ModalRoute.withName('/login'));
    } else {
      ApiResponse _apiResponse = await getUser(_userId);
      if ((_apiResponse.ApiError as ApiError) == null) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/home', ModalRoute.withName('/home'),
            arguments: (_apiResponse.Data as User));
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, '/login', ModalRoute.withName('/login'));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}