import 'package:bookstanis/app/features/profile/models/user.dart';
import 'package:flutter/material.dart';
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: primaryColor,
            foregroundColor: onPrimaryColor,
            backgroundImage: user == null
                ? const AssetImage(
                    "assets/images/user_profile.png",
                  )
                : NetworkImage(user!.imageUrl),
          ),
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

            return Text(
              "$helloText, ${user!.name}",
              style: const TextStyle(fontSize: 24),
            );
          })
        ],
      ),
    );
  }
}
