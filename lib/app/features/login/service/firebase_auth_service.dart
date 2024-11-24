import 'package:bookstanis/app/features/login/models/login.dart';
import 'package:bookstanis/app/features/login/models/signup.dart';
import 'package:bookstanis/app/features/login/service/interface/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bookstanis/app/features/profile/models/user.dart' as myUser;

class FirebaseAuthService implements AuthService {
  @override
  Future<void> loginUser(Login login) {
    // TODO: implement loginUser
    throw UnimplementedError();
  }

  @override
  Future<void> loginUserWithGmail() {
    // TODO: implement loginUserWithGmail
    throw UnimplementedError();
  }

  @override
  Future<myUser.User> registerUser(Signup signup) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: signup.email.value, password: signup.firstPassword.value);

    await userCredential.user!.updateDisplayName(
        "${signup.firstName.value}${signup.lastName.value.isNotEmpty ? " " : ""}${signup.lastName.value}");

    print(userCredential.user);

    return myUser.User(
        firstName: signup.firstName.value,
        lastName: signup.lastName.value,
        email: userCredential.user?.email ?? "");
  }

  @override
  Future<void> removeUser() {
    // TODO: implement removeUser
    throw UnimplementedError();
  }

  @override
  Future<void> updateUser() {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
