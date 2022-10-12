import 'package:flutter/material.dart';
import 'package:techfrenetic/app/widgets/validate_text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangePasswordValidationWidget extends StatelessWidget {
  const ChangePasswordValidationWidget({
    Key? key,
    required this.password,
    required this.confirmationPassword,
  }) : super(key: key);

  final String password;
  final String confirmationPassword;

  @override
  Widget build(BuildContext context) {
    bool passwordLength = password.length >= 8;
    bool passwordHasNumbers = RegExp(r'\d').hasMatch(password);
    bool passwordHasMixedCase = password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[a-z]'));
    bool passwordsMatch = password == confirmationPassword;

    return Column(
      children: [
        ValidateTextWidget(
            isValid: passwordLength,
            text: AppLocalizations.of(context)!.pwd_minchars),
        const SizedBox(height: 10),
        ValidateTextWidget(
            isValid: passwordHasMixedCase,
            text: AppLocalizations.of(context)!.pwd_lowper),
        const SizedBox(height: 10),
        ValidateTextWidget(
            isValid: passwordHasNumbers,
            text: AppLocalizations.of(context)!.pwd_number),
        const SizedBox(height: 10),
        ValidateTextWidget(
            isValid: passwordsMatch,
            text: AppLocalizations.of(context)!.pwd_match),
      ],
    );
  }
}
