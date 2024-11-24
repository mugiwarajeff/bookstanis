import 'package:bookstanis/app/features/login/models/login.dart';
import 'package:bookstanis/app/features/login/models/signup.dart';
import 'package:bookstanis/app/features/profile/models/user.dart';

abstract class AuthService {
  Future<User> registerUser(Signup signup);

  Future<void> loginUser(Login login);

  Future<void> loginUserWithGmail();

  Future<void> removeUser();

  Future<void> updateUser();
}
