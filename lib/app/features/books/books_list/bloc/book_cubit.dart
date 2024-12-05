import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bookstanis/app/features/books/books_list/bloc/book_state.dart';
import 'package:bookstanis/app/features/books/books_list/bloc/interface/book_actions.dart';
import 'package:bookstanis/app/features/books/models/book.dart';
import 'package:bookstanis/app/features/books/services/interface/books_repository.dart';
import 'package:bookstanis/app/shared/logs/interface/message_logger.dart';
import 'package:bookstanis/app/shared/logs/models/enums/log_message_category.dart';
import 'package:bookstanis/app/shared/logs/models/log_message.dart';

class BookCubit extends Cubit<BookState> implements BookActions {
  final BooksRepository _booksRepository;
  final MessageLogger _messageLogger;
  final List<Book> _books = [];
  bool _addingMore = false;
  int _page = 1;

  BookCubit(BooksRepository booksRepository, MessageLogger messageLogger)
      : _booksRepository = booksRepository,
        _messageLogger = messageLogger,
        super(InitialBookState());

  @override
  Future<void> loadBooks() async {
    emit(LoadingBookListState());

    try {
      _page = 1;
      List<Book> booksFromRepo = await _booksRepository.getBooksByPage(_page);

      _books.clear();
      _books.addAll(booksFromRepo);
      _messageLogger.logLocalMessage(LogMessage(
          category: LogMessageCategory.info,
          message: "Lista de books obtidos da pagina $_page",
          source: "Book Cubit",
          timestamp: DateTime.now(),
          userId: "System"));

      emit(LoadedBookListState(books: _books, adddingMore: _addingMore));
    } on HttpException catch (e) {
      _messageLogger.logLocalMessage(LogMessage(
          category: LogMessageCategory.error,
          message: e.message,
          source: "Book Cubit",
          timestamp: DateTime.now(),
          userId: "System"));
      emit(ErrorBookState(error: e.toString()));
    }
  }

  @override
  Future<void> loadMoreBooks() async {
    if (_addingMore) {
      return;
    }

    try {
      _addingMore = true;
      emit(LoadedBookListState(books: _books, adddingMore: _addingMore));
      await Future.delayed(const Duration(seconds: 2));

      _page++;
      List<Book> moreBooksFromRepo =
          await _booksRepository.getBooksByPage(_page);

      _books.addAll(moreBooksFromRepo);
      _addingMore = false;

      emit(LoadedBookListState(books: _books, adddingMore: _addingMore));

      _messageLogger.logLocalMessage(LogMessage(
          category: LogMessageCategory.info,
          message: "Lista de books obtidos da pagina $_page",
          source: "Book Cubit",
          timestamp: DateTime.now(),
          userId: "System"));
    } on HttpException catch (e) {
      _messageLogger.logLocalMessage(LogMessage(
          category: LogMessageCategory.error,
          message: e.message,
          source: "Book Cubit",
          timestamp: DateTime.now(),
          userId: "System"));
      emit(ErrorBookState(error: e.message));
    }
  }

  @override
  Future<void> updateBook(Book book) async {
    try {
      await _booksRepository.updateBook(book);
      _books[_books.indexOf(book)] = book;

      emit(LoadedBookListState(books: _books, adddingMore: _addingMore));

      _messageLogger.logLocalMessage(LogMessage(
          category: LogMessageCategory.info,
          message: "Book ${book.id} atualizado com sucesso",
          source: "Book Cubit",
          timestamp: DateTime.now(),
          userId: "System"));
    } on HttpException catch (e) {
      _messageLogger.logLocalMessage(LogMessage(
          category: LogMessageCategory.error,
          message: e.message,
          source: "Book Cubit",
          timestamp: DateTime.now(),
          userId: "System"));
      emit(ErrorBookState(error: e.message));
    }
  }

  @override
  Future<void> createBook(Book book) async {
    try {
      Book newBook = await _booksRepository.insertBook(book);
      _books.add(newBook);

      _messageLogger.logLocalMessage(LogMessage(
          category: LogMessageCategory.info,
          message: "Book ${book.id} criado com sucesso",
          source: "Book Cubit",
          timestamp: DateTime.now(),
          userId: "System"));
      emit(LoadedBookListState(books: _books, adddingMore: _addingMore));
    } on HttpException catch (e) {
      _messageLogger.logLocalMessage(LogMessage(
          category: LogMessageCategory.error,
          message: e.message,
          source: "Book Cubit",
          timestamp: DateTime.now(),
          userId: "System"));
      emit(ErrorBookState(error: e.message));
    }
  }

  @override
  Future<void> removeBook(Book book) async {
    try {
      int removed = await _booksRepository.deleteBook(book.id ?? 0);

      if (removed == 0) {
        return;
      }

      _books.remove(book);

      _messageLogger.logLocalMessage(LogMessage(
          category: LogMessageCategory.info,
          message: "Book ${book.id} removido com sucesso",
          source: "Book Cubit",
          timestamp: DateTime.now(),
          userId: "System"));
      emit(LoadedBookListState(books: _books, adddingMore: _addingMore));
    } on HttpException catch (e) {
      _messageLogger.logLocalMessage(LogMessage(
          category: LogMessageCategory.error,
          message: e.message,
          source: "Book Cubit",
          timestamp: DateTime.now(),
          userId: "System"));
      emit(ErrorBookState(error: e.message));
    }
  }
}
