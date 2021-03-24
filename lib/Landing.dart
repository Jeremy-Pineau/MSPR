import 'package:flutter/material.dart';
import 'package:scanqrcode/model/dto/ApiResponse.dart';
import 'package:scanqrcode/model/dto/ApiError.dart';
import 'package:scanqrcode/model/User.dart';
import 'package:scanqrcode/service/UserService.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int _userId = (prefs.getInt('id') ?? 0);
    if (_userId == 0) {
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