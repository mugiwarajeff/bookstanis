import 'package:bookstanis/app/bookstanis_app.dart';
import 'package:bookstanis/app/features/books/bloc/books_info_form/book_info_form_cubit.dart';
import 'package:bookstanis/app/features/books/bloc/books_view/book_cubit.dart';
import 'package:bookstanis/app/features/books/services/book_repository_local.dart';
import 'package:bookstanis/app/features/books/services/interface/books_repository.dart';
import 'package:bookstanis/app/features/configurations/bloc/configurations_cubit.dart';
import 'package:bookstanis/app/shared/logs/impl_message_logger.dart';
import 'package:bookstanis/app/shared/logs/interface/message_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BookRepositoryLocal booksRepository = BookRepositoryLocal();
  await booksRepository.loadRepository();

  runApp(MultiRepositoryProvider(
      providers: [
        RepositoryProvider<BooksRepository>(
          create: (context) => booksRepository,
        ),
        RepositoryProvider<MessageLogger>(
            create: (context) => ImplMessageLogger())
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider<BookCubit>(
            create: (context) => BookCubit(
                RepositoryProvider.of<BooksRepository>(context),
                RepositoryProvider.of<MessageLogger>(context))),
        BlocProvider(
            create: (context) => BookInfoFormCubit(
                RepositoryProvider.of<BooksRepository>(context),
                RepositoryProvider.of<MessageLogger>(context))),
        BlocProvider<ConfigurationsCubit>(
            create: (context) => ConfigurationsCubit()),
      ], child: const BookstanisApp())));
}
