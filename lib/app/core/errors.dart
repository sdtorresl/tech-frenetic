import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum ErrorType {
  summaryEmpty,
  summaryLengtInvalid,
  fieldEmpty,
  fieldMinLenght,
  fieldLowercase,
  fieldUppercase,
  fieldNumeric,
  fieldRequired,
}

class TFError {
  static String? getError(BuildContext context, ErrorType? errorType) {
    if (errorType == null) return null;

    switch (errorType) {
      case ErrorType.summaryEmpty:
        return AppLocalizations.of(context)!.error_about_required;
      case ErrorType.summaryLengtInvalid:
        return AppLocalizations.of(context)!.error_about_minlenght;
      case ErrorType.fieldLowercase:
        return AppLocalizations.of(context)!.error_lowercase;
      case ErrorType.fieldMinLenght:
        return AppLocalizations.of(context)!.error_minlenght;
      case ErrorType.fieldEmpty:
        return AppLocalizations.of(context)!.error_not_empty;
      case ErrorType.fieldNumeric:
        return AppLocalizations.of(context)!.error_numeric;
      case ErrorType.fieldRequired:
        return AppLocalizations.of(context)!.error_required;
      case ErrorType.fieldUppercase:
        return AppLocalizations.of(context)!.error_uperrcase;

      default:
        return null;
    }
  }
}
