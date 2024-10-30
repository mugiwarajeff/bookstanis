import 'package:bookstanis/app/features/books/bloc/books_view/book_cubit.dart';
import 'package:bookstanis/app/features/books/bloc/books_view/book_state.dart';
import 'package:bookstanis/app/features/books/widgets/books_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BooksView extends StatelessWidget {
  const BooksView({super.key});

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
