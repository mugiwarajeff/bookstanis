abstract class AuthExceptions implements Exception {
  final String message;
  final String code;

  AuthExceptions(this.message, this.code);
}

class EmailAlreadyExists extends AuthExceptions {
  EmailAlreadyExists(super.message, super.code);
  @override
  String toString() {
    return "EmailAlreadyExists: $message";
  }
}

class InvalidCredentials extends AuthExceptions {
  InvalidCredentials(super.message, super.code);

  @override
  String toString() {
    return "InvalidCredentials: $message";
  }
}

class InvalidEmail extends AuthExceptions {
  InvalidEmail(super.message, super.code);

  @override
  String toString() {
    return "InvalidEmail: $message";
  }
}

class WeakPassword extends AuthExceptions {
  WeakPassword(super.message, super.code);

  @override
  String toString() {
    return "WeakPassword: $message";
  }
}
