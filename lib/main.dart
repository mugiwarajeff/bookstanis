import 'package:bookstanis/app/bookstanis_app.dart';
import 'package:bookstanis/app/features/books/book_info/bloc/book_info_cubit.dart';
import 'package:bookstanis/app/features/books/books_list/bloc/book_cubit.dart';
import 'package:bookstanis/app/features/books/services/book_repository_dio.dart';

import 'package:bookstanis/app/features/books/services/interface/books_repository.dart';
import 'package:bookstanis/app/features/books/user_book_list/bloc/user_book_list_cubit.dart';
import 'package:bookstanis/app/features/configurations/bloc/configurations_cubit.dart';
import 'package:bookstanis/app/features/login/bloc/login_cubit.dart';
import 'package:bookstanis/app/features/login/service/firebase_auth_service.dart';
import 'package:bookstanis/app/features/login/service/interface/auth_service.dart';

import 'package:bookstanis/app/features/profile/bloc/profile_cubit.dart';
import 'package:bookstanis/app/shared/logs/impl_message_logger.dart';
import 'package:bookstanis/app/shared/logs/interface/message_logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseApp app = await Firebase.initializeApp();
  FirebaseAuth.instanceFor(app: app);

  runApp(MultiRepositoryProvider(
      providers: [
        RepositoryProvider<BooksRepository>(
          create: (context) => BookRepositoryDio(),
        ),
        RepositoryProvider<AuthService>(
            create: (context) => FirebaseAuthService()),
        RepositoryProvider<MessageLogger>(
            create: (context) => ImplMessageLogger())
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider<BookCubit>(
            create: (context) => BookCubit(
                RepositoryProvider.of<BooksRepository>(context),
                RepositoryProvider.of<MessageLogger>(context))),
        BlocProvider<UserBookListCubit>(
            create: (context) => UserBookListCubit(
                RepositoryProvider.of<BooksRepository>(context),
                RepositoryProvider.of<MessageLogger>(context))),
        BlocProvider(
            create: (context) => BookInfoCubit(
                RepositoryProvider.of<BooksRepository>(context),
                RepositoryProvider.of<MessageLogger>(context))),
        BlocProvider<ConfigurationsCubit>(
            create: (context) => ConfigurationsCubit()),
        BlocProvider<ProfileCubit>(
            create: (context) =>
                ProfileCubit(RepositoryProvider.of<AuthService>(context))),
        BlocProvider<LoginCubit>(
            create: (context) => LoginCubit(
                RepositoryProvider.of<AuthService>(context),
                BlocProvider.of<ProfileCubit>(context))),
      ], child: const BookstanisApp())));
}
