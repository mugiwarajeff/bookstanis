import 'package:bookstanis/app/features/login/models/login.dart';
import 'package:bookstanis/app/features/login/models/signup.dart';
import 'package:bookstanis/app/features/login/service/exceptions/auth_exceptions.dart';

import 'package:bookstanis/app/features/login/service/interface/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bookstanis/app/features/profile/models/user.dart' as myUser;
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService implements AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Future<void> loginUser(Login login) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: login.username.value, password: login.password.value);
    } on FirebaseAuthException catch (e) {
      _handleLoginErros(e.code, e.message ?? "");
    }
  }

  @override
  Future<void> loginUserWithGmail() async {
    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      _handleLoginErros(e.code, e.message ?? "");
    }
  }

  void _handleLoginErros(String code, String message) {
    if (code == "invalid-email") {
      throw InvalidEmail(message, code);
    }

    if (code == "invalid-credential") {
      throw InvalidCredentials(message, code);
    }
    if (code == "account-exists-with-different-credential") {
      throw AccountExistsWithDifferentCredential(message, code);
    }

    if (code == "invalid-credential") {
      throw InvalidCredentials(message, code);
    }

    if (code == "operation-not-allowed") {
      throw OperationNotAllowed(message, code);
    }

    if (code == "user-disabled") {
      throw UserDisabled(message, code);
    }

    if (code == "user-not-found") {
      throw UserNotFound(message, code);
    }

    if (code == "wrong-password") {
      throw WrongPassword(message, code);
    }

    if (code == "invalid-verification-code") {
      throw InvalidVerificationCode(message, code);
    }

    if (code == "invalid-verification-id") {
      throw InvalidVerificationId(message, code);
    }
  }

  @override
  Future<void> registerUser(Signup signup) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: signup.email.value, password: signup.firstPassword.value);

      await userCredential.user!.updateDisplayName(
          "${signup.firstName.value}${signup.lastName.value.isNotEmpty ? " " : ""}${signup.lastName.value}");
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        throw EmailAlreadyExists(e.message ?? "", e.code);
      }
      if (e.code == "weak-password") {
        throw WeakPassword(e.message ?? "", e.code);
      }
    }
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

  @override
  Future<void> logoutUser() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> listenStateChange(
      void Function(myUser.User? user) setUserCallback) async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      print("mudou");
      if (user == null) {
        setUserCallback(null);
        return;
      }

      setUserCallback(_handleCreationOfUser(user));
    });
  }

  @override
  Future<void> listenUserChange(
      void Function(myUser.User? user) setUserCallback) async {
    FirebaseAuth.instance.userChanges().listen((User? user) {
      print("mudou");
      if (user == null) {
        setUserCallback(null);
        return;
      }

      setUserCallback(_handleCreationOfUser(user));
    });
  }

  myUser.User _handleCreationOfUser(User user) {
    String? firstName;
    String? lastName;

    if (user.displayName == null) {
      return myUser.User(
        firstName: "",
        lastName: "",
        email: user.email!,
      );
    }

    List<String> splitedName = user.displayName!.split(" ");
    if (splitedName.length == 1) {
      firstName = splitedName[0];
    }

    if (splitedName.length > 1) {
      firstName = splitedName[0];
      lastName = splitedName[1];
    }

    return myUser.User(
      firstName: firstName ?? "",
      lastName: lastName ?? "",
      email: user.email!,
    );
  }
}
