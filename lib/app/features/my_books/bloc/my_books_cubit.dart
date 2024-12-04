import 'package:bookstanis/app/features/books/models/book.dart';
import 'package:bookstanis/app/features/books/services/interface/books_repository.dart';
import 'package:bookstanis/app/features/my_books/bloc/my_books_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBooksCubit extends Cubit<MyBooksState> {
  final List<Book> _books = [];
  final BooksRepository _booksRepository;
  MyBooksCubit(this._booksRepository) : super(InitialMyBooksState());

  Future<void> loadUserBooks(String userId) async {}

  Future<void> addBooksToUser() async {}

  Future<void> removeBookFromUser() async {}
}
