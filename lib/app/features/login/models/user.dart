class User {
  String nome;
  String imageUrl;

  User({required this.imageUrl, required this.nome});

  User.toEmpty()
      : imageUrl = "",
        nome = "";
}
