import 'package:bookstanis/app/features/login/login_form.dart';
import 'package:bookstanis/app/features/login/models/login.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final Login login = Login.empty();
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final Color onPrimaryColor = Theme.of(context).colorScheme.onPrimary;
    final Color secondaryColor = Theme.of(context).colorScheme.secondary;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [primaryColor, secondaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/logo/bookstanis_logo.png",
              height: 120,
              color: onPrimaryColor.withOpacity(0.8),
            ),
            Text(
              "BookStanis",
              style: TextStyle(
                  fontSize: 42,
                  color: onPrimaryColor.withOpacity(0.8),
                  fontFamily: "Granada-Serial",
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            LoginForm(
              login: login,
            ),
          ],
        ),
      ),
    ));
  }
}
