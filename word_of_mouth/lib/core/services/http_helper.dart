import 'dart:convert';
import 'package:http/http.dart' as http;

import '../api/end_point.dart';

class HttpHelper {

  static Future<http.Response> getData({
    required String endpoint,
    Map<String, String>? headers,
    Map<String, String>? queryParams,
  }) async {
    Uri uri = Uri.parse(EndPoints.baseUrl + endpoint).replace(queryParameters: queryParams);
    return await http.get(uri, headers: headers);
  }

  static Future<http.Response> postData({
    required String endpoint,
    required Map<String, dynamic> data,
    Map<String, String>? headers,
  }) async {
    Uri uri = Uri.parse(EndPoints.baseUrl + endpoint);
    return await http.post(
      uri,
      headers: headers ?? {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
  }

  static Future<http.Response> putData({
    required String endpoint,
    required Map<String, dynamic> data,
    Map<String, String>? headers,
  }) async {
    Uri uri = Uri.parse(EndPoints.baseUrl + endpoint);
    return await http.put(
      uri,
      headers: headers ?? {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
  }

  static Future<http.Response> deleteData({
    required String endpoint,
    Map<String, String>? headers,
  }) async {
    Uri uri = Uri.parse(EndPoints.baseUrl + endpoint);
    return await http.delete(uri, headers: headers);
  }
}