import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_task_m/data/services/custom_exception.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  static const BASE_URL = 'https://jsonplaceholder.typicode.com/';

  final http.Client httpClient = http.Client();

  ///Authentication
  static const ALBUMS = 'albums'; // Replace this with your login url end point
  static const PHOTOS = 'photos'; // Repl

  ApiClient();

  ///GET api call
  Future apiCallGet(String url, {String query = ""}) async {
    var responseJson;
    var getUrl;
    final response;

    if (query.isNotEmpty) {
      getUrl = '$BASE_URL$url/$query';
    } else {
      getUrl = '$BASE_URL$url';
    }

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    try {
       response = await httpClient
          .get(
            Uri.parse(getUrl),
            // headers: headers,
          )
          .timeout(const Duration(seconds: 60));
      // responseJson = await _response(response);
      print("json.decode(response.body)-");
      print(json.decode(response.body));

      responseJson = response.body;
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future<dynamic> _response(http.Response response, {bool showSuccessDialog = false}) async {
    print("Api response : ${response.body}");

    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        final status = responseJson["status"] == 1;
        final message = responseJson["message"];

        return responseJson;
      case 201:
        var responseJson = json.decode(response.body);
        final status = responseJson["status"] == 1;
        final message = responseJson["message"];

        return responseJson;

      case 400:
        var responseJson = json.decode(response.body);
        final message = responseJson["message"];
        throw BadRequestException(message.toString());
      case 401:
        var responseJson = json.decode(response.body);
        final message = responseJson["message"];
        throw UnauthorisedException(message.toString());
      case 403:
        var responseJson = json.decode(response.body);
        final message = responseJson["message"];
        throw UnauthorisedException(message.toString());
      case 409:
        var responseJson = json.decode(response.body);
        final message = responseJson["message"];
        throw BadRequestException(message.toString());
      case 404:
        var responseJson = json.decode(response.body);
        final message = responseJson["message"];
        throw NotFoundException(message.toString());
      case 500:
        var responseJson = json.decode(response.body);
        final message = responseJson["message"];
        throw ServerErrorException(message.toString());
      default:
        var responseJson = json.decode(response.body);
        final message = responseJson["message"];
        if (message != null) {
          throw ServerErrorException(message.toString());
        }
        throw FetchDataException('Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
