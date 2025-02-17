class AppException implements Exception {
  final String message;
  final String prefix;

  AppException({required this.message, required this.prefix});

  @override
  String toString() {
    return '$prefix: $message';
  }
}

class FetchDataException extends AppException {
  FetchDataException({required super.message})
      : super(prefix: 'Error During Communication');
}

class BadRequestException extends AppException {
  BadRequestException({required super.message})
      : super(prefix: 'Invalid Request');
}

class UnauthorisedException extends AppException {
  UnauthorisedException({required super.message})
      : super(prefix: 'Unauthorised');
}

class InvalidInputException extends AppException {
  InvalidInputException({required super.message})
      : super(prefix: 'Invalid Input');
}

class InvalidCredentialsException extends AppException {
  InvalidCredentialsException({required super.message})
      : super(prefix: 'Invalid Credentials');
}

class ServerException extends AppException {
  ServerException({required super.message}) : super(prefix: 'Server Error');
}

class NoInternetException extends AppException {
  NoInternetException({required super.message}) : super(prefix: 'No Internet');
}

class UnknownException extends AppException {
  UnknownException({required super.message}) : super(prefix: 'Unknown Error');
}
