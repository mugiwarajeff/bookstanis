import 'package:bookstanis/app/features/books/models/book.dart';
import 'package:bookstanis/app/features/books/models/user_book.dart';

abstract class BookInfoActions {
  Future<void> loadBook(int? bookid);

  Future<void> updateBook(Book book);

  Future<void> updateUserBook(UserBook userBool);

  Future<void> addUserBook(String currentUserId);

  Future<void> removeUserBook();
}
