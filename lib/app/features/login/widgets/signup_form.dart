import 'package:bookstanis/app/features/login/models/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignupForm extends StatelessWidget {
  final Signup signup;
  const SignupForm({super.key, required this.signup});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final Size mediaSize = MediaQuery.of(context).size;

    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final Color onPrimaryColor = Theme.of(context).colorScheme.onPrimary;

    final String firstNameText = AppLocalizations.of(context)!.firstName;
    final String lastNameText = AppLocalizations.of(context)!.lastName;
    final String emailText = AppLocalizations.of(context)!.email;
    final String passwordText = AppLocalizations.of(context)!.password;
    final String confirmPasswordText =
        AppLocalizations.of(context)!.confirmPass;
    final String phoneText = AppLocalizations.of(context)!.phone;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: mediaSize.height * 0.55,
        width: mediaSize.width,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Cor da sombra
                spreadRadius: 2, // Largura da sombra
                blurRadius: 8, // Desfoque da sombra
                offset: const Offset(0, 5), // Offset para baixo
              ),
            ],
            borderRadius: BorderRadius.circular(20),
            color: onPrimaryColor.withOpacity(0.6)),
        child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    initialValue: signup.firstName.value,
                    onChanged: (value) {
                      signup.firstName.value = value;
                    },
                    validator: (value) => signup.firstName
                        .validate(value, AppLocalizations.of(context)!),
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        label: Text(firstNameText),
                        hintText: firstNameText),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    initialValue: signup.lastName.value,
                    onChanged: (value) {
                      signup.lastName.value = value;
                    },
                    validator: (value) => signup.lastName
                        .validate(value, AppLocalizations.of(context)!),
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        label: Text(lastNameText),
                        hintText: lastNameText),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    initialValue: signup.email.value,
                    onChanged: (value) {
                      signup.email.value = value;
                    },
                    validator: (value) => signup.email
                        .validate(value, AppLocalizations.of(context)!),
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        label: Text(emailText),
                        hintText: emailText),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    initialValue: signup.firstPassword.value,
                    onChanged: (value) {
                      signup.firstPassword.value = value;
                    },
                    validator: (value) => signup.firstPassword
                        .validate(value, AppLocalizations.of(context)!),
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        label: Text(passwordText),
                        hintText: passwordText),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    initialValue: signup.secondPassword.value,
                    onChanged: (value) {
                      signup.secondPassword.value = value;
                    },
                    validator: (value) => signup.secondPassword
                        .validate(value, AppLocalizations.of(context)!),
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        label: Text(confirmPasswordText),
                        hintText: confirmPasswordText),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    initialValue: signup.phone.value,
                    onChanged: (value) {
                      signup.phone.value = value;
                    },
                    validator: (value) => signup.phone
                        .validate(value, AppLocalizations.of(context)!),
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        label: Text(phoneText),
                        hintText: phoneText),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
