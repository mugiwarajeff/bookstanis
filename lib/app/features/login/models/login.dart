class Login {
  String username;
  String password;

  Login({required this.username, required this.password});

  Login.empty()
      : username = "",
        password = "";
}
