import 'dart:io';

import 'package:bookstanis/app/features/books/models/book.dart';
import 'package:bookstanis/app/features/books/models/user_book.dart';
import 'package:bookstanis/app/features/books/services/interface/books_repository.dart';
import 'package:dio/dio.dart';

class BookRepositoryDio implements BooksRepository {
  final Dio dio = Dio();

  final String hostIp = "192.168.0.100";

  @override
  Future<List<Book>> getAll() async {
    Response response = await dio.getUri(Uri.http("$hostIp:5001", "/books"));

    if (response.statusCode != 200) {
      throw HttpException("Error: ${response.statusCode}");
    }
    List<dynamic> responseJson = response.data;

    List<Book> books =
        responseJson.map((bookJson) => Book.fromJson(bookJson)).toList();

    return books;
  }

  @override
  Future<List<Book>> getBooksByPage(int pageNumber) async {
    Response response = await dio.getUri(Uri.http(
      "$hostIp:5001",
      "/books/page/$pageNumber",
    ));

    if (response.statusCode != 200) {
      throw HttpException("Error: ${response.statusCode}");
    }
    List<dynamic> responseJson = response.data;

    List<Book> books =
        responseJson.map((bookJson) => Book.fromJson(bookJson)).toList();

    return books;
  }

  @override
  Future<Book> getBook(int bookId) async {
    Response response = await dio.getUri(Uri.http(
      "$hostIp:5001",
      "/books/$bookId",
    ));

    if (response.statusCode != 200) {
      throw HttpException("Error: ${response.statusCode}");
    }
    Book book = Book.fromJson(response.data);

    return book;
  }

  @override
  Future<Book> insertBook(Book book) async {
    Uri uri = Uri.http("$hostIp:5001", "/books");

    Response response = await dio.postUri(uri, data: book.toJson());

    if (response.statusCode == 201 || response.statusCode == 200) {
      return book;
    }

    throw HttpException("Error: ${response.statusCode}");
  }

  @override
  Future<int> deleteBook(int bookId) async {
    Uri uri = Uri.http("$hostIp:5001", "/books/$bookId");

    Response response = await dio.deleteUri(uri);

    if (response.statusCode == 200) {
      return 1;
    }

    return 0;
  }

  @override
  Future<Book> updateBook(Book book) async {
    Uri uri = Uri.http("$hostIp:5001", "/books/${book.id}");

    Response response = await dio.putUri(uri, data: book.toJson());

    if (response.statusCode == 201 || response.statusCode == 200) {
      return book;
    }

    throw HttpException("Error: ${response.statusCode}");
  }

  @override
  Future<List<Book>> getBooksByPageAndUser(
      int pageNumber, String userId) async {
    Response response = await dio.getUri(Uri.http(
      "$hostIp:5001",
      "/books/$userId/$pageNumber",
    ));

    if (response.statusCode != 200) {
      throw HttpException("Error: ${response.statusCode}");
    }
    List<dynamic> responseJson = response.data;

    print(response.data);

    List<Book> books =
        responseJson.map((bookJson) => Book.fromJson(bookJson)).toList();

    return books;
  }

  @override
  Future<UserBook> insertUserBook(UserBook userBook) async {
    Uri uri = Uri.http("$hostIp:5002", "/user_books");

    Response response = await dio.postUri(uri, data: userBook.toJson());

    if (response.statusCode == 201 || response.statusCode == 200) {
      print(response.data);
      print(response.data["user_book_id"]);
      return userBook.copyWith(userBookId: response.data["user_book_id"]);
    }

    throw HttpException("Error: ${response.statusCode}");
  }

  @override
  Future<int> deleteUserBook(int userBookId) async {
    Uri uri = Uri.http("$hostIp:5002", "/user_books/$userBookId");

    Response response = await dio.deleteUri(uri);

    if (response.statusCode == 200) {
      return 1;
    }

    return 0;
  }

  @override
  Future<UserBook?> getUserBook(int bookId, String userId) async {
    Response response = await dio.getUri(
        Uri.http(
          "$hostIp:5002",
          "/user_books/$bookId/$userId",
        ), options: Options(
      validateStatus: (status) {
        return status !=
            null; // Permite qualquer código de status, sem lançar exceção
      },
    ));

    if (response.statusCode == 404) {
      return null;
    }

    if (response.statusCode != 200) {
      throw HttpException("Error: ${response.statusCode}");
    }

    UserBook userBook = UserBook.fromJson(response.data);

    return userBook;
  }

  @override
  Future<UserBook> updateUserBook(UserBook userBook) async {
    Uri uri = Uri.http("$hostIp:5002", "/user_books/${userBook.userBookId}");

    Response response = await dio.putUri(uri, data: userBook.toJson());

    if (response.statusCode == 201 || response.statusCode == 200) {
      return userBook;
    }

    throw HttpException("Error: ${response.statusCode}");
  }
}
