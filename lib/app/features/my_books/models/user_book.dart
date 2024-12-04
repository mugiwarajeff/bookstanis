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
}
