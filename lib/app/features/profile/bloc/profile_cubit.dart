import 'package:bookstanis/app/features/login/service/interface/auth_service.dart';
import 'package:bookstanis/app/features/profile/bloc/profile_states.dart';
import 'package:bookstanis/app/features/profile/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AuthService _authService;
  User? _user;

  ProfileCubit(AuthService authService)
      : _authService = authService,
        super(InitialProfileState()) {
    initialize();
  }

  void initialize() {
    emit(LoadingProfileState());
    _authService.listenStateChange(setCurrentUser);
    _authService.listenUserChange(setCurrentUser);
  }

  void setCurrentUser(User? user) {
    _user = user;
    emit(LoadedProfileState(user: _user));
  }
}
