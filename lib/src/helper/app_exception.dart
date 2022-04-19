class AppException implements Exception {
  final String? _message;
  final String? _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, "Errore durante la comunicazione con il server: ");
}

class SimpleException extends AppException {
  SimpleException([String? message]) : super(message, "");
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([String? message]) : super(message, "Unauthorised: ");
}

class BadTokenException extends AppException {
  BadTokenException([String? message]) : super(message, "");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}

class LocationException extends AppException {
  LocationException([String? message]) : super(message, "Location Exception");
}

class EmptyListException extends AppException {
  EmptyListException([String? message]) : super(message, "Empty List: ");
}
