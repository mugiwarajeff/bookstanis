import 'package:bookstanis/app/features/books/models/book.dart';
import 'package:bookstanis/app/features/books/models/user_book.dart';
import 'package:bookstanis/app/features/books/services/book_repository_dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should get a all books from backend", () async {
    BookRepositoryDio bookRepositoryDio = BookRepositoryDio();

    List<Book> books = await bookRepositoryDio.getAll();

    print(books);
  });

  test("should get books from backend by page", () async {
    BookRepositoryDio bookRepositoryDio = BookRepositoryDio();

    List<Book> books = await bookRepositoryDio.getBooksByPage(1);

    // ignore: unused_local_variable
    for (var book in books) {
      print(books);
    }
  });

  test("should get books from backend by page and user", () async {
    BookRepositoryDio bookRepositoryDio = BookRepositoryDio();

    //await bookRepositoryDio  .insertUserBook(UserBook.empty().copyWith(userId: "jeff", bookId: 1));

    UserBook? userBook = await bookRepositoryDio.getUserBook(1, "jeff");

    print(userBook);

    List<Book> books = await bookRepositoryDio.getBooksByPageAndUser(1, "jeff");
    // ignore: unused_local_variable
    for (var book in books) {
      print(books);
    }
  });

  test("should get book by bookod", () async {
    BookRepositoryDio bookRepositoryDio = BookRepositoryDio();

    Book book = await bookRepositoryDio.getBook(1);

    print(book);
  });
}
