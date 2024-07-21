import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/sign_up/create_profile/create_profile_controller.dart';
import 'package:techfrenetic/app/widgets/appbar_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';
import 'package:techfrenetic/app/widgets/progress_button.dart';

class ConfirmNumberPage extends StatefulWidget {
  const ConfirmNumberPage({Key? key}) : super(key: key);

  @override
  State<ConfirmNumberPage> createState() => _ConfirmNumberPageState();
}

class _ConfirmNumberPageState extends State<ConfirmNumberPage> {
  final CreateProfileController _profileController = Modular.get();
  final TextEditingController _codeEditingController = TextEditingController();
  int _invalidTries = 0;
  int _sentCodes = 0;
  bool _codeSent = false;

  @override
  void initState() {
    super.initState();
    if (_profileController.code != null) {
      _codeEditingController.text = _profileController.code.toString();
    }
    _codeEditingController.addListener(() {
      if (_codeEditingController.text.isNotEmpty) {
        _profileController.changeCode(_codeEditingController.text);
      }
    });
    _verifyPhone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TFAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 30.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            HighlightContainer(
              child: Text(
                AppLocalizations.of(context)!.blue_create,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: Theme.of(context).indicatorColor, fontSize: 30),
              ),
            ),
            Text(
              AppLocalizations.of(context)!.black_create,
              style:
                  Theme.of(context).textTheme.headline1!.copyWith(fontSize: 30),
            ),
            const SizedBox(height: 25),
            Text(
                AppLocalizations.of(context)
                        ?.profile_confirm_number_description ??
                    '',
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
              child: ElevatedButton(
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
              child: ElevatedButton(
                onPressed: () => Modular.to.pop(),
                child: Text(
                  AppLocalizations.of(context)?.sms_go_back ?? '',
                ),
              ),
            ),
            const Spacer(),
            _confirmButton()
          ],
        ),
      ),
    );
  }

  Widget _confirmButton() {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: StreamBuilder(
          stream: _profileController.submitValidStream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return ProgressButton(
              onPressed: snapshot.hasData && _invalidTries < 3
                  ? _validateAndCreateProfile
                  : null,
              text: AppLocalizations.of(context)?.confirm ?? '',
            );
          },
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

  Future _validateAndCreateProfile() async {
    final bool codeValid = await _validateCode();
    if (!codeValid) {
      setState(() {
        _invalidTries++;
      });
      return;
    }
    _createProfile();
  }

  Future<bool> _validateCode() {
    return _profileController.validateCode();
  }

  Future _createProfile() async {
    bool createProfile = await _profileController.createProfile();

    if (createProfile) {
      Modular.to.pushNamedAndRemoveUntil('/choose_avatar', (p0) => false);
    } else {
      debugPrint("Profile not created");
    }
  }

  Future _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: _profileController.phone,
      verificationCompleted: (PhoneAuthCredential credential) {
        debugPrint("Verification completed");
        _createProfile();
      },
      verificationFailed: (FirebaseAuthException e) {
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
            onPressed: () {
              Modular.to.pop();
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      codeSent: (String verificationId, int? resendToken) {
        debugPrint("Code was sent");
        setState(() {
          _codeSent = true;
          _sentCodes++;
        });
        _profileController.changeVerificationId(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _profileController.changeVerificationId(verificationId);
      },
    );
  }
}
