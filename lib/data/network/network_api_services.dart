import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/data/network/base_api_services.dart';
import '../app_exceptions.dart';

class NetworkApiServices implements BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    if (kDebugMode) {
      print(url);
    }

    dynamic responseJson;

    try {
      final response = await http.get(Uri.parse(url));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(message: "No Internet Connection");
    } on TimeoutException {
      throw FetchDataException(message: "Time Out");
    } catch (e) {
      throw UnknownException(message: e.toString());
    }

    if (kDebugMode) {
      print(responseJson);
    }

    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    if (kDebugMode) {
      print('Network API Services: $url');
      print('Network API Data: $data');
    }

    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(message: "No Internet Connection");
    } on TimeoutException {
      throw FetchDataException(message: "Time Out");
    } catch (e) {
      throw UnknownException(message: 'Network API Excetion ${e.toString()}');
    }
    if (kDebugMode) {
      print(responseJson);
    }

    return responseJson;
  }

  returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return jsonDecode(response.body);
      case 400:
        throw BadRequestException(message: response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(message: response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            message: "Server Error: ${response.body.toString()}");
    }
  }
}
