import 'package:bookstanis/app/features/profile/bloc/profile_states.dart';
import 'package:bookstanis/app/features/profile/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  User? _user;

  ProfileCubit() : super(InitialProfileState());

  void setCurrentUser(User? user) {
    _user = user;
    emit(LoadedProfileState(user: _user));
  }
}
