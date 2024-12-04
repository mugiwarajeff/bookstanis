class Book {
  int? id;
  String name;
  String description;
  String category;
  String author;
  int quantPages;
  bool isFavorite;
  double rating;
  String coverUrl;

  Book(
      {required this.id,
      required this.category,
      required this.description,
      required this.isFavorite,
      required this.name,
      required this.rating,
      required this.quantPages,
      required this.author,
      required this.coverUrl});

  Book.empty()
      : id = null,
        category = "",
        name = "",
        description = "",
        isFavorite = false,
        rating = 0,
        quantPages = 0,
        author = "",
        coverUrl = "";

  Book.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        description = json["description"],
        category = json["category"],
        isFavorite = json["is_favorite"],
        rating = json["rating"],
        quantPages = json["quant_pages"],
        author = json["author"],
        coverUrl = json["cover_url"];

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "category": category,
        "is_favorite": isFavorite,
        "rating": rating,
        "quant_pages": quantPages,
        "author": author,
        "cover_url": coverUrl
      };
}
