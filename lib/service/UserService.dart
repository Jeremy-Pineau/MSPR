import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:scanqrcode/model/ApiResponse.dart';
import 'package:scanqrcode/model/ApiError.dart';
import 'package:scanqrcode/model/User.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

String _baseUrl = "http://192.168.43.187:9000/";

String hashMdp(String mdp) {
  String salt = 'UVocjgjgXg8P7zIsC93kKlRU8sPbTBhsAMFLnLUPDRYFIWAk';
  String saltedPassword = salt + mdp;
  List<int> bytes = utf8.encode(saltedPassword);
  return sha256.convert(bytes).toString();
}

void traitementResponse(response, ApiResponse _apiResponse){
  switch (response.statusCode) {
    case 200:
      _apiResponse.Data = User.fromJson(json.decode(response.body));
      break;
    case 401:
      _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
      break;
    default:
      _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
      break;
  }
}

Future<ApiResponse> authenticateUser(String username, String password) async {
  ApiResponse _apiResponse = new ApiResponse();

  try {
    final response = await http.post('${_baseUrl}user/login',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'mail': username,
          'mdp': hashMdp(password),
        }));

    if (response.body == "null"){
      _apiResponse.ApiError = "body vide";
    } else {
      traitementResponse(response, _apiResponse);
    }

  } on SocketException {
    _apiResponse.ApiError = ApiError(error: "Server error. Please retry");
  }
  return _apiResponse;
}

Future<ApiResponse> createUser(User user) async {
  ApiResponse _apiResponse = new ApiResponse();

  try {
    user.mdp = hashMdp(user.mdp);
    final response = await http.post('${_baseUrl}user',
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(user));

    traitementResponse(response, _apiResponse);

  } on SocketException {
    _apiResponse.ApiError = ApiError(error: "Server error. Please retry");
  }
  return _apiResponse;
}

Future<ApiResponse> getUser(String userId) async {
  ApiResponse _apiResponse = new ApiResponse();
  try {
    final response = await http.get('${_baseUrl}user/$userId');

    traitementResponse(response, _apiResponse);

  } on SocketException {
    _apiResponse.ApiError = ApiError(error: "Server error. Please retry");
  }
  return _apiResponse;
}

Future<ApiResponse> deleteUser(String userId) async {
  ApiResponse _apiResponse = new ApiResponse();
  try {
    final response = await http.delete('${_baseUrl}user/$userId');

    traitementResponse(response, _apiResponse);

  } on SocketException {
    _apiResponse.ApiError = ApiError(error: "Server error. Please retry");
  }
  return _apiResponse;
}

Future<ApiResponse> updateUser(User user) async {
  ApiResponse _apiResponse = new ApiResponse();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool modifMdp = false;
  String mail = prefs.get("mail");
  if (user.mdp.isEmpty){
    user.mdp = prefs.get("mdp");
  } else {
    user.mdp = hashMdp(user.mdp);
    modifMdp = true;
  }
  try {
    final response = await http.put('${_baseUrl}user/$mail',
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(user)
    );

    traitementResponse(response, _apiResponse);

  } on SocketException {
    _apiResponse.ApiError = ApiError(error: "Server error. Please retry");
  }
  if (modifMdp){
    _apiResponse.UpdateMdp = true;
  } else {
    _apiResponse.UpdateMdp = false;
  }
  return _apiResponse;
}