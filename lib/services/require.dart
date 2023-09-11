// ignore_for_file: depend_on_referenced_packages

import 'package:http/http.dart' as http;

Future<http.StreamedResponse> getAll(
    Map<String, dynamic> payload, String path) async {
  var url = path;

  Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  var request = http.Request('GET', Uri.parse(url));
  request.headers.addAll(headers);

  try {
    http.StreamedResponse response = await request.send();

    if (response.statusCode <= 200 || response.statusCode <= 300) {
      return response;
    }
    throw Exception('Request failed with status: ${response.statusCode}');
  } catch (e) {
    throw Exception('An error occurred during the request: $e');
  }
}
