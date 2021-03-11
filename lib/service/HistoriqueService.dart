import 'dart:convert';
import 'dart:io';
import 'package:scanqrcode/model/ApiResponse.dart';
import 'package:scanqrcode/model/ApiError.dart';
import 'package:scanqrcode/model/Historique.dart';
import 'package:http/http.dart' as http;

String _baseUrl = "http://192.168.1.19:9000/historique";

Future<ApiResponse> getHistoriqueFromUser(int userId) async {
  ApiResponse _apiResponse = new ApiResponse();
  try {
    final response = await http.get('$_baseUrl/allByUserId/$userId');

    switch (response.statusCode) {
      case 200:
        Iterable l = json.decode(response.body);
        List<Historique> promos = List<Historique>.from(l.map((model)=> Historique.fromJson(model)));
        _apiResponse.Data = promos;
        break;
      case 401:
        _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
        break;
      default:
        _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
        break;
    }

  } on SocketException {
    _apiResponse.ApiError = ApiError(error: "Server error. Please retry");
  }
  return _apiResponse;
}