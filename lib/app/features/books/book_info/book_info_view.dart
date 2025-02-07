import 'package:bookstanis/app/features/books/book_info/bloc/book_info_cubit.dart';
import 'package:bookstanis/app/features/books/book_info/bloc/book_info_state.dart';

import 'package:bookstanis/app/features/books/books_list/widgets/books_list/start_rating.dart';
import 'package:bookstanis/app/features/books/models/enums/book_status.dart';
import 'package:bookstanis/app/features/profile/bloc/profile_cubit.dart';
import 'package:bookstanis/app/features/profile/bloc/profile_states.dart';
import 'package:bookstanis/app/shared/widgets/friendly_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookInfoView extends StatefulWidget {
  const BookInfoView({super.key});

  @override
  State<BookInfoView> createState() => _BookInfoViewState();
}

class _BookInfoViewState extends State<BookInfoView> {
  late ProfileCubit profileCubit;

  @override
  void initState() {
    super.initState();
    profileCubit = BlocProvider.of<ProfileCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    final int? bookid = (ModalRoute.of(context)!.settings.arguments) as int?;

    final BookInfoCubit bookInfoCubit = BlocProvider.of<BookInfoCubit>(context);

    final Color onSurface = Theme.of(context).colorScheme.onSurface;
    final Color onPrimary = Theme.of(context).colorScheme.onPrimary;
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final Color tertiaryColor = Theme.of(context).colorScheme.tertiary;

    const double iconButtonSize = 32;
    bookInfoCubit.loadBook(bookid,
        userId: profileCubit.state is LoadedProfileState
            ? (profileCubit.state as LoadedProfileState).user?.email
            : null);

    String translateValue(BookStatus bookStatus) {
      switch (bookStatus) {
        case BookStatus.waiting:
          return "Esperando";
        case BookStatus.reading:
          return "Em Leitura";
        case BookStatus.completed:
          return "Completo";
      }
    }

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
                    SizedBox(
                      height: 300,
                      width: 300,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Image.network(
                              state.book.coverUrl,
                            ),
                          ),
                          BlocBuilder<ProfileCubit, ProfileState>(
                            bloc: profileCubit,
                            builder: (context, stateProfile) {
                              if (stateProfile is LoadedProfileState &&
                                  stateProfile.user != null) {
                                return Align(
                                  alignment: Alignment.centerRight,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Builder(builder: (context) {
                                        if (state.book.isFavorite) {
                                          return IconButton(
                                              onPressed: () {
                                                state.book.isFavorite = false;
                                                bookInfoCubit
                                                    .updateBook(state.book);
                                              },
                                              icon: Icon(
                                                Icons.favorite,
                                                color: primaryColor,
                                                size: iconButtonSize,
                                              ));
                                        }
                                        return IconButton(
                                            onPressed: () {
                                              state.book.isFavorite = true;
                                              bookInfoCubit
                                                  .updateBook(state.book);
                                            },
                                            icon: const Icon(
                                              Icons.favorite_border,
                                              color: Colors.grey,
                                              size: iconButtonSize,
                                            ));
                                      }),
                                      Builder(builder: (context) {
                                        if (state.userBook == null) {
                                          return IconButton(
                                              onPressed: () {
                                                bookInfoCubit.addUserBook(
                                                    stateProfile.user!.email);
                                              },
                                              icon: Icon(
                                                Icons.add,
                                                color: tertiaryColor,
                                              ));
                                        }
                                        return IconButton(
                                            onPressed: () {
                                              bookInfoCubit.removeUserBook();
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: tertiaryColor,
                                            ));
                                      }),
                                      Visibility(
                                        visible: state.userBook != null,
                                        child: IconButton(
                                            onPressed: () {
                                              showBottomSheet(
                                                  showDragHandle: true,
                                                  enableDrag: true,
                                                  context: context,
                                                  builder: (context) {
                                                    return SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.4,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: TextFormField(
                                                            maxLines: 7,
                                                            initialValue: state
                                                                    .userBook
                                                                    ?.notes ??
                                                                "",
                                                            onChanged: (value) =>
                                                                bookInfoCubit.updateUserBook(state
                                                                    .userBook!
                                                                    .copyWith(
                                                                        notes:
                                                                            value)),
                                                            decoration:
                                                                const InputDecoration(
                                                                    border:
                                                                        OutlineInputBorder(),
                                                                    label: Text(
                                                                        "Notas")),
                                                          ),
                                                        ));
                                                  });
                                            },
                                            icon: Icon(
                                              Icons.add_comment,
                                              size: iconButtonSize,
                                              color: tertiaryColor,
                                            )),
                                      )
                                    ],
                                  ),
                                );
                              }

                              return const SizedBox.shrink();
                            },
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
                    BlocBuilder<ProfileCubit, ProfileState>(
                        builder: (context, profilestate) {
                      if (state.userBook != null &&
                          profilestate is LoadedProfileState &&
                          profilestate.user != null) {
                        return StartRating(
                            fillColor: primaryColor,
                            ratingValue: state.userBook!.rating,
                            onTapStart: (value) {
                              bookInfoCubit.updateUserBook(state.userBook!
                                  .copyWith(rating: value.toDouble()));
                            });
                      }

                      return const SizedBox.shrink();
                    }),
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
                    Visibility(
                      visible: state.userBook != null,
                      child: Text(
                        translateValue(
                            state.userBook?.status ?? BookStatus.waiting),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    Visibility(
                      visible: state.userBook != null,
                      child: Card(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 24),
                            child: Text(
                              "${state.userBook?.readedPages ?? ""}/${state.book.quantPages}",
                              style: const TextStyle(fontSize: 18),
                            )),
                      ),
                    )
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ));
  }
}
