import 'package:bookstanis/app/features/login/models/value_objects/login/password.dart';
import 'package:bookstanis/app/features/login/models/value_objects/login/username.dart';

class Login {
  Username username;
  Password password;

  Login({required this.username, required this.password});

  Login.empty()
      : username = Username(value: ""),
        password = Password(value: "");

  @override
  String toString() {
    return "${username.value} and ${password.value}";
  }
}
