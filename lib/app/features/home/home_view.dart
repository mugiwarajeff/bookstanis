import 'package:bookstanis/app/features/books/books_list/books_list_view.dart';
import 'package:bookstanis/app/features/configurations/bloc/configurations_cubit.dart';
import 'package:bookstanis/app/features/configurations/bloc/configurations_state.dart';
import 'package:bookstanis/app/features/my_books/my_books_view.dart';
import 'package:bookstanis/app/features/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;

  Widget selectPage() {
    switch (currentIndex) {
      case 0:
        return const BooksListView();
      case 1:
        return const MyBooksView();
      case 2:
        return const ProfileView();
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ConfigurationsCubit configurationsCubit =
        BlocProvider.of<ConfigurationsCubit>(context);

    final String exploreText = AppLocalizations.of(context)!.explore;
    final String profileText = AppLocalizations.of(context)!.profile;
    final String myBooksText = AppLocalizations.of(context)!.myBooks;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookstanis"),
        actions: [
          IconButton(onPressed: () {
            configurationsCubit.toggleDarkMode();
          }, icon: BlocBuilder<ConfigurationsCubit, ConfigurationsState>(
            builder: (context, state) {
              if (state is LoadedConfigurationsState) {
                return state.configurations.themeMode == ThemeMode.dark
                    ? const Icon(Icons.dark_mode)
                    : const Icon(Icons.light_mode);
              }

              return Container();
            },
          ))
        ],
      ),
      body: selectPage(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.manage_search_sharp), label: exploreText),
          BottomNavigationBarItem(
              icon: const Icon(Icons.book), label: myBooksText),
          BottomNavigationBarItem(
              icon: const Icon(Icons.person), label: profileText),
        ],
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
      ),
    );
  }
}
