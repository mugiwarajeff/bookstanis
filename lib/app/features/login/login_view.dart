import 'package:bookstanis/app/features/login/bloc/login_cubit.dart';
import 'package:bookstanis/app/features/login/bloc/login_state.dart';
import 'package:bookstanis/app/features/login/widgets/login_form.dart';
import 'package:bookstanis/app/features/login/widgets/signup_form.dart';
import 'package:bookstanis/app/shared/widgets/show_custom_snackbar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final Color onPrimaryColor = Theme.of(context).colorScheme.onPrimary;
    final Color secondaryColor = Theme.of(context).colorScheme.secondary;

    LoginCubit loginCubit = BlocProvider.of<LoginCubit>(context);

    loginCubit.loadLoginForm();

    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
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
            return SignupForm(signup: state.signup);
          }

          return const SizedBox.shrink();
        }, listener: (context, state) {
          if (state is SuccessFormState) {
            showCustomSnackBar(
              context,
              message: state.successMessage,
            );
          }

          if (state is FailedFormState) {
            showCustomSnackBar(context,
                message: state.errorMesage, color: Colors.red);
          }
        }),
      ),
    ));
  }
}
