import 'package:bookstanis/app/features/configurations/bloc/configurations_state.dart';
import 'package:bookstanis/app/features/configurations/models/configurations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfigurationsCubit extends Cubit<ConfigurationsState> {
  Configurations _configurations = Configurations.empty();

  ConfigurationsCubit() : super(InitialConfigurationsState());

  Future<void> loadConfiguration() async {
    emit(LoadingConfigurationsState());

    _configurations = Configurations.empty();

    emit(LoadedConfigurationsState(configurations: _configurations));
  }

  void toggleDarkMode() {
    ThemeMode newTheme = _configurations.themeMode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;

    _configurations = _configurations.copyWith(themeMode: newTheme);

    emit(LoadedConfigurationsState(configurations: _configurations));
  }
}
