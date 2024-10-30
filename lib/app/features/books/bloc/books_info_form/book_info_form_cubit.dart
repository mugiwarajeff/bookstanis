import 'dart:io';

import 'package:bookstanis/app/features/books/bloc/books_info_form/book_info_form_state.dart';
import 'package:bookstanis/app/features/books/bloc/books_info_form/interface/book_info_form_actions.dart';
import 'package:bookstanis/app/features/books/models/book.dart';
import 'package:bookstanis/app/features/books/services/interface/books_repository.dart';
import 'package:bookstanis/app/shared/logs/interface/message_logger.dart';
import 'package:bookstanis/app/shared/logs/models/enums/log_message_category.dart';
import 'package:bookstanis/app/shared/logs/models/log_message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookInfoFormCubit extends Cubit<BookInfoFormState>
    implements BookInfoFormActions {
  final BooksRepository _booksRepository;
  final MessageLogger _messageLogger;
  Book _book = Book.empty();

  BookInfoFormCubit(BooksRepository bookRepository, MessageLogger messageLogger)
      : _booksRepository = bookRepository,
        _messageLogger = messageLogger,
        super(InitialBookInfoFormState());

  @override
  Future<void> loadBook(int? bookid) async {
    if (bookid == null) {
      emit(LoadedBookInfoFormState(book: _book));
      return;
    }

    emit(LoadingBookInfoFormState());
    try {
      Book bookFromRepo = await _booksRepository.getBook(bookid);

      _book = bookFromRepo;
      emit(LoadedBookInfoFormState(book: _book));
    } on HttpException catch (e) {
      _messageLogger.logLocalMessage(LogMessage(
          category: LogMessageCategory.error,
          message: e.message,
          source: "Book Cubit",
          timestamp: DateTime.now(),
          userId: "System"));
      emit(ErrorBookInfoFormState(error: e.message));
    }
  }
}
