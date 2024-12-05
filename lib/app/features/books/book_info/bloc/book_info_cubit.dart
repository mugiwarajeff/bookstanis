import 'dart:io';

import 'package:bookstanis/app/features/books/book_info/bloc/book_info_state.dart';
import 'package:bookstanis/app/features/books/book_info/bloc/interface/book_info_actions.dart';
import 'package:bookstanis/app/features/books/models/book.dart';
import 'package:bookstanis/app/features/books/models/user_book.dart';
import 'package:bookstanis/app/features/books/services/interface/books_repository.dart';

import 'package:bookstanis/app/shared/logs/interface/message_logger.dart';
import 'package:bookstanis/app/shared/logs/models/enums/log_message_category.dart';
import 'package:bookstanis/app/shared/logs/models/log_message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookInfoCubit extends Cubit<BookInfoState> implements BookInfoActions {
  final BooksRepository _booksRepository;
  final MessageLogger _messageLogger;
  Book _book = Book.empty();
  UserBook? _userBook;
  BookInfoCubit(BooksRepository bookRepository, MessageLogger messageLogger)
      : _booksRepository = bookRepository,
        _messageLogger = messageLogger,
        super(InitialBookInfoState());

  @override
  Future<void> loadBook(int? bookid, {String? userId}) async {
    if (bookid == null) {
      emit(LoadedBookInfoState(book: _book, userBook: _userBook));
      return;
    }

    emit(LoadingBookInfoState());
    try {
      Book bookFromRepo = await _booksRepository.getBook(bookid);

      _book = bookFromRepo;

      if (userId == null) {
        _userBook == null;
      } else {
        UserBook? userBookFromRepo =
            await _booksRepository.getUserBook(_book.id!, userId);

        _userBook = userBookFromRepo;
      }

      emit(LoadedBookInfoState(book: _book, userBook: _userBook));
    } on HttpException catch (e) {
      _messageLogger.logLocalMessage(LogMessage(
          category: LogMessageCategory.error,
          message: e.message,
          source: "Book Cubit",
          timestamp: DateTime.now(),
          userId: "System"));
      emit(ErrorBookInfoState(error: e.message));
    }
  }

  @override
  Future<void> updateBook(Book book) async {
    emit(LoadingBookInfoState());
    try {
      Book bookFromRepo = await _booksRepository.updateBook(book);

      _book = bookFromRepo;
      emit(LoadedBookInfoState(book: _book, userBook: _userBook));
    } on HttpException catch (e) {
      _messageLogger.logLocalMessage(LogMessage(
          category: LogMessageCategory.error,
          message: e.message,
          source: "Book Cubit",
          timestamp: DateTime.now(),
          userId: "System"));
      emit(ErrorBookInfoState(error: e.message));
    }
  }

  @override
  Future<void> addUserBook(String currentUserId) async {
    try {
      UserBook newUserBook =
          UserBook.empty().copyWith(bookId: _book.id, userId: currentUserId);

      UserBook addedUserBook =
          await _booksRepository.insertUserBook(newUserBook);

      _userBook = addedUserBook;

      emit(LoadedBookInfoState(book: _book, userBook: _userBook));
    } on HttpException catch (e) {
      _messageLogger.logLocalMessage(LogMessage(
          category: LogMessageCategory.error,
          message: e.message,
          source: "Book Cubit",
          timestamp: DateTime.now(),
          userId: "System"));
      emit(ErrorBookInfoState(error: e.message));
    }
  }

  @override
  Future<void> removeUserBook() async {
    try {
      if (_userBook == null) {
        return;
      }

      int removeResult =
          await _booksRepository.deleteUserBook(_userBook!.userBookId ?? 0);

      if (removeResult == 1) {
        _userBook = null;
      }

      emit(LoadedBookInfoState(book: _book, userBook: _userBook));
    } on HttpException catch (e) {
      _messageLogger.logLocalMessage(LogMessage(
          category: LogMessageCategory.error,
          message: e.message,
          source: "Book Cubit",
          timestamp: DateTime.now(),
          userId: "System"));
      emit(ErrorBookInfoState(error: e.message));
    }
  }

  @override
  Future<void> updateUserBook(UserBook userBook) async {
    emit(LoadingBookInfoState());
    try {
      UserBook userBookFromRepo =
          await _booksRepository.updateUserBook(userBook);

      _userBook = userBookFromRepo;
      emit(LoadedBookInfoState(book: _book, userBook: _userBook));
    } on HttpException catch (e) {
      _messageLogger.logLocalMessage(LogMessage(
          category: LogMessageCategory.error,
          message: e.message,
          source: "Book Cubit",
          timestamp: DateTime.now(),
          userId: "System"));
      emit(ErrorBookInfoState(error: e.message));
    }
  }
}
