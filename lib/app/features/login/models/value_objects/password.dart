import 'package:bookstanis/app/shared/value_object/value_object.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Password extends ValueObject {
  Password({required super.value});

  @override
  String? validate(String? value, AppLocalizations appLocalizations) {
    String? error;

    if (value == null || value.isEmpty) {
      error = appLocalizations.cantBeEmpty;
    }

    return error;
  }
}
