import 'package:bookstanis/app/features/login/bloc/login_cubit.dart';
import 'package:bookstanis/app/features/login/bloc/login_state.dart';
import 'package:bookstanis/app/features/login/widgets/login_form.dart';
import 'package:bookstanis/app/features/login/widgets/signup_form.dart';
import 'package:bookstanis/app/shared/widgets/show_custom_snackbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final Color onPrimaryColor = Theme.of(context).colorScheme.onPrimary;
    final Color secondaryColor = Theme.of(context).colorScheme.secondary;
    final Color errorColor = Theme.of(context).colorScheme.error;

    final String weakPasswordText = AppLocalizations.of(context)!.weakPassword;
    final String emailAlreadyInUseText =
        AppLocalizations.of(context)!.emailAlreadyInUse;

    LoginCubit loginCubit = BlocProvider.of<LoginCubit>(context);

    loginCubit.loadLoginForm();

    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [primaryColor, secondaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: BlocConsumer<LoginCubit, LoginState>(builder: (context, state) {
          if (state is StandardLoginState) {
            return Column(
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
                  loginCubit: loginCubit,
                  login: state.login,
                )
              ],
            );
          }

          if (state is SignUpFormState) {
            return Center(
                child: SignupForm(
              signup: state.signup,
              loginCubit: loginCubit,
            ));
          }

          if (state is LoadingFormState) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  semanticsLabel: state.loadingMessage,
                  color: onPrimaryColor,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  state.loadingMessage,
                  style: TextStyle(color: onPrimaryColor, fontSize: 18),
                )
              ],
            ));
          }

          return const SizedBox.shrink();
        }, listener: (context, state) {
          if (state is SuccessFormState) {
            Navigator.of(context).pushReplacementNamed("/");
          }

          if (state is FailedFormState) {
            if (state.errorMesage == "invalid-credential" ||
                state.errorMesage == "invalid-email") {}
            showCustomSnackBar(context,
                message: AppLocalizations.of(context)!.userOrPasswordIncorrect,
                color: Colors.red);
          }

          if (state is SuccessOnRegisterUser) {
            Navigator.of(context).pushReplacementNamed("/");
          }

          if (state is FailedOnRegisterUser) {
            if (state.errorCode == "email-already-in-use") {
              showCustomSnackBar(context,
                  message: emailAlreadyInUseText, color: errorColor);
            }

            if (state.errorCode == "weak-password") {
              showCustomSnackBar(context,
                  message: weakPasswordText, color: errorColor);
            }
          }
        }),
      ),
    ));
  }
}
