import 'package:bookstanis/app/features/books/models/enums/book_status.dart';

class UserBook {
  final int? userBookId;
  final int bookId;
  final String userId;
  final double rating;
  final String notes;
  final int readedPages;
  final BookStatus status;

  UserBook(
      {required this.userBookId,
      required this.bookId,
      required this.userId,
      required this.notes,
      required this.rating,
      required this.readedPages,
      required this.status});

  UserBook.empty()
      : userBookId = null,
        bookId = 0,
        userId = "",
        rating = 0,
        readedPages = 0,
        notes = "",
        status = BookStatus.waiting;

  UserBook copyWith({
    int? userBookId,
    int? bookId,
    String? userId,
    double? rating,
    String? notes,
    int? readedPages,
    BookStatus? status,
  }) {
    return UserBook(
      userBookId: userBookId ?? this.userBookId,
      bookId: bookId ?? this.bookId,
      userId: userId ?? this.userId,
      rating: rating ?? this.rating,
      notes: notes ?? this.notes,
      readedPages: readedPages ?? this.readedPages,
      status: status ?? this.status,
    );
  }

  // Método para converter um objeto UserBook em um Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'user_book_id': userBookId,
      'book_id': bookId,
      'user_id': userId,
      'rating': rating,
      'notes': notes,
      'readed_pages': readedPages,
      'status': status.toString().split('.').last, // Converte enum para String
    };
  }

  // Método para criar um objeto UserBook a partir de um Map (JSON)
  factory UserBook.fromJson(Map<String, dynamic> json) {
    return UserBook(
      userBookId: json['user_book_id'],
      bookId: json['book_id'],
      userId: json['user_id'],
      rating: double.tryParse(json['rating']) ?? 0,
      notes: json['notes'] ?? '',
      readedPages: json['readed_pages'],
      status: BookStatus.values.firstWhere(
          (e) => e.toString().split('.').last == json['status'],
          orElse: () => BookStatus.waiting),
    );
  }
}
