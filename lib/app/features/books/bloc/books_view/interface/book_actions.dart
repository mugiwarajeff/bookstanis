import '../../../models/book.dart';

abstract class BookActions {
  Future<void> loadBooks();

  Future<void> loadMoreBooks();

  Future<void> updateBook(Book book);
  Future<void> removeBook(Book book);
  Future<void> createBook(Book book);
}
