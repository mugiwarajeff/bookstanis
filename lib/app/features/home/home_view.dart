import 'package:bookstanis/app/features/books/books_list/books_list_view.dart';
import 'package:bookstanis/app/features/books/user_book_list/user_book_list_view.dart';
import 'package:bookstanis/app/features/configurations/bloc/configurations_cubit.dart';
import 'package:bookstanis/app/features/configurations/bloc/configurations_state.dart';
import 'package:bookstanis/app/features/profile/bloc/profile_cubit.dart';
import 'package:bookstanis/app/features/profile/bloc/profile_states.dart';
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

  @override
  Widget build(BuildContext context) {
    final ConfigurationsCubit configurationsCubit =
        BlocProvider.of<ConfigurationsCubit>(context);
    final ProfileCubit profileCubit = BlocProvider.of<ProfileCubit>(context);

    final String exploreText = AppLocalizations.of(context)!.explore;
    final String profileText = AppLocalizations.of(context)!.profile;
    final String myBooksText = AppLocalizations.of(context)!.myBooks;

    final Color primaryColor = Theme.of(context).colorScheme.primary;

    Widget selectPage() {
      switch (currentIndex) {
        case 0:
          return const BooksListView(
            key: Key("book_explore_list"),
          );
        case 1:
          return BlocBuilder<ProfileCubit, ProfileState>(
              bloc: profileCubit,
              builder: (context, state) {
                if (state is LoadedProfileState && state.user != null) {
                  return UserBookListView(
                    userId: state.user!.email,
                  );
                }

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.warning,
                        size: 64,
                        color: primaryColor,
                      ),
                      Text(
                        "Entre com seu usuario para visualizar essa Lista",
                        style: TextStyle(color: primaryColor),
                      ),
                    ],
                  ),
                );
              });
        case 2:
          return const ProfileView();
        default:
          return const SizedBox.shrink();
      }
    }

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
