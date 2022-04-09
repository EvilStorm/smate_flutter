import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http_interceptor/http/intercepted_http.dart';
import 'package:http/http.dart';

import 'app_exception.dart';
import 'http_log_intercepter.dart';

class HttpClient {
  final testDomain = "192.168.0.13:2394";
  final liveDomain = "192.168.0.13:2394";
  Map<String, String> header = {
    "Content-Type": "application/json",
  };

  String getDomain() {
    return kReleaseMode ? testDomain : liveDomain;
  }

  String getEndPointPrefix(endPoint) {
    return '/api' + endPoint;
  }

  static final HttpClient instance = HttpClient.init();
  factory HttpClient() {
    return instance;
  }
  HttpClient.init() {
    header["Content-Type"] = "application/json";
  }

  final http = InterceptedHttp.build(interceptors: [
    HttpLoggerInterceptor(),
  ]);

  void addHeader(key, value) {
    header[key] = value;
  }

  void clearHeader() {
    header.clear();

    header["Content-Type"] = "application/json";
  }

  Future<dynamic> getOtherPlatform(String domain, String path,
      {Map<String, dynamic> queryParams = const {}}) async {
    dynamic responseJson;
    try {
      final uri = Uri.https(domain, path, queryParams);
      final response = await http
          .get(uri, headers: header)
          .timeout(const Duration(seconds: 10));
      responseJson = _returnResponse(response);
    } on Exception catch (e) {
      throw exceptionTypeCheck(e);
    }
    return responseJson;
  }

  Future<dynamic> get(String url,
      {Map<String, dynamic> queryParams = const {}}) async {
    dynamic responseJson;
    try {
      final uri = Uri.http(getDomain(), getEndPointPrefix(url), queryParams);
      final response = await http
          .get(uri, headers: header)
          .timeout(const Duration(seconds: 10));
      responseJson = _returnResponse(response);
    } on Exception catch (e) {
      throw exceptionTypeCheck(e);
    }
    return responseJson;
  }

  Future<dynamic> post(String url, {dynamic queryParams, Object? body}) async {
    dynamic responseJson;
    try {
      final uri = Uri.http(getDomain(), getEndPointPrefix(url), queryParams);

      final response = await http
          .post(uri, headers: header, body: jsonEncode(body))
          .timeout(const Duration(seconds: 10));

      responseJson = _returnResponse(response);
    } on Exception catch (e) {
      throw exceptionTypeCheck(e);
    }
    return responseJson;
  }

  Future<dynamic> put(String url,
      {dynamic queryParams = const {}, Object? body}) async {
    dynamic responseJson;
    try {
      final uri = Uri.http(getDomain(), getEndPointPrefix(url), queryParams);
      final response = await http
          .put(uri, headers: header, body: jsonEncode(body))
          .timeout(const Duration(seconds: 10));
      responseJson = _returnResponse(response);
    } on Exception catch (e) {
      throw exceptionTypeCheck(e);
    }
    return responseJson;
  }

  Future<dynamic> patch(String url,
      {Map<String, dynamic>? queryParams = const {}, Object? body}) async {
    dynamic responseJson;
    try {
      final uri = Uri.http(getDomain(), getEndPointPrefix(url), queryParams);
      final response = await http
          .patch(uri, headers: header, body: jsonEncode(body))
          .timeout(const Duration(seconds: 10));

      responseJson = _returnResponse(response);
    } on Exception catch (e) {
      throw exceptionTypeCheck(e);
    }

    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    dynamic responseJson;
    try {
      final response = await http.delete(
          Uri.parse(getDomain() + getEndPointPrefix(url)),
          headers: header);
      responseJson = _returnResponse(response);
    } on Exception catch (e) {
      throw exceptionTypeCheck(e);
    }
    return responseJson;
  }

  AppException exceptionTypeCheck(Exception e) {
    if (e is AppException) {
      throw e;
    } else if (e is TimeoutException) {
      throw TimeOutException(
          "일시적인 네트워크 오류로 정보를 받아오지 못했습니다.\n잠시후 다시 시도해주세요.", "Fetch TimeOut");
    } else if (e is SocketException) {
      throw TimeOutException(
          "일시적인 네트워크 오류로 정보를 받아오지 못했습니다.\n잠시후 다시 시도해주세요.", "SocketException");
    } else if (e is WebSocketException) {
      throw TimeOutException("일시적인 네트워크 오류로 정보를 받아오지 못했습니다.\n잠시후 다시 시도해주세요.",
          "WebSocketException");
    } else {
      throw AppException(e.toString(), "오류", "UndefinedException");
    }
  }

  dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 401:
      case 403:
        throw AuthFailException(response.body.toString(), "Auth");
      case 500:
      case 502:
        throw PMException(response.body.toString(), "CheckPM");
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}',
            "Server Error");
    }
  }
}
