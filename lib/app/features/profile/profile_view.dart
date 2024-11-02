import 'package:bookstanis/app/features/profile/user_area/user_area.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        UserArea(
          user: null,
        )
      ],
    );
  }
}
