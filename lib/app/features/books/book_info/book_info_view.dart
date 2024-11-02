import 'package:bookstanis/app/features/books/book_info/bloc/book_info_cubit.dart';
import 'package:bookstanis/app/features/books/book_info/bloc/book_info_state.dart';
import 'package:bookstanis/app/features/books/book_info/widget/book_form.dart';
import 'package:bookstanis/app/shared/widgets/friendly_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookInfoView extends StatelessWidget {
  const BookInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    final int? bookid = (ModalRoute.of(context)!.settings.arguments) as int?;

    final BookInfoCubit bookInfoCubit = BlocProvider.of<BookInfoCubit>(context);

    bookInfoCubit.loadBook(bookid);
    return Scaffold(
        appBar: AppBar(
          title: Text(bookid.toString()),
        ),
        body: BlocBuilder<BookInfoCubit, BookInfoState>(
          builder: (context, state) {
            if (state is BookInfoCubit) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is ErrorBookInfoState) {
              return FriendlyMessage(
                  icon: const Icon(Icons.warning), message: state.error);
            }

            if (state is LoadedBookInfoState) {
              return BookForm(book: state.book);
            }

            return const SizedBox.shrink();
          },
        ));
  }
}
