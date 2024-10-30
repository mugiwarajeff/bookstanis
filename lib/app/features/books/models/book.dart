import 'package:bookstanis/app/features/books/models/enums/book_status.dart';

class Book {
  int? id;
  String name;
  String description;
  String category;
  String author;
  int quantPages;
  int readedPages;
  BookStatus bookStatus;
  bool isFavorite;
  double rating;
  String notes;
  String coverUrl;

  Book(
      {required this.id,
      required this.bookStatus,
      required this.category,
      required this.description,
      required this.isFavorite,
      required this.name,
      required this.rating,
      required this.quantPages,
      required this.readedPages,
      required this.author,
      required this.notes,
      required this.coverUrl});

  Book.empty()
      : id = null,
        bookStatus = BookStatus.waiting,
        category = "",
        name = "",
        description = "",
        isFavorite = false,
        rating = 0,
        quantPages = 0,
        readedPages = 0,
        author = "",
        notes = "",
        coverUrl = "";

  Book.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        description = json["description"],
        category = json["category"],
        bookStatus = BookStatus.values.byName(json["book_status"]),
        isFavorite = json["is_favorite"],
        rating = json["rating"],
        quantPages = json["quant_pages"],
        readedPages = json["readed_pages"],
        author = json["author"],
        notes = json["notes"],
        coverUrl = json["cover_url"];

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "category": category,
        "book_status": bookStatus.name,
        "is_favorite": isFavorite,
        "rating": rating,
        "quant_pages": quantPages,
        "readed_pages": readedPages,
        "author": author,
        "notes": notes,
        "cover_url": coverUrl
      };
}
