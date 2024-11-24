import 'package:bookstanis/app/shared/value_object/value_object.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Phone extends ValueObject<String> {
  Phone({required super.value});

  @override
  String? validate(String? value, AppLocalizations appLocalizations) {
    String? error;
    final phoneRegex = RegExp(r"^\+?[\d\s()-]{7,15}$");

    if (value != null && value.isNotEmpty && !phoneRegex.hasMatch(value)) {
      error = appLocalizations.invalidPhone;
    }

    return error;
  }
}
