import 'package:bookstanis/app/features/books/books_list/widgets/books_list.dart';
import 'package:bookstanis/app/features/books/user_book_list/bloc/user_book_list_cubit.dart';
import 'package:bookstanis/app/features/books/user_book_list/bloc/user_book_list_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBookListView extends StatefulWidget {
  final String userId;
  const UserBookListView({super.key, required this.userId});

  @override
  State<UserBookListView> createState() => _UserBookListViewState();
}

class _UserBookListViewState extends State<UserBookListView> {
  late UserBookListCubit bookCubit;

  @override
  void initState() {
    super.initState();
    bookCubit = BlocProvider.of<UserBookListCubit>(context);

    bookCubit.loadBookFromUser(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBookListCubit, UserBookListState>(
      bloc: bookCubit,
      builder: (context, state) {
        if (state is LoadingUserBookListState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is ErrorUserBookListState) {
          return Text(state.error);
        }

        if (state is LoadedUserBookListState) {
          return BooksList(
              key: Key(widget.key.toString()),
              books: state.books,
              addingMore: state.adddingMore,
              updateBookCallback: (_) async {},
              addMoreCallback: () =>
                  bookCubit.loadMoreBooksFromUser(widget.userId));
        }

        return Container();
      },
    );
  }
}
