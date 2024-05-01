import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_test_project/utils/app_exceptions.dart';

import 'failure.dart';

class HandleError {
  static Future<Left<Failure, dynamic>> handleCatchError(error) async {
    debugPrint('Error happened in HandleError of type ${error.runtimeType} with output\n ${error.message.toString()} ');
    if (error is DioError) {
      debugPrint('Error is DioError');
      return Left(Failure(400, error.message.toString()));
    } else if (error is UnauthorisedException) {
      return Left(Failure(401, "Invalid email or password!"));
    } else if (error is UnprocessableEntity) {
      return Left(Failure(400, error.toString()));
    } else {
      return Left(Failure(400, error.toString()));
    }
  }
}
