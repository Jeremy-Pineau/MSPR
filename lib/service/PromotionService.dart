import 'dart:convert';
import 'dart:io';
import 'package:scanqrcode/model/ApiResponse.dart';
import 'package:scanqrcode/model/ApiError.dart';
import 'package:scanqrcode/model/Promotion.dart';
import 'package:scanqrcode/model/User.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

String _baseUrl = "http://192.168.1.17:9000/promotion";

void traitementResponse(response, ApiResponse _apiResponse){
  switch (response.statusCode) {
    case 200:
      _apiResponse.Data = Promotion.fromJson(json.decode(response.body));
      break;
    case 401:
      _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
      break;
    default:
      _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
      break;
  }
}

Future<ApiResponse> createPromotion(Promotion promotion) async {
  ApiResponse _apiResponse = new ApiResponse();

  try {
    final response = await http.post('$_baseUrl',
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(promotion));

    traitementResponse(response, _apiResponse);

  } on SocketException {
    _apiResponse.ApiError = ApiError(error: "Server error. Please retry");
  }
  return _apiResponse;
}

Future<ApiResponse> getPromotion(int id) async {
  ApiResponse _apiResponse = new ApiResponse();
  try {
    final response = await http.get('$_baseUrl/$id');

    traitementResponse(response, _apiResponse);

  } on SocketException {
    _apiResponse.ApiError = ApiError(error: "Server error. Please retry");
  }
  return _apiResponse;
}

Future<ApiResponse> getPromotions() async {
  ApiResponse _apiResponse = new ApiResponse();
  try {
    final response = await http.get('$_baseUrl/all');

    traitementResponse(response, _apiResponse);

  } on SocketException {
    _apiResponse.ApiError = ApiError(error: "Server error. Please retry");
  }
  return _apiResponse;
}

Future<ApiResponse> deletePromotion(int id) async {
  ApiResponse _apiResponse = new ApiResponse();
  try {
    final response = await http.delete('$_baseUrl/$id');

    traitementResponse(response, _apiResponse);

  } on SocketException {
    _apiResponse.ApiError = ApiError(error: "Server error. Please retry");
  }
  return _apiResponse;
}

Future<ApiResponse> updatePromotion(Promotion promotion) async {
  ApiResponse _apiResponse = new ApiResponse();
  try {
    final response = await http.put('$_baseUrl/${promotion.id}',
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(promotion)
    );

    traitementResponse(response, _apiResponse);

  } on SocketException {
    _apiResponse.ApiError = ApiError(error: "Server error. Please retry");
  }
  return _apiResponse;
}