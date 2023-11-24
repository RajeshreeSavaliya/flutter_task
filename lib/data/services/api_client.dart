import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiClient {
  static const baseUrl = 'https://jsonplaceholder.typicode.com/';

  final http.Client httpClient = http.Client();

  static const albums = 'albums'; // Replace this with your login url end point
  static const photos = 'photos'; // Repl

  ApiClient();

  Future apiCallGet(String url, {String query = ""}) async {
    String responseJson;
    String getUrl;

    if (query.isNotEmpty) {
      getUrl = '$baseUrl$url/$query';
    } else {
      getUrl = '$baseUrl$url';
    }

    try {
      final response = await httpClient
          .get(
            Uri.parse(getUrl),
          )
          .timeout(const Duration(seconds: 60));
      responseJson = response.body;
    } on SocketException {
      throw const SocketException('No Internet Connection');
    }
    return responseJson;
  }
}
