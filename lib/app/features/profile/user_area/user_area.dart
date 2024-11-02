import 'package:bookstanis/app/features/login/models/user.dart';
import 'package:flutter/material.dart';

class UserArea extends StatelessWidget {
  final User? user;

  const UserArea({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color onPrimaryColor = Theme.of(context).colorScheme.onPrimary;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: primaryColor,
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
                child:
                    ElevatedButton(onPressed: () {}, child: Text("Faça Login")),
              );
            }

            return Text(
              "Olá, ${user!.nome}",
              style: const TextStyle(fontSize: 24),
            );
          })
        ],
      ),
    );
  }
}
