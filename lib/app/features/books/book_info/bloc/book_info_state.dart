import 'package:bookstanis/app/features/books/models/user_book.dart';

import '../../models/book.dart';

abstract class BookInfoState {}

class InitialBookInfoState extends BookInfoState {}

class LoadingBookInfoState extends BookInfoState {}

class LoadedBookInfoState extends BookInfoState {
  final Book book;
  final UserBook? userBook;

  LoadedBookInfoState({required this.book, required this.userBook});
}

class ErrorBookInfoState extends BookInfoState {
  final String error;

  ErrorBookInfoState({required this.error});
}
