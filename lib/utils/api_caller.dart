import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile_test_project/data/sources/local/cache_helper.dart';
import 'package:mobile_test_project/data/sources/local/cache_keys.dart';
import '../data/network/network_info.dart';
import 'app_exceptions.dart';
import 'constants.dart';

class APICaller {
  final NetworkInfo _networkInfo = NetworkInfoImpl(InternetConnectionChecker());

  String url = Constants.baseUrl;

  setUrl(String uri) {
    url = Constants.baseUrl + uri;
  }

  getToken() {
    return CacheHelper.get(CacheKeys.spToken);
  }

  Future<dynamic> getData({Map<String, String>? headers, bool needAuthorization = false}) async {
    if (await _networkInfo.isConnected) {
      headers ??= {};
      headers['Accept'] = 'application/json';

      if (needAuthorization) {
        String? token = getToken();
        if (token != null) {
          headers['Authorization'] = token;
        }
      }
      logApiRequest(type: 'GET', url: url, headers: headers, needAuthorization: needAuthorization);

      try {
        final res = await http.get(Uri.parse(url), headers: headers).timeout(const Duration(seconds: 50), onTimeout: () {
          throw RequestTimeOutException("Poor internet or no internet connectivity");
        });

        logApiResponse(url: url, response: res.body, statusCode: res.statusCode.toString());
        return res;
      } on SocketException {
        return const SocketException('');
      }
    } else {
      throw "No Internet Connection!";
    }
  }

  Future<dynamic> postData({Map<String, dynamic>? body, Map<String, String>? headers, bool needAuthorization = false}) async {
    if (await _networkInfo.isConnected) {
      headers ??= {};
      headers['Accept'] = 'application/json';
      headers['Content-Type'] = 'application/json';
      if (needAuthorization) {
        String? token = getToken();
        if (token != null) {
          headers['Authorization'] = token;
        }
      }

      logApiRequest(type: 'POST', url: url, headers: headers, body: body, needAuthorization: needAuthorization);
      body ??= {};
      try {
        final res = await http.post(Uri.parse(url), headers: headers, body: json.encode(body)).timeout(
            const Duration(
              seconds: 50,
            ), onTimeout: () {
          throw RequestTimeOutException("Poor internet or no internet connectivity");
        });

        logApiResponse(url: url, response: res.body, statusCode: res.statusCode.toString());
        return res;
      } on SocketException {
        return const SocketException('');
      }
    } else {
      throw 'No Internet Connection!';
    }
  }

  Future<dynamic> postDataDynamicBody({dynamic body, Map<String, String>? headers, bool needAuthorization = false}) async {
    if (await _networkInfo.isConnected) {
      headers ??= {};
      headers['Accept'] = 'application/json';
      headers['Content-Type'] = 'application/json';
      if (needAuthorization) {
        String? token = getToken();
        if (token != null) {
          headers['Authorization'] = token;
        }
      }

      logApiRequest(type: 'POST DYNAMIC', url: url, headers: headers, body: body, needAuthorization: needAuthorization);

      try {
        final res = await http.post(Uri.parse(url), headers: headers, body: json.encode(body)).timeout(
            const Duration(
              seconds: 50,
            ), onTimeout: () {
          throw RequestTimeOutException("Poor internet or no internet connectivity");
        });

        logApiResponse(url: url, response: res.body, statusCode: res.statusCode.toString());
        return res;
      } on SocketException {
        return const SocketException('');
      }
    } else {
      throw 'No Internet Connection!';
    }
  }

  Future<dynamic> postDataViaDio({
    FormData? body,
    Map<String, String>? headers,
    bool needAuthorization = false,
    bool attachContentTypeHeader = true,
  }) async {
    if (await _networkInfo.isConnected) {
      headers ??= {};
      // headers['Accept-Language'] = Root.locale.languageCode.toUpperCase();
      // if (attachContentTypeHeader) headers['Content-Type'] = 'application/json';
      // headers['Content-Type'] = 'multipart/form-data; boundary=<calculated when request is sent>';
      headers['Accept'] = 'application/json';

      if (needAuthorization) {
        String? token = getToken();

        if (token != null) {
          headers['Authorization'] = token;
        }
      }

      // logApiRequest(type: 'POST DIO', url: url, headers: headers, body: body, needAuthorization: needAuthorization);
      // body ??= {};

      try {
        final res = await Dio().post(
          url,
          data: body,
          options: Options(headers: headers, followRedirects: false),
        );

        logApiResponse(url: url, response: res.data, statusCode: res.statusCode.toString());
        return res;
      } on SocketException {
        return const SocketException('');
      }
    } else {
      throw 'No Internet Connection!';
    }
  }

  Future<dynamic> putData({Map? body, Map<String, String>? headers, bool needAuthorization = false}) async {
    if (await _networkInfo.isConnected) {
      headers ??= {};
      headers['Accept'] = 'application/json';
      headers['Content-Type'] = 'application/json';
      if (needAuthorization) {
        String? token = getToken();

        if (token != null) {
          headers['Authorization'] = token;
        }
      }

      logApiRequest(type: 'PUT', url: url, headers: headers, body: body, needAuthorization: needAuthorization);

      try {
        final res = await http.put(Uri.parse(url), headers: headers, body: json.encode(body)).timeout(
            const Duration(
              seconds: 50,
            ), onTimeout: () {
          throw RequestTimeOutException(
            'Poor internet or no internet connectivity',
          );
        });

        logApiResponse(url: url, response: res.body, statusCode: res.statusCode.toString());
        return res;
      } on SocketException {
        return const SocketException('');
      }
    } else {
      throw 'No Internet Connection!';
    }
  }

  Future<dynamic> putDataWithoutHeaders({Map? body, Map<String, String>? headers, bool needAuthorization = false}) async {
    if (await _networkInfo.isConnected) {
      headers ??= {};
      if (needAuthorization) {
        String? token = getToken();

        if (token != null) {
          headers['Authorization'] = token;
        }
      }

      logApiRequest(type: 'PUT NO HEADERS', url: url, headers: headers, body: body, needAuthorization: needAuthorization);

      try {
        final res = await http.put(Uri.parse(url), headers: headers, body: json.encode(body)).timeout(
            const Duration(
              seconds: 50,
            ), onTimeout: () {
          throw RequestTimeOutException(
            'Poor internet or no internet connectivity',
          );
        });

        logApiResponse(url: url, response: res.body, statusCode: res.statusCode.toString());
        return res;
      } on SocketException {
        return const SocketException('');
      }
    } else {
      throw 'No Internet Connection!';
    }
  }

  Future<dynamic> deleteData({Map? body, Map<String, String>? headers, bool needAuthorization = false}) async {
    if (await _networkInfo.isConnected) {
      headers ??= {};
      if (needAuthorization) {
        String? token = getToken();

        if (token != null) {
          headers['Authorization'] = token;
        }
      }
      logApiRequest(type: 'Delete', url: url, headers: headers, body: body, needAuthorization: needAuthorization);

      try {
        final res = await http.delete(Uri.parse(url), headers: headers, body: json.encode(body)).timeout(
            const Duration(
              seconds: 50,
            ), onTimeout: () {
          throw RequestTimeOutException(
            'Poor internet or no internet connectivity',
          );
        });

        logApiResponse(url: url, response: res.body, statusCode: res.statusCode.toString());
        return res;
      } on SocketException {
        return const SocketException('');
      }
    } else {
      throw 'No Internet Connection!';
    }
  }
}

void logApiRequest({
  required String type,
  required String url,
  Map? headers = const {},
  Map? body = const {},
  bool needAuthorization = false,
}) {
  debugPrint(
    '///** logApiRequest'
    '\nFire request to: $url'
    '\nAPICall: $type '
    '\nHeaders: $headers'
    '\nBody: $body'
    '\nneedAuthorization: $needAuthorization'
    '\nlogApiRequest **///',
  );
}

void logApiResponse({
  required String url,
  required String statusCode,
  dynamic response,
}) {
  debugPrint(
    '///** logApiResponse'
    '\nResult of request: $url'
    '\nstatusCode: $statusCode '
    '\nresponse: $response '
    '\nlogApiResponse **///',
  );
}
