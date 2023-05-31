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
  invalidUrl,
  dateRequired,
  futureDateRequired,
  nameRequired,
  phoneRequired,
  phoneInvalid
}

class TFError {
  static String getError(BuildContext context, ErrorType? errorType) {
    if (errorType == null) return '';

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
      case ErrorType.invalidUrl:
        return AppLocalizations.of(context)!.error_wrong_url;
      case ErrorType.dateRequired:
        return AppLocalizations.of(context)!.error_date_required;
      case ErrorType.nameRequired:
        return AppLocalizations.of(context)!.error_name_required;
      case ErrorType.phoneRequired:
        return AppLocalizations.of(context)!.error_phone_required;
      case ErrorType.phoneInvalid:
        return AppLocalizations.of(context)!.error_phone_invalid;
      case ErrorType.futureDateRequired:
        return AppLocalizations.of(context)!.error_when_future;
      default:
        return AppLocalizations.of(context)!.message_error;
    }
  }
}
