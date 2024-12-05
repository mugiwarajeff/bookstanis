import 'package:bookstanis/app/features/books/books_list/bloc/book_cubit.dart';
import 'package:bookstanis/app/features/books/books_list/bloc/book_state.dart';
import 'package:bookstanis/app/features/books/books_list/widgets/books_list.dart';
import 'package:bookstanis/app/features/profile/bloc/profile_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BooksListView extends StatefulWidget {
  const BooksListView({super.key});

  @override
  State<BooksListView> createState() => _BooksListViewState();
}

class _BooksListViewState extends State<BooksListView> {
  late BookCubit bookCubit;
  late ProfileCubit profileCubit;

  @override
  void initState() {
    super.initState();
    bookCubit = BlocProvider.of<BookCubit>(context);
    profileCubit = BlocProvider.of<ProfileCubit>(context);

    bookCubit.loadBooks();
  }

  @override
  Widget build(BuildContext context) {
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
              key: Key(widget.key.toString()),
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
