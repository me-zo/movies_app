class NoInternetException implements Exception {
  final String message;

  NoInternetException(this.message);

  @override
  String toString() => "$runtimeType Message: $message";
}

class ServerErrorException implements Exception {
  final int statusCode;
  final String body;

  ServerErrorException({required this.statusCode, required this.body});

  @override
  String toString() => "$runtimeType statusCode: $statusCode body: $body";
}

class ClientErrorException implements Exception {
  final int statusCode;
  final String body;

  ClientErrorException({required this.statusCode, required this.body});

  @override
  String toString() => "$runtimeType statusCode: $statusCode body: $body";
}

class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException({required this.message});

  @override
  String toString() => "$runtimeType Message: $message";
}

class NotFoundException implements Exception {
  final String message;

  NotFoundException({required this.message});

  @override
  String toString() => "$runtimeType Message: $message";
}

enum FailureActions {
  display,
  workAround,
}

class Failure {
  final String message;
  final FailureActions failureAction;

  Failure({
    this.failureAction = FailureActions.display,
    required this.message,
  });
}
