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

class OperationNotAllowed extends AuthExceptions {
  OperationNotAllowed(super.message, super.code);

  @override
  String toString() {
    return "OperationNotAllowed: $message";
  }
}

class AccountExistsWithDifferentCredential extends AuthExceptions {
  AccountExistsWithDifferentCredential(super.message, super.code);

  @override
  String toString() {
    return "AccountExistsWithDifferentCredential: $message";
  }
}

class UserDisabled extends AuthExceptions {
  UserDisabled(super.message, super.code);

  @override
  String toString() {
    return "UserDisabled: $message";
  }
}

class UserNotFound extends AuthExceptions {
  UserNotFound(super.message, super.code);

  @override
  String toString() {
    return "UserNotFound: $message";
  }
}

class WrongPassword extends AuthExceptions {
  WrongPassword(super.message, super.code);

  @override
  String toString() {
    return "WrongPassword: $message";
  }
}

class InvalidVerificationCode extends AuthExceptions {
  InvalidVerificationCode(super.message, super.code);

  @override
  String toString() {
    return "InvalidVerificationCode: $message";
  }
}

class InvalidVerificationId extends AuthExceptions {
  InvalidVerificationId(super.message, super.code);

  @override
  String toString() {
    return "InvalidVerificationId: $message";
  }
}
