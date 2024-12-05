import 'package:bookstanis/app/features/books/models/book.dart';
import 'package:bookstanis/app/features/books/models/user_book.dart';

abstract class BooksRepository {
  Future<List<Book>> getAll();

  Future<Book> getBook(int bookId);

  Future<UserBook?> getUserBook(int bookId, String userId);

  Future<List<Book>> getBooksByPage(int pageNumber);

  Future<List<Book>> getBooksByPageAndUser(int pageNumber, String userId);

  Future<UserBook> insertUserBook(UserBook userBook);

  Future<Book> insertBook(Book book);

  Future<int> deleteBook(int bookId);

  Future<int> deleteUserBook(int userBookId);

  Future<Book> updateBook(Book book);

  Future<UserBook> updateUserBook(UserBook userBook);
}
