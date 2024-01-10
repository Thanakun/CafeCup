// ignore_for_file: prefer_typing_uninitialized_variables

class AppException implements Exception {
  final _message;

  final _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return '{$_prefix}{$_message}';
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, 'Error During Fetch Data');
}

class BadRequestException extends AppException {
  BadRequestException([String? message])
      : super(message, 'Error BadRequestException');
}

class UnautorizedException extends AppException {
  UnautorizedException([String? message])
      : super(message, 'Error UnautorizedException');
}

class InternalServerException extends AppException{
  InternalServerException([String? message]): super(message,'Error InternalServerException');
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message])
      : super(message, 'Error InvalidInputException');
}
