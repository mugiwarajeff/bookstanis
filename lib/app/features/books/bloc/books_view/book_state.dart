import 'package:bookstanis/app/features/books/models/book.dart';

abstract class BookState {}

class InitialBookState extends BookState {}

class LoadingBookListState extends BookState {}

class LoadedBookListState extends BookState {
  final List<Book> books;
  final bool adddingMore;

  LoadedBookListState({required this.books, required this.adddingMore});
}

class ErrorBookState extends BookState {
  final String error;

  ErrorBookState({required this.error});
}
