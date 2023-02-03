import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ValidateCodePage extends StatefulWidget {
  final String phoneNumber;
  final void Function() onValidated;
  final void Function()? onBack;

  const ValidateCodePage(
      {Key? key,
      required this.phoneNumber,
      required this.onValidated,
      this.onBack})
      : super(key: key);

  @override
  State<ValidateCodePage> createState() => _ValidateCodePageState();
}

class _ValidateCodePageState extends State<ValidateCodePage> {
  final TextEditingController _codeEditingController = TextEditingController();
  int _invalidTries = 0;
  int _sentCodes = 0;
  bool _codeSent = false;
  String? _verificationId;

  @override
  void initState() {
    super.initState();
    _verifyPhone();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 30.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)?.sms_validation_description ?? '',
              style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(
            height: 20,
          ),
          Text(
            AppLocalizations.of(context)?.sms_code ?? '',
          ),
          TextField(
            controller: _codeEditingController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[0-9]')),
            ],
          ),
          _errorMessage(),
          const SizedBox(
            height: 25,
          ),
          Text(
            AppLocalizations.of(context)?.sms_not_received ?? '',
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 10),
            child: OutlinedButton(
              onPressed: _codeSent && _sentCodes < 3 ? _verifyPhone : null,
              child: Text(
                AppLocalizations.of(context)?.sms_resend ?? '',
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            AppLocalizations.of(context)?.sms_phone_not_correct ?? '',
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 10),
            child: OutlinedButton(
              onPressed: widget.onBack != null
                  ? widget.onBack!
                  : () => Modular.to.pop(),
              child: Text(
                AppLocalizations.of(context)?.sms_go_back ?? '',
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          _confirmButton()
        ],
      ),
    );
  }

  Widget _confirmButton() {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _invalidTries < 3 ? _validate : null,
          child: Text(AppLocalizations.of(context)?.confirm ?? ''),
        ),
      ),
    );
  }

  Widget _errorMessage() {
    if (_sentCodes >= 3) {
      return Container(
        margin: const EdgeInsets.only(top: 5),
        padding: const EdgeInsets.all(15),
        color: const Color.fromRGBO(255, 232, 232, 1),
        child: Text(
          AppLocalizations.of(context)?.sms_code_reached_maximum_sends ?? '',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    if (_invalidTries == 0) {
      return const SizedBox.shrink();
    }

    if (_invalidTries >= 3) {
      return Container(
        margin: const EdgeInsets.only(top: 5),
        padding: const EdgeInsets.all(15),
        color: const Color.fromRGBO(255, 232, 232, 1),
        child: Text(
          AppLocalizations.of(context)?.sms_code_not_correct_final ?? '',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Text(
        AppLocalizations.of(context)?.sms_code_not_correct ?? '',
        style:
            Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.red),
      ),
    );
  }

  Future _validate() async {
    final bool codeValid = await _validateCode();
    if (!codeValid) {
      setState(() {
        _invalidTries++;
      });
      return;
    } else {
      widget.onValidated();
    }
  }

  Future<bool> _validateCode() async {
    if (_verificationId != null) {
      try {
        await FirebaseAuth.instance
            .signInWithCredential(PhoneAuthProvider.credential(
          verificationId: _verificationId!,
          smsCode: _codeEditingController.value.toString(),
        ));
      } catch (e) {
        if (e is FirebaseAuthException) {
          _showError(e);
        } else {
          rethrow;
        }
        return false;
      }
      return true;
    }

    return false;
  }

  Future _verifyPhone() async {
    debugPrint("Sending verification request to phone ${widget.phoneNumber}");
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: widget.phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        debugPrint("Verification completed");
        widget.onValidated();
      },
      verificationFailed: _showError,
      codeSent: (String verificationId, int? resendToken) {
        debugPrint("Code was sent");
        setState(() {
          _codeSent = true;
          _sentCodes++;
        });
        _verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  void _showError(FirebaseAuthException e) {
    String error = AppLocalizations.of(context)?.error ?? '';
    switch (e.code) {
      case 'too-many-requests':
        error = AppLocalizations.of(context)?.sms_too_many_requests ?? '';
        break;
      case 'session-expired':
        error = AppLocalizations.of(context)?.sms_code_expired ?? '';
        break;
      case 'invalid-phone-number':
        error = AppLocalizations.of(context)?.sms_invalid_number ?? '';
        break;
      case 'invalid-verification-code':
        error = AppLocalizations.of(context)?.sms_invalid_number ?? '';
        break;
      default:
        error = e.message ?? AppLocalizations.of(context)?.error ?? '';
    }

    var snackBar = SnackBar(
      duration: const Duration(seconds: 5),
      content: Text(error),
      backgroundColor: Colors.red,
      action: SnackBarAction(
        label: AppLocalizations.of(context)?.back ?? '',
        textColor: Colors.white,
        onPressed: () =>
            Modular.to.popUntil(ModalRoute.withName('/profile/profile')),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
