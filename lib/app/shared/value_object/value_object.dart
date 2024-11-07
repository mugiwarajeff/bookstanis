import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class ValueObject<T> {
  T value;

  ValueObject({required this.value});

  String? validate(String? value, AppLocalizations appLocalizations);
}
