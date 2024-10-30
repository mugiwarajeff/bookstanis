import 'package:bookstanis/app/features/books/books_view.dart';
import 'package:bookstanis/app/features/configurations/bloc/configurations_cubit.dart';
import 'package:bookstanis/app/features/configurations/bloc/configurations_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final ConfigurationsCubit configurationsCubit =
        BlocProvider.of<ConfigurationsCubit>(context);

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
      body: const BooksView(),
    );
  }
}
