import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'failure.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      failure = _handleError(error);
    } else {
      failure = DataSource.defaultError.getFailure();
    }
  }
}

Failure _handleError(DioError error) {
  debugPrint('/////_handleError ${error.message}');
  switch (error.type) {
    case DioErrorType.connectTimeout:
      return DataSource.connectTimeout.getFailure();
    case DioErrorType.sendTimeout:
      return DataSource.sendTimeout.getFailure();
    case DioErrorType.receiveTimeout:
      return DataSource.receiveTimeout.getFailure();
    case DioErrorType.response:
      if (error.response != null && error.response?.statusCode != null && error.response?.statusMessage != null) {
        return Failure(error.response?.statusCode ?? 0, error.response?.statusMessage ?? "");
      } else {
        return DataSource.defaultError.getFailure();
      }
    case DioErrorType.cancel:
      return DataSource.cancel.getFailure();
    case DioErrorType.other:
      return DataSource.defaultError.getFailure();
  }
}

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unauthorized,
  notFound,
  internalServer,
  connectTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cache,
  noInternetConnection,
  defaultError
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.success:
        return Failure(ResponseCode.success, ResponseMessage.success);
      case DataSource.noContent:
        return Failure(ResponseCode.noContent, ResponseMessage.noContent);
      case DataSource.badRequest:
        return Failure(ResponseCode.badRequest, ResponseMessage.badRequest);
      case DataSource.forbidden:
        return Failure(ResponseCode.forbidden, ResponseMessage.forbidden);
      case DataSource.unauthorized:
        return Failure(ResponseCode.unauthorized, ResponseMessage.unauthorized);
      case DataSource.notFound:
        return Failure(ResponseCode.notFound, ResponseMessage.notFound);
      case DataSource.internalServer:
        return Failure(ResponseCode.internalServerError, ResponseMessage.internalServerError);
      case DataSource.connectTimeout:
        return Failure(ResponseCode.connectTimeout, ResponseMessage.connectTimeout);
      case DataSource.cancel:
        return Failure(ResponseCode.cancel, ResponseMessage.cancel);
      case DataSource.receiveTimeout:
        return Failure(ResponseCode.receiveTimeout, ResponseMessage.receiveTimeout);
      case DataSource.sendTimeout:
        return Failure(ResponseCode.sendTimeout, ResponseMessage.sendTimeout);
      case DataSource.cache:
        return Failure(ResponseCode.cacheError, ResponseMessage.cacheError);
      case DataSource.noInternetConnection:
        return Failure(ResponseCode.noInternetConnection, ResponseMessage.noInternetConnection);
      case DataSource.defaultError:
        return Failure(ResponseCode.defaultError, ResponseMessage.defaultError);
    }
  }
}

class ResponseCode {
  static const int success = 200; // success with data
  static const int noContent = 201; // success with no data (no content)
  static const int badRequest = 400; // failure, API rejected request
  static const int unauthorized = 401; // failure, user is not authorized
  static const int forbidden = 403; //  failure, API rejected request
  static const int internalServerError = 500; // failure, crash on the server side
  static const int notFound = 404; // failure, not found

  // local status code
  static const int connectTimeout = -1;
  static const int cancel = -2;
  static const int receiveTimeout = -3;
  static const int sendTimeout = -4;
  static const int cacheError = -5;
  static const int noInternetConnection = -6;
  static const int defaultError = -7;
}

class ResponseMessage {
  // Success with data
  static String success = 'Success';

  // Success with no data (no content)
  static String noContent = 'No Content';

  // Failure, API rejected request
  static String badRequest = 'Bad Request Error';

  // Failure, user is not authorized
  static String unauthorized = 'Unauthorized Error';

  // Failure, API rejected request
  static String forbidden = 'Forbidden Error';

  // Failure, crash on the server side
  static String internalServerError = 'Internal Server Error';

  // Failure, not found
  static String notFound = 'Not Found Error';

  // local status code
  static String connectTimeout = 'Timeout Error';
  static String cancel = 'Default Error';
  static String receiveTimeout = 'Timeout Error';
  static String sendTimeout = 'Timeout Error';
  static String cacheError = 'Cache Error';
  static String noInternetConnection = 'No Internet Error';
  static String defaultError = 'Default Error';
}

class ApiInternalStatus {
  static const int success = 0;
  static const int failure = 1;
}
