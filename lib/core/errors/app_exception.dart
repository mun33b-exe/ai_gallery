/// Domain and application exception definitions.
class AppException implements Exception {
  const AppException(this.message, {this.code, this.cause});

  final String message;
  final String? code;
  final Object? cause;

  @override
  String toString() =>
      'AppException(code: $code, message: $message, cause: $cause)';
}

class AuthAppException extends AppException {
  const AuthAppException(super.message, {super.code, super.cause});
}

class ConfigurationException extends AppException {
  const ConfigurationException(super.message, {super.code, super.cause});
}

class NetworkAppException extends AppException {
  const NetworkAppException(super.message, {super.code, super.cause});
}
