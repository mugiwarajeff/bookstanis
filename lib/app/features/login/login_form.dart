import 'package:bookstanis/app/features/login/models/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginForm extends StatefulWidget {
  final Login login;
  const LoginForm({super.key, required this.login});

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

    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final Color onPrimaryColor = Theme.of(context).colorScheme.onPrimary;

    const double fontPageSize = 18;
    const double buttonPageHeight = 50;
    const double buttonPageWidth = 500;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Container(
          height: screenSize.height * 0.4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.withOpacity(0.15)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: widget.login.username,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              label: Text(userNameText),
                              hintText: userNameText),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          initialValue: widget.login.password,
                          obscureText: !passwordVisible,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      passwordVisible = !passwordVisible;
                                    });
                                  },
                                  icon: passwordVisible
                                      ? const Icon(Icons.password)
                                      : const Icon(Icons.remove_red_eye)),
                              border: const OutlineInputBorder(),
                              label: Text(passwordText),
                              hintText: passwordText),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                    width: buttonPageWidth,
                    height: buttonPageHeight,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(primaryColor)),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: onPrimaryColor, fontSize: fontPageSize),
                        ))),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                    width: buttonPageWidth,
                    height: buttonPageHeight,
                    child: ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/icons/login/gmail.png",
                              height: 50,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              enterWithGmailText,
                              style: const TextStyle(fontSize: fontPageSize),
                            ),
                          ],
                        ))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
