import 'package:bookstanis/app/features/login/bloc/login_cubit.dart';
import 'package:bookstanis/app/features/profile/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserArea extends StatelessWidget {
  final User? user;

  const UserArea({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color onPrimaryColor = Theme.of(context).colorScheme.onPrimary;

    final String signInText = AppLocalizations.of(context)!.signIn;
    final String helloText = AppLocalizations.of(context)!.hello;

    final LoginCubit loginCubit = BlocProvider.of<LoginCubit>(context);

    CircleAvatar userImageBuilder(User? user) {
      if (user == null) {
        return CircleAvatar(
            radius: 35,
            backgroundColor: primaryColor,
            foregroundColor: onPrimaryColor,
            backgroundImage: const AssetImage(
              "assets/images/user_profile.png",
            ));
      }

      if (user.imageUrl == null) {
        String firstName = user.firstName.isNotEmpty
            ? user.firstName.substring(0, 1)
            : user.firstName.substring(0);
        String lastname = user.lastName.isNotEmpty
            ? user.lastName.substring(0, 1)
            : user.lastName.substring(0);

        return CircleAvatar(
          radius: 35,
          backgroundColor: primaryColor,
          foregroundColor: onPrimaryColor,
          child: Text(
            "$firstName$lastname",
            style: const TextStyle(fontSize: 32),
          ),
        );
      }

      return CircleAvatar(
          radius: 35,
          backgroundColor: primaryColor,
          foregroundColor: onPrimaryColor,
          backgroundImage: NetworkImage(user.imageUrl!));
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          userImageBuilder(user),
          const SizedBox(
            width: 20,
          ),
          Builder(builder: (context) {
            if (user == null) {
              return Expanded(
                flex: 2,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("/login");
                    },
                    child: Text(signInText)),
              );
            }

            return Column(
              children: [
                Text(
                  "$helloText, ${user!.firstName}",
                  style: const TextStyle(fontSize: 24),
                ),
                ElevatedButton(
                    onPressed: () {
                      loginCubit.logoutCurrentUser();
                    },
                    child: Text("(logout)"))
              ],
            );
          })
        ],
      ),
    );
  }
}
