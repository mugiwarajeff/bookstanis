import 'package:bookstanis/app/shared/value_object/value_object.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Email extends ValueObject<String> {
  Email({required super.value});

  @override
  String? validate(String? value, AppLocalizations appLocalizations) {
    String? error;
    final emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");

    if (value == null || value.isEmpty || value == "") {
      error = appLocalizations.cantBeEmpty;
    }

    if (!emailRegex.hasMatch(value ?? "")) {
      error = appLocalizations.invalidEmail;
    }

    return error;
  }
}
