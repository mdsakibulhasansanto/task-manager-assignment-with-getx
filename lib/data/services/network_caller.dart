import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class NetworkResponse {
  final int statusCode;
  final Map<String, dynamic>? responseData;
  final bool isSuccess;
  final String errorMessage;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.responseData,
    this.errorMessage = 'Something went wrong',
  });
}

class NetworkCaller {
  static const String _defaultErrorMessage = 'Something went wrong';

  static String? token;

  static Future<NetworkResponse> getRequest({
    required String url,
    Map<String, String>? headers,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      final fullHeaders = {
        'Content-Type': 'application/json',
        if (token != null) 'token': token!,
        ...?headers,
      };


      debugPrint(' [GET] $url');
      debugPrint(' Headers: $fullHeaders');

      Response response = await get(uri, headers: fullHeaders,);

      debugPrint(' Status: ${response.statusCode}');
      debugPrint(' Response: ${response.body}');

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decoded,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: decoded,
          errorMessage: decoded['message'] ?? _defaultErrorMessage,
        );
      }
    } catch (e) {
      debugPrint(' GET Error: $e');
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  //POST Request
  static Future<NetworkResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      final fullHeaders = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
        ...?headers,
      };

      debugPrint(' [POST] $url');
      debugPrint('Headers: $fullHeaders');
      debugPrint('Body: ${jsonEncode(body)}');

      Response response = await post(
        uri,
        headers: fullHeaders,
        body: jsonEncode(body),
      );

      debugPrint(' Status: ${response.statusCode}');
      debugPrint('Response: ${response.body}');

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decoded,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: decoded,
          errorMessage: decoded['message'] ?? _defaultErrorMessage,
        );
      }
    } catch (e) {
      debugPrint(' POST Error: $e');
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  // Delete Request
  static Future<NetworkResponse> deleteRequest({
    required String url,
    Map<String, String>? headers,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      final fullHeaders = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
        ...?headers,
      };

      debugPrint(' [DELETE] $url');
      debugPrint('Headers: $fullHeaders');

      Response response = await delete(uri, headers: fullHeaders);

      debugPrint(' Status: ${response.statusCode}');
      debugPrint('Response: ${response.body}');

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decoded,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: decoded,
          errorMessage: decoded['message'] ?? _defaultErrorMessage,
        );
      }
    } catch (e) {
      debugPrint(' DELETE Error: $e');
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  // Put Request
  static Future<NetworkResponse> putRequest({
    required String url,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      final fullHeaders = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
        ...?headers,
      };

      debugPrint(' [PUT] $url');
      debugPrint('Headers: $fullHeaders');
      debugPrint('Body: ${jsonEncode(body)}');

      Response response = await put(
        uri,
        headers: fullHeaders,
        body: jsonEncode(body),
      );

      debugPrint(' Status: ${response.statusCode}');
      debugPrint('Response: ${response.body}');

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decoded,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: decoded,
          errorMessage: decoded['message'] ?? _defaultErrorMessage,
        );
      }
    } catch (e) {
      debugPrint(' PUT Error: $e');
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }
}
