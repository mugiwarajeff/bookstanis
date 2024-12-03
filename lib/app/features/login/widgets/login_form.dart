import 'package:bookstanis/app/features/login/bloc/login_cubit.dart';
import 'package:bookstanis/app/features/login/models/login.dart';
import 'package:bookstanis/app/features/login/widgets/login_form/form_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginForm extends StatefulWidget {
  final Login login;
  final LoginCubit loginCubit;
  const LoginForm({super.key, required this.login, required this.loginCubit});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final String userNameText = AppLocalizations.of(context)!.userName;
    final String passwordText = AppLocalizations.of(context)!.password;

    final String enterWithGmailText =
        AppLocalizations.of(context)!.enterWithGmail;
    final String forgotPasswordText =
        AppLocalizations.of(context)!.forgotPassword;
    final String loginText = AppLocalizations.of(context)!.login;
    final String signUpText = AppLocalizations.of(context)!.signup;

    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final Color onPrimaryColor = Theme.of(context).colorScheme.onPrimary;

    const double fontPageSize = 16;
    const double buttonPageHeight = 50;
    const double buttonPageWidth = 500;

    const double iconSize = 34;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Container(
          height: screenSize.height * 0.55,
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
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: widget.login.username.value,
                          onChanged: (value) {
                            widget.login.username.value = value;
                          },
                          validator: (value) => widget.login.username
                              .validate(value, AppLocalizations.of(context)!),
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              label: Text(userNameText),
                              hintText: userNameText),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          initialValue: widget.login.password.value,
                          obscureText: !passwordVisible,
                          onChanged: (value) {
                            widget.login.password.value = value;
                          },
                          validator: (value) => widget.login.password
                              .validate(value, AppLocalizations.of(context)!),
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      passwordVisible = !passwordVisible;
                                    });
                                  },
                                  icon: passwordVisible
                                      ? const Icon(
                                          Icons.password,
                                        )
                                      : const Icon(
                                          Icons.remove_red_eye,
                                        )),
                              border: const OutlineInputBorder(),
                              fillColor: onPrimaryColor,
                              label: Text(passwordText),
                              hintText: passwordText),
                        ),
                      ],
                    )),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {}, child: Text(forgotPasswordText)),
                ),
                const SizedBox(
                  height: 15,
                ),
                FormButton(
                    buttonHeight: buttonPageHeight,
                    buttonWidth: buttonPageWidth,
                    fontSize: fontPageSize,
                    labelText: loginText,
                    backgroundColor: primaryColor,
                    textColor: onPrimaryColor,
                    buttonIcon: Icon(
                      Icons.login,
                      color: onPrimaryColor,
                      size: iconSize,
                    ),
                    onTap: () {
                      if (!(formKey.currentState?.validate() ?? false)) {
                        return;
                      }

                      widget.loginCubit.signIn(AppLocalizations.of(context)!);
                    }),
                const SizedBox(
                  height: 15,
                ),
                FormButton(
                    buttonHeight: buttonPageHeight,
                    buttonWidth: buttonPageWidth,
                    fontSize: fontPageSize,
                    labelText: signUpText,
                    buttonIcon: const Icon(
                      Icons.person_add,
                      size: iconSize,
                    ),
                    onTap: () {
                      widget.loginCubit.loadSignUpForm();
                    }),
                const SizedBox(
                  height: 15,
                ),
                FormButton(
                    buttonHeight: buttonPageHeight,
                    buttonWidth: buttonPageWidth,
                    fontSize: fontPageSize,
                    labelText: enterWithGmailText,
                    buttonIcon: Image.asset(
                      "assets/icons/login/gmail.png",
                      height: 50,
                    ),
                    onTap: () {
                      widget.loginCubit
                          .signInWithGoogle(AppLocalizations.of(context)!);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
