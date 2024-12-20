import 'package:bookstanis/app/features/login/bloc/login_cubit.dart';
import 'package:bookstanis/app/features/login/models/signup.dart';
import 'package:bookstanis/app/shared/widgets/show_custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignupForm extends StatefulWidget {
  final Signup signup;
  final LoginCubit loginCubit;
  const SignupForm({super.key, required this.signup, required this.loginCubit});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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

    final String passwordAreNotTheSameText =
        AppLocalizations.of(context)!.typedPasswordNotSame;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: mediaSize.height * 0.75,
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              signUpText,
              style: TextStyle(
                  fontSize: 42,
                  color: primaryColor,
                  fontFamily: "Granada-Serial",
                  fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            initialValue: widget.signup.firstName.value,
                            onChanged: (value) {
                              widget.signup.firstName.value = value;
                            },
                            validator: (value) => widget.signup.firstName
                                .validate(value, AppLocalizations.of(context)!),
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                label: Text(firstNameText),
                                hintText: firstNameText),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            initialValue: widget.signup.lastName.value,
                            onChanged: (value) {
                              widget.signup.lastName.value = value;
                            },
                            validator: (value) => widget.signup.lastName
                                .validate(value, AppLocalizations.of(context)!),
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                label: Text(lastNameText),
                                hintText: lastNameText),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            initialValue: widget.signup.email.value,
                            onChanged: (value) {
                              widget.signup.email.value = value;
                            },
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) => widget.signup.email
                                .validate(value, AppLocalizations.of(context)!),
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                label: Text(emailText),
                                hintText: emailText),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            initialValue: widget.signup.firstPassword.value,
                            onChanged: (value) {
                              widget.signup.firstPassword.value = value;
                            },
                            obscureText: !passwordVisible,
                            validator: (value) => widget.signup.firstPassword
                                .validate(value, AppLocalizations.of(context)!),
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        passwordVisible = !passwordVisible;
                                      });
                                    },
                                    icon: Icon(!passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off)),
                                border: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                label: Text(passwordText),
                                hintText: passwordText),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            obscureText: !confirmPasswordVisible,
                            initialValue: widget.signup.secondPassword.value,
                            onChanged: (value) {
                              widget.signup.secondPassword.value = value;
                            },
                            validator: (value) => widget.signup.secondPassword
                                .validate(value, AppLocalizations.of(context)!),
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        confirmPasswordVisible =
                                            !confirmPasswordVisible;
                                      });
                                    },
                                    icon: Icon(!confirmPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off)),
                                border: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                label: Text(confirmPasswordText),
                                hintText: confirmPasswordText),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            initialValue: widget.signup.phone.value,
                            onChanged: (value) {
                              widget.signup.phone.value = value;
                            },
                            keyboardType: TextInputType.phone,
                            validator: (value) => widget.signup.phone
                                .validate(value, AppLocalizations.of(context)!),
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                label: Text(phoneText),
                                hintText: phoneText),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: OverflowBar(
                alignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        widget.loginCubit.loadLoginForm();
                      },
                      style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(errorColor)),
                      child: Text(
                        cancelText,
                        style: TextStyle(color: onErrorColor),
                      )),
                  const SizedBox(
                    width: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (!(formKey.currentState?.validate() ?? false)) {
                        return;
                      }
                      bool valid = widget.loginCubit.validadePassword();

                      if (!valid) {
                        showCustomSnackBar(context,
                            message: passwordAreNotTheSameText,
                            color: errorColor);
                        return;
                      }

                      widget.loginCubit
                          .registerNewUser(AppLocalizations.of(context)!);
                    },
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(primaryColor)),
                    child: Text(
                      confirmText,
                      style: TextStyle(color: onPrimaryColor),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
