class User {
  final String name;
  final String email;
  final String imageUrl;

  User({required this.imageUrl, required this.name, required this.email});

  User.toEmpty()
      : imageUrl = "",
        name = "",
        email = "";

  User copyWith({String? name, String? imageUrl, String? email}) {
    return User(
        imageUrl: imageUrl ?? this.imageUrl,
        name: name ?? this.imageUrl,
        email: email ?? this.email);
  }
}
