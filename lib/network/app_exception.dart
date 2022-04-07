class AppException implements Exception {
  final String message;
  final String serviceMessage;
  final String prefix;
  
  AppException(this.message, this.serviceMessage, this.prefix);
  
  @override
  String toString() {
    return "$prefix: message:$message, serviceMessage: $serviceMessage";
  }
}

class FetchDataException extends AppException {
  FetchDataException(message, serviceMessage)
      : super(message, serviceMessage, "Error During Communication: ");
}

class AuthFailException extends AppException {
  AuthFailException(message, serviceMessage) : super(message, serviceMessage, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  InvalidInputException(message, serviceMessage) : super(message, serviceMessage, "Invalid Input: ");
}

class SocketException extends AppException {
  SocketException(message, serviceMessage) : super(message, serviceMessage, "SocketException: ");
}
class WebSocketException extends AppException {
  WebSocketException(message, serviceMessage) : super(message, serviceMessage, "WebSocketException: ");
}
class SuccessException extends AppException {
  SuccessException(message, serviceMessage) : super(message, serviceMessage, "SuccessException: ");
}
class TimeOutException extends AppException {
  TimeOutException(message, serviceMessage) : super(message, serviceMessage, "TimeOutException: ");
}

class PMException extends AppException {
  PMException(message, serviceMessage) : super(message, serviceMessage, "PM Exception: ");
}
