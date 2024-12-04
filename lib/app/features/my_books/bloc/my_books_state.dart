import 'package:bookstanis/app/features/books/models/book.dart';

abstract class MyBooksState {}

class InitialMyBooksState extends MyBooksState {}

class LoadingMyBooksState extends MyBooksState {}

class LoadedMyBooksState extends MyBooksState {
  final List<Book> books;

  LoadedMyBooksState({required this.books});
}

class ErrorMyBooksState extends MyBooksState {
  String error;

  ErrorMyBooksState({required this.error});
}
