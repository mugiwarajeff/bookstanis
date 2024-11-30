import 'package:bookstanis/app/features/login/bloc/login_state.dart';
import 'package:bookstanis/app/features/login/models/login.dart';
import 'package:bookstanis/app/features/login/models/signup.dart';
import 'package:bookstanis/app/features/login/service/exceptions/auth_exceptions.dart';

import 'package:bookstanis/app/features/login/service/interface/auth_service.dart';
import 'package:bookstanis/app/features/profile/bloc/profile_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthService _authService;

  Login? _login;
  Signup? _signup;

  LoginCubit(AuthService authService, ProfileCubit profileCubit)
      : _authService = authService,
        super(InitialLoginState());

  void loadLoginForm() {
    _login = Login.empty();

    if (_login == null) {
      return;
    }

    emit(StandardLoginState(login: _login!));
  }

  void loadSignUpForm() {
    _signup = Signup.empty();

    if (_signup == null) {
      return;
    }

    emit(SignUpFormState(signup: _signup!));
  }

  Future<void> registerNewUser(AppLocalizations appLocalizations) async {
    if (_signup == null) {
      return;
    }

    try {
      emit(LoadingFormState(loadingMessage: appLocalizations.registeringUser));

      await _authService.registerUser(_signup!);

      emit(SuccessOnRegisterUser());
    } on EmailAlreadyExists catch (e) {
      emit(FailedOnRegisterUser(message: e.message, errorCode: e.code));
    } on WeakPassword catch (e) {
      emit(FailedOnRegisterUser(message: e.message, errorCode: e.code));
    } finally {
      emit(SignUpFormState(signup: _signup!));
    }
  }

  Future<void> signIn(AppLocalizations appLocalizations) async {
    if (_login == null) {
      return;
    }

    try {
      emit(LoadingFormState(loadingMessage: appLocalizations.loggingIn));

      await _authService.loginUser(_login!);

      emit(SuccessFormState(successMessage: appLocalizations.userLogged));
    } on InvalidCredentials catch (e) {
      emit(FailedFormState(errorMesage: e.code));
    } on InvalidEmail catch (e) {
      emit(FailedFormState(errorMesage: e.code));
    } finally {
      emit(StandardLoginState(login: _login!));
    }
  }

  Future<void> signInWithGoogle() async {
    await _authService.loginUserWithGmail();
  }

  Future<void> logoutCurrentUser() async {
    await _authService.logoutUser();
  }

  bool validadePassword() {
    bool valid = false;

    if (_signup!.firstPassword.value == _signup!.secondPassword.value) {
      valid = true;
    }

    return valid;
  }

  void showSuccessMessage() {
    emit(SuccessFormState(successMessage: "Sucesso ao logar conta"));
    emit(StandardLoginState(login: _login!));
  }

  void showFailedMessage() {
    emit(FailedFormState(errorMesage: "Falha ao logar conta"));
    emit(StandardLoginState(login: _login!));
  }
}
