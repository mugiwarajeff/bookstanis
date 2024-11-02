import 'package:bookstanis/app/features/books/models/book.dart';

abstract class BooksRepository {
  Future<List<Book>> getAll();

  Future<Book> getBook(int bookId);

  Future<List<Book>> getBooksByPage(int pageNumber);

  Future<Book> insertBook(Book book);

  Future<int> deleteBook(int bookId);

  Future<Book> updateBook(Book book);
}
