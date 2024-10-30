import 'package:bookstanis/app/features/books/book_info_form.dart';
import 'package:bookstanis/app/features/configurations/bloc/configurations_cubit.dart';
import 'package:bookstanis/app/features/configurations/bloc/configurations_state.dart';
import 'package:bookstanis/app/features/home/home_view.dart';
import 'package:bookstanis/app/shared/theme/bookstanis_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookstanisApp extends StatelessWidget {
  const BookstanisApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ConfigurationsCubit configurationsCubit =
        BlocProvider.of<ConfigurationsCubit>(context);

    configurationsCubit.loadConfiguration();

    return BlocBuilder<ConfigurationsCubit, ConfigurationsState>(
      bloc: configurationsCubit,
      builder: (context, state) {
        if (state is LoadedConfigurationsState) {
          return MaterialApp(
            locale: state.configurations.locale,
            themeMode: state.configurations.themeMode,
            theme: BookstanisTheme.lightTheme,
            darkTheme: BookstanisTheme.darkTheme,
            initialRoute: "/",
            routes: {
              "/": (context) => const HomeView(),
              "/book_info": (context) => const BookInfoForm()
            },
          );
        }
        return Container();
      },
    );
  }
}
