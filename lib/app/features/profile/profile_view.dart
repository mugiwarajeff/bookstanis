import 'package:bookstanis/app/features/login/bloc/login_cubit.dart';
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
    final LoginCubit loginCubit = BlocProvider.of<LoginCubit>(context);

    return BlocBuilder<ProfileCubit, ProfileState>(
      bloc: profileCubit,
      builder: (context, state) {
        if (state is LoadedProfileState) {
          return Column(
            children: [
              UserArea(
                user: state.user,
              ),
              Visibility(
                  visible: state.user != null,
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            loginCubit.logoutCurrentUser();
                          },
                          child: const Text("Sair")),
                    ),
                  ))
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
