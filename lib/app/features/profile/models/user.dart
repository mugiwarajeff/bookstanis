class User {
  final String firstName;
  final String lastName;
  final String email;
  final String? imageUrl;




  User({ this.imageUrl, required this.firstName, required this.lastName, required this.email});

  User.toEmpty()
      : imageUrl = null,
        firstName = "",
        lastName = "",
        email = "";

  User copyWith({String? firstName, String? lastName, String? imageUrl, String? email}) {
    return User(
        imageUrl: imageUrl ?? this.imageUrl,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email);
  }
}
