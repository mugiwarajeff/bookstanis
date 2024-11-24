import 'package:bookstanis/app/shared/value_object/value_object.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LastName extends ValueObject<String> {
  LastName({required super.value});

  @override
  String? validate(String? value, AppLocalizations appLocalizations) {
    return null;
  }
}
