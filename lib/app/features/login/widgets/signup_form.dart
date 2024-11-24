import 'package:bookstanis/app/features/login/bloc/login_cubit.dart';
import 'package:bookstanis/app/features/login/models/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignupForm extends StatelessWidget {
  final Signup signup;
  final LoginCubit loginCubit;
  const SignupForm({super.key, required this.signup, required this.loginCubit});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final Size mediaSize = MediaQuery.of(context).size;

    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final Color onPrimaryColor = Theme.of(context).colorScheme.onPrimary;
    final Color errorColor = Theme.of(context).colorScheme.error;
    final Color onErrorColor = Theme.of(context).colorScheme.onError;

    final String firstNameText = AppLocalizations.of(context)!.firstName;
    final String lastNameText = AppLocalizations.of(context)!.lastName;
    final String emailText = AppLocalizations.of(context)!.email;
    final String passwordText = AppLocalizations.of(context)!.password;
    final String confirmPasswordText =
        AppLocalizations.of(context)!.confirmPass;
    final String phoneText = AppLocalizations.of(context)!.phone;
    final String signUpText = AppLocalizations.of(context)!.signup;
    final String confirmText = AppLocalizations.of(context)!.confirm;
    final String cancelText = AppLocalizations.of(context)!.cancel;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: mediaSize.height * 0.7,
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
        child: Column(
          children: [
            Text(
              signUpText,
              style: TextStyle(
                  fontSize: 42,
                  color: primaryColor,
                  fontFamily: "Granada-Serial",
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
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
                        const SizedBox(
                          height: 15,
                        ),
                        OverflowBar(
                          alignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  loginCubit.loadLoginForm();
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStatePropertyAll(errorColor)),
                                child: Text(
                                  cancelText,
                                  style: TextStyle(color: onErrorColor),
                                )),
                            const SizedBox(
                              width: 15,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (!(formKey.currentState?.validate() ??
                                    false)) {
                                  return;
                                }

                                print("fazendo algo");
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStatePropertyAll(primaryColor)),
                              child: Text(
                                confirmText,
                                style: TextStyle(color: onPrimaryColor),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
