import 'package:bookstanis/app/features/books/models/book.dart';

abstract class UserBookListState {}

class InitialUserBookListState extends UserBookListState {}

class LoadingUserBookListState extends UserBookListState {}

class LoadedUserBookListState extends UserBookListState {
  final List<Book> books;
  final bool adddingMore;

  LoadedUserBookListState({required this.books, required this.adddingMore});
}

class ErrorUserBookListState extends UserBookListState {
  final String error;

  ErrorUserBookListState({required this.error});
}
