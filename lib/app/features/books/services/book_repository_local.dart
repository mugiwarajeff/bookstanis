import 'dart:convert';

import 'package:bookstanis/app/features/books/models/book.dart';
import 'package:bookstanis/app/features/books/models/user_book.dart';
import 'package:bookstanis/app/features/books/services/interface/books_repository.dart';

import 'package:flutter/services.dart';

class BookRepositoryLocal implements BooksRepository {
  final List<Book> _repository = [];
  final List<UserBook> _userBookRepository = [];
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

    if (_repository.length < pageSize) {
      return _repository;
    }

    return _repository.getRange(firstElementPage, lastElementPage).toList();
  }

  @override
  Future<List<Book>> getBooksByPageAndUser(
      int pageNumber, String userId) async {
    List<int> userBooks = _userBookRepository
        .where((userBook) => userBook.userId == userId)
        .map((userBook) => userBook.bookId)
        .toList();

    List<Book> repositoryOfUser = _repository.where((book) {
      return userBooks.contains(book.id);
    }).toList();

    if (repositoryOfUser.isEmpty && pageNumber == 1) {
      return [];
    }

    int firstElementPage = (pageNumber - 1) * pageSize;

    if (firstElementPage >= repositoryOfUser.length) {
      return [];
    }

    int lastElementPage = firstElementPage + pageSize;

// Garantir que o lastElementPage não ultrapasse o tamanho da lista
    lastElementPage = lastElementPage > repositoryOfUser.length
        ? repositoryOfUser.length
        : lastElementPage;

// Verificar se o firstElementPage está dentro do intervalo válido
    if (firstElementPage >= repositoryOfUser.length) {
      return []; // Retorna uma lista vazia se o firstElementPage estiver fora dos limites
    }

    return repositoryOfUser
        .getRange(firstElementPage, lastElementPage)
        .toList();
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

  @override
  Future<UserBook?> getUserBook(int bookId, String userId) async {
    List<UserBook> userBook = _userBookRepository
        .where((userBook) =>
            userBook.bookId == bookId && userBook.userId == userId)
        .toList();

    if (userBook.isEmpty) {
      return null;
    }

    return userBook.first;
  }

  @override
  Future<UserBook> insertUserBook(UserBook userBook) async {
    userBook = userBook.copyWith(userBookId: _userBookRepository.length + 1);
    _userBookRepository.add(userBook);

    return userBook;
  }

  @override
  Future<int> deleteUserBook(int userBookId) async {
    int removedItens = 0;
    _userBookRepository.removeWhere((userBook) {
      bool toRemove = userBook.userBookId == userBookId;

      if (toRemove) {
        removedItens++;
        return true;
      }

      return false;
    });

    return removedItens;
  }

  @override
  Future<UserBook> updateUserBook(UserBook userBook) async {
    int itemIndex = _userBookRepository.indexOf(userBook);

    _userBookRepository[itemIndex == -1 ? 0 : itemIndex] = userBook;

    return userBook;
  }
}
