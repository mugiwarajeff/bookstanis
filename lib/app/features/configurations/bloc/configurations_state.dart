import 'package:bookstanis/app/features/configurations/models/configurations.dart';

abstract class ConfigurationsState {}

class InitialConfigurationsState extends ConfigurationsState {}

class LoadingConfigurationsState extends ConfigurationsState {}

class LoadedConfigurationsState extends ConfigurationsState {
  final Configurations configurations;

  LoadedConfigurationsState({required this.configurations});
}

class ErrorconfigurationsState extends ConfigurationsState {
  final String errorMessage;

  ErrorconfigurationsState({required this.errorMessage});
}
