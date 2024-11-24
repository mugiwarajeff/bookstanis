import 'package:bookstanis/app/features/profile/models/user.dart';

abstract class ProfileState {}

class InitialProfileState extends ProfileState {}

class LoadingProfileState extends ProfileState {}

class LoadedProfileState extends ProfileState {
  User? user;

  LoadedProfileState({required this.user});
}

class ErrorProfileState extends ProfileState {}
