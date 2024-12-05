import 'dart:io';

import 'package:bloc/bloc.dart';

import 'package:bookstanis/app/features/books/models/book.dart';
import 'package:bookstanis/app/features/books/services/interface/books_repository.dart';
import 'package:bookstanis/app/features/books/user_book_list/bloc/interface/user_book_list_actions.dart';
import 'package:bookstanis/app/features/books/user_book_list/bloc/user_book_list_state.dart';
import 'package:bookstanis/app/shared/logs/interface/message_logger.dart';
import 'package:bookstanis/app/shared/logs/models/enums/log_message_category.dart';
import 'package:bookstanis/app/shared/logs/models/log_message.dart';

class UserBookListCubit extends Cubit<UserBookListState>
    implements UserBookListActions {
  final BooksRepository _booksRepository;
  final MessageLogger _messageLogger;
  final List<Book> _books = [];
  bool _addingMore = false;
  int _page = 1;

  UserBookListCubit(
      BooksRepository booksRepository, MessageLogger messageLogger)
      : _booksRepository = booksRepository,
        _messageLogger = messageLogger,
        super(InitialUserBookListState());

  @override
  Future<void> loadBookFromUser(String userId) async {
    emit(LoadingUserBookListState());

    try {
      _page = 1;
      List<Book> booksFromRepo =
          await _booksRepository.getBooksByPageAndUser(_page, userId);

      _books.clear();
      _books.addAll(booksFromRepo);
      _messageLogger.logLocalMessage(LogMessage(
          category: LogMessageCategory.info,
          message: "Lista de books obtidos da pagina $_page",
          source: "Book Cubit",
          timestamp: DateTime.now(),
          userId: "System"));

      emit(LoadedUserBookListState(books: _books, adddingMore: _addingMore));
    } on HttpException catch (e) {
      _messageLogger.logLocalMessage(LogMessage(
          category: LogMessageCategory.error,
          message: e.message,
          source: "Book Cubit",
          timestamp: DateTime.now(),
          userId: "System"));
      emit(ErrorUserBookListState(error: e.toString()));
    }
  }

  @override
  Future<void> loadMoreBooksFromUser(String userId) async {
    if (_addingMore) {
      return;
    }

    try {
      _addingMore = true;
      emit(LoadedUserBookListState(books: _books, adddingMore: _addingMore));
      await Future.delayed(const Duration(seconds: 2));

      _page++;
      List<Book> moreBooksFromRepo =
          await _booksRepository.getBooksByPageAndUser(_page, userId);

      _books.addAll(moreBooksFromRepo);
      _addingMore = false;

      emit(LoadedUserBookListState(books: _books, adddingMore: _addingMore));

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
      emit(ErrorUserBookListState(error: e.message));
    }
  }
}
