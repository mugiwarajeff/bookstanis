import 'package:bookstanis/app/features/login/login_form.dart';
import 'package:bookstanis/app/features/login/models/login.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final Login login = Login.empty();
    return Scaffold(
        body: LoginForm(
      login: login,
    ));
  }
}
