import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';
import 'package:techfrenetic/app/providers/user_provider.dart';
import '../../common/validators.dart';

class ForgotPasswordController extends Disposable {
  final UserProvider _userProvider = UserProvider();

  final _usernameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _tokenController = BehaviorSubject<String>();
  final _newPasswordController = BehaviorSubject<String>();
  final _passwordConfirmationController = BehaviorSubject<bool>();

  Stream<String> get usernameStream =>
      _emailController.stream.transform(Validators.validateFieldRequired);
  Stream<String> get emailStream =>
      _emailController.stream.transform(Validators.validateEmail);
  Stream<String> get tokenStream => _tokenController.stream;
  Stream<String> get newPasswordStream => _newPasswordController.stream
      .transform(Validators.validateSignInPassword);
  Stream<bool> get passwordConfirmationStream =>
      _passwordConfirmationController.stream
          .transform(Validators.validateConfirmPass);
  Stream<bool> get formValidStream => Rx.combineLatest3(emailStream,
      newPasswordStream, passwordConfirmationStream, (e, p, c) => true);

  Function(String) get changeUsername => _usernameController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changeToken => _tokenController.sink.add;
  Function(String) get changeNewPassword => _newPasswordController.sink.add;
  Function(bool) get changeNewConfirmationPassword =>
      _passwordConfirmationController.sink.add;

  String get username => _usernameController.valueOrNull ?? "";
  String get email => _emailController.valueOrNull ?? "";
  String get token => _tokenController.valueOrNull ?? "";
  String get newPassword => _newPasswordController.valueOrNull ?? "";
  bool get newConfirmationPassword =>
      _passwordConfirmationController.valueOrNull ?? false;

  Future<bool> recoverPassword() async {
    return _userProvider.recoverPassword(email);
  }

  Future<bool> updatePassword() {
    return _userProvider.updatePassword(username, token, newPassword);
  }

  @override
  void dispose() {
    _emailController.close();
  }
}
