import 'package:bookstanis/app/features/login/models/login.dart';
import 'package:bookstanis/app/features/login/models/signup.dart';

abstract class LoginState {}

class InitialLoginState extends LoginState {}

class StandardLoginState extends LoginState {
  Login login;

  StandardLoginState({required this.login});
}

class LoadingFormState extends LoginState {
  final String loadingMessage;

  LoadingFormState({required this.loadingMessage});
}

class SignUpFormState extends LoginState {
  Signup signup;

  SignUpFormState({required this.signup});
}

class SuccessFormState extends LoginState {
  String successMessage;

  SuccessFormState({required this.successMessage});
}

class FailedFormState extends LoginState {
  String errorMesage;

  FailedFormState({required this.errorMesage});
}

class SuccessOnRegisterUser extends LoginState {}
