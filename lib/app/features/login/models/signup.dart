class Signup {
  String firstName;
  String lastName;
  String email;
  String firstPassword;
  String secondPassword;
  String phone;

  Signup(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.firstPassword,
      required this.secondPassword,
      required this.phone});

  Signup.empty()
      : email = "",
        firstName = "",
        firstPassword = "",
        lastName = "",
        phone = "",
        secondPassword = "";
}
