import 'package:bookstanis/app/features/books/models/book.dart';
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
}
