import 'package:bookstanis/app/features/books/models/book.dart';
import 'package:bookstanis/app/features/books/models/user_book.dart';
import 'package:bookstanis/app/features/books/services/interface/books_repository.dart';

class BookRepositoryDio implements BooksRepository {
  @override
  Future<int> deleteBook(int bookId) {
    // TODO: implement deleteBook
    throw UnimplementedError();
  }

  @override
  Future<List<Book>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<Book> insertBook(Book book) {
    // TODO: implement insertBook
    throw UnimplementedError();
  }

  @override
  Future<Book> updateBook(Book book) {
    // TODO: implement updateBook
    throw UnimplementedError();
  }

  @override
  Future<List<Book>> getBooksByPage(int pageNumber) {
    // TODO: implement getBooksByPage
    throw UnimplementedError();
  }

  @override
  Future<Book> getBook(int bookId) {
    // TODO: implement getBook
    throw UnimplementedError();
  }

  @override
  Future<UserBook> insertUserBook(UserBook userBook) {
    // TODO: implement insertUserBook
    throw UnimplementedError();
  }

  @override
  Future<int> deleteUserBook(int userBookId) {
    // TODO: implement deleteUserBook
    throw UnimplementedError();
  }

  @override
  Future<List<Book>> getBooksByPageAndUser(int pageNumber, String userId) {
    // TODO: implement getBooksByPageAndUser
    throw UnimplementedError();
  }

  @override
  Future<UserBook?> getUserBook(int bookId, String userId) {
    // TODO: implement getUserBook
    throw UnimplementedError();
  }

  @override
  Future<UserBook> updateUserBook(UserBook userBook) {
    // TODO: implement updateUserBook
    throw UnimplementedError();
  }
}
