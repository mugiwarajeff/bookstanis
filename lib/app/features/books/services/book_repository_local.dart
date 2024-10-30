import 'dart:convert';

import 'package:bookstanis/app/features/books/models/book.dart';
import 'package:bookstanis/app/features/books/services/interface/books_repository.dart';
import 'package:flutter/services.dart';

class BookRepositoryLocal implements BooksRepository {
  final List<Book> _repository = [];
  final int pageSize = 6;

  Future<void> loadRepository() async {
    String jsonString =
        await rootBundle.loadString("lib/app/features/books/data/books.json");
    List<dynamic> booksJson = jsonDecode(jsonString)["books"];
    List<Book> books = booksJson.map((json) => Book.fromJson(json)).toList();

    _repository.addAll(books);
  }

  @override
  Future<List<Book>> getAll() async {
    return _repository;
  }

  @override
  Future<List<Book>> getBooksByPage(int pageNumber) async {
    int firstElementPage = (pageNumber - 1) * pageSize;

    if (firstElementPage > _repository.length) {
      return [];
    }

    int lastElementPage = (firstElementPage + pageSize);

    lastElementPage = lastElementPage > _repository.length
        ? firstElementPage + lastElementPage - _repository.length
        : lastElementPage;

    return _repository.getRange(firstElementPage, lastElementPage).toList();
  }

  @override
  Future<int> deleteBook(int bookId) async {
    int quantDeletes = 0;
    _repository.removeWhere(
      (element) {
        bool toRemove = element.id == bookId;
        if (toRemove) {
          quantDeletes++;
        }
        return toRemove;
      },
    );

    return quantDeletes;
  }

  @override
  Future<Book> insertBook(Book book) async {
    int newId = _repository.length + 1;

    book.id = newId;

    _repository.add(book);

    return book;
  }

  @override
  Future<Book> updateBook(Book book) async {
    _repository[_repository.indexOf(book)] = book;

    return book;
  }

  @override
  Future<Book> getBook(int bookId) async {
    return _repository.where((book) => book.id == bookId).first;
  }
}
