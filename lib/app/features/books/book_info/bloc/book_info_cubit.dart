import 'dart:io';

import 'package:bookstanis/app/features/books/book_info/bloc/book_info_state.dart';
import 'package:bookstanis/app/features/books/book_info/bloc/interface/book_info_actions.dart';
import 'package:bookstanis/app/features/books/models/book.dart';
import 'package:bookstanis/app/features/books/services/interface/books_repository.dart';
import 'package:bookstanis/app/shared/logs/interface/message_logger.dart';
import 'package:bookstanis/app/shared/logs/models/enums/log_message_category.dart';
import 'package:bookstanis/app/shared/logs/models/log_message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookInfoCubit extends Cubit<BookInfoState> implements BookInfoActions {
  final BooksRepository _booksRepository;
  final MessageLogger _messageLogger;
  Book _book = Book.empty();

  BookInfoCubit(BooksRepository bookRepository, MessageLogger messageLogger)
      : _booksRepository = bookRepository,
        _messageLogger = messageLogger,
        super(InitialBookInfoState());

  @override
  Future<void> loadBook(int? bookid) async {
    if (bookid == null) {
      emit(LoadedBookInfoState(book: _book));
      return;
    }

    emit(LoadingBookInfoState());
    try {
      Book bookFromRepo = await _booksRepository.getBook(bookid);

      _book = bookFromRepo;
      emit(LoadedBookInfoState(book: _book));
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
