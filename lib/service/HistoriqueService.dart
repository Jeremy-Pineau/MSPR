import 'dart:convert';
import 'dart:io';
import 'package:scanqrcode/model/ApiResponse.dart';
import 'package:scanqrcode/model/ApiError.dart';
import 'package:scanqrcode/model/Historique.dart';
import 'package:http/http.dart' as http;
import '../main.dart';

String _baseUrl = ApiUrl.url + "/historique";

void traitementResponse(response, ApiResponse _apiResponse){
  switch (response.statusCode) {
    case 200:
      if (response.body == ""){
        _apiResponse.Data = null;
      } else {
        _apiResponse.Data = Historique.fromJson(json.decode(response.body));
      }
      break;
    case 401:
      _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
      break;
    default:
      _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
      break;
  }
}

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

Future<ApiResponse> getHistoriqueFromUserAndPromo(int userId, int idPromo) async {
  ApiResponse _apiResponse = new ApiResponse();
  try {
    final response = await http.get('$_baseUrl/allByPromoAndUser?idUser=$userId&idPromo=$idPromo');

    traitementResponse(response, _apiResponse);

  } on SocketException {
    _apiResponse.ApiError = ApiError(error: "Server error. Please retry");
  }
  return _apiResponse;
}

Future<ApiResponse> createHistorique(Historique historique) async {
  ApiResponse _apiResponse = new ApiResponse();
  try {
    final response = await http.post('$_baseUrl',
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(historique));

    switch (response.statusCode) {
      case 200:
        _apiResponse.Data = json.decode(response.body);
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