import 'package:bookstanis/app/features/books/book_info/bloc/book_info_cubit.dart';
import 'package:bookstanis/app/features/books/book_info/bloc/book_info_state.dart';

import 'package:bookstanis/app/features/books/books_list/widgets/books_list/start_rating.dart';
import 'package:bookstanis/app/shared/widgets/friendly_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookInfoView extends StatelessWidget {
  const BookInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    final int? bookid = (ModalRoute.of(context)!.settings.arguments) as int?;

    final BookInfoCubit bookInfoCubit = BlocProvider.of<BookInfoCubit>(context);
    final Color onSurface = Theme.of(context).colorScheme.onSurface;
    final Color onPrimary = Theme.of(context).colorScheme.onPrimary;
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final Color tertiaryColor = Theme.of(context).colorScheme.tertiary;

    const double iconButtonSize = 32;
    bookInfoCubit.loadBook(bookid);
    return Scaffold(
        appBar: AppBar(),
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
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 300,
                      width: 300,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              state.book.coverUrl,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Builder(builder: (context) {
                                  if (state.book.isFavorite) {
                                    return IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.favorite,
                                          color: primaryColor,
                                          size: iconButtonSize,
                                        ));
                                  }
                                  return IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.favorite_border,
                                        color: Colors.grey,
                                        size: iconButtonSize,
                                      ));
                                }),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.add_comment,
                                      size: iconButtonSize,
                                      color: tertiaryColor,
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(
                      state.book.name,
                      style: TextStyle(fontSize: 24, color: onSurface),
                    ),
                    Text(
                      state.book.author,
                      style: TextStyle(fontSize: 14, color: onSurface),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        height: 30,
                        width: 80,
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                          child: Text(
                            state.book.category,
                            style: TextStyle(color: onPrimary),
                          ),
                        )),
                    StartRating(
                        fillColor: primaryColor,
                        ratingValue: state.book.rating,
                        onTapStart: (value) {}),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 100,
                      child: Card(
                        child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                child: Text(
                                  state.book.description,
                                ),
                              ),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      state.book.bookStatus.name,
                      style: const TextStyle(fontSize: 18),
                    ),
                    Card(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 24),
                          child: Text(
                            "${state.book.readedPages}/${state.book.quantPages}",
                            style: const TextStyle(fontSize: 18),
                          )),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ));
  }
}
