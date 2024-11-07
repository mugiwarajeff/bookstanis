import 'package:bookstanis/app/features/login/models/login.dart';

abstract class LoginState {}

class InitialLoginState extends LoginState {}

class LoadedLoginState extends LoginState {
  Login login;

  LoadedLoginState({required this.login});
}
