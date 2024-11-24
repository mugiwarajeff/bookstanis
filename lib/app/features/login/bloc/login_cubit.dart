import 'package:bookstanis/app/features/login/bloc/login_state.dart';
import 'package:bookstanis/app/features/login/models/login.dart';
import 'package:bookstanis/app/features/login/models/signup.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  Login? _login;
  Signup? _signup;

  LoginCubit() : super(InitialLoginState());

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
