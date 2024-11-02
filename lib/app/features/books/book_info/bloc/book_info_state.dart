import '../../models/book.dart';

abstract class BookInfoState {}

class InitialBookInfoState extends BookInfoState {}

class LoadingBookInfoState extends BookInfoState {}

class LoadedBookInfoState extends BookInfoState {
  final Book book;

  LoadedBookInfoState({required this.book});
}

class ErrorBookInfoState extends BookInfoState {
  final String error;

  ErrorBookInfoState({required this.error});
}
