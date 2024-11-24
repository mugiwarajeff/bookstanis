import 'package:bookstanis/app/features/profile/bloc/profile_cubit.dart';
import 'package:bookstanis/app/features/profile/bloc/profile_states.dart';
import 'package:bookstanis/app/features/profile/user_area/user_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileCubit profileCubit = BlocProvider.of<ProfileCubit>(context);

    return BlocBuilder<ProfileCubit, ProfileState>(
      bloc: profileCubit,
      builder: (context, state) {
        if (state is LoadedProfileState) {
          return Column(
            children: [
              UserArea(
                user: state.user,
              )
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
