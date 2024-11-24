import 'package:bookstanis/app/features/login/models/value_objects/login/password.dart';
import 'package:bookstanis/app/features/login/models/value_objects/signup/email.dart';
import 'package:bookstanis/app/features/login/models/value_objects/signup/first_name.dart';
import 'package:bookstanis/app/features/login/models/value_objects/signup/last_name.dart';
import 'package:bookstanis/app/features/login/models/value_objects/signup/phone.dart';
import 'package:bookstanis/app/features/login/models/value_objects/signup/confirm_password.dart';

class Signup {
  FirstName firstName;
  LastName lastName;
  Email email;
  Password firstPassword;
  ConfirmPassword secondPassword;
  Phone phone;

  Signup(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.firstPassword,
      required this.secondPassword,
      required this.phone});

  Signup.empty()
      : email = Email(value: ""),
        firstName = FirstName(value: ""),
        firstPassword = Password(value: ""),
        lastName = LastName(value: ""),
        phone = Phone(value: ""),
        secondPassword = ConfirmPassword(value: "");
}
