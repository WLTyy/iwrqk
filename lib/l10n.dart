import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/intl_localizations.dart';

class L10n {
  static List<Locale> supportedLocales = AppLocalizations.supportedLocales;

  static AppLocalizations of(BuildContext context) {
    return AppLocalizations.of(context)!;
  }
}
