import '../../models/book.dart';

abstract class BookInfoFormState {}

class InitialBookInfoFormState extends BookInfoFormState {}

class LoadingBookInfoFormState extends BookInfoFormState {}

class LoadedBookInfoFormState extends BookInfoFormState {
  final Book book;

  LoadedBookInfoFormState({required this.book});
}

class ErrorBookInfoFormState extends BookInfoFormState {
  final String error;

  ErrorBookInfoFormState({required this.error});
}
