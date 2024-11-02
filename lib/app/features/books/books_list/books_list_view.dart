import 'package:bookstanis/app/features/books/books_list/bloc/book_cubit.dart';
import 'package:bookstanis/app/features/books/books_list/bloc/book_state.dart';
import 'package:bookstanis/app/features/books/books_list/widgets/books_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BooksListView extends StatelessWidget {
  const BooksListView({super.key});

  @override
  Widget build(BuildContext context) {
    BookCubit bookCubit = BlocProvider.of<BookCubit>(context);

    bookCubit.loadBooks();

    return BlocBuilder<BookCubit, BookState>(
      bloc: bookCubit,
      builder: (context, state) {
        if (state is LoadingBookListState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is ErrorBookState) {
          return Text(state.error);
        }

        if (state is LoadedBookListState) {
          return BooksList(
              books: state.books,
              addingMore: state.adddingMore,
              updateBookCallback: bookCubit.updateBook,
              addMoreCallback: bookCubit.loadMoreBooks);
        }

        return Container();
      },
    );
  }
}
