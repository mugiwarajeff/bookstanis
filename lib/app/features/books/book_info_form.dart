import 'package:bookstanis/app/features/books/bloc/books_info_form/book_info_form_cubit.dart';
import 'package:bookstanis/app/features/books/bloc/books_info_form/book_info_form_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookInfoForm extends StatelessWidget {
  const BookInfoForm({super.key});

  @override
  Widget build(BuildContext context) {
    final int? bookid = (ModalRoute.of(context)!.settings.arguments) as int?;

    final BookInfoFormCubit bookInfoFormCubit =
        BlocProvider.of<BookInfoFormCubit>(context);

    bookInfoFormCubit.loadBook(bookid);
    return Scaffold(
        appBar: AppBar(
          title: Text(bookid.toString()),
        ),
        body: BlocBuilder<BookInfoFormCubit, BookInfoFormState>(
          builder: (context, state) {
            if (state is LoadingBookInfoFormState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is ErrorBookInfoFormState) {
              return Text(state.error);
            }

            if (state is LoadedBookInfoFormState) {
              return Text("book: $bookid");
            }

            return const SizedBox.shrink();
          },
        ));
  }
}
