class AppException implements Exception {
  final dynamic _message;
  final dynamic _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    String msg = _message.replaceAll('\$', '\n');
    msg = msg.replaceAll('"', '');
    msg = msg.trim();
    msg = "\n$msg";
    return "$_prefix$msg";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, 'Error During Communication: ');
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, 'Invalid Request: ');
}

class ServerErrorException extends AppException {
  ServerErrorException([message]) : super(message, 'Please Try again later: ');
}

class UnprocessableEntity extends AppException {
  UnprocessableEntity([message]) : super(message, 'Please fix the following errors: ');
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, 'Unauthorised: ');
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, 'Invalid Input: ');
}

class RequestTimeOutException extends AppException {
  RequestTimeOutException([String? message]) : super(message, 'Request time out: ');
}
