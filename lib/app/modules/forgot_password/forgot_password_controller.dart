import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';
import 'package:techfrenetic/app/providers/user_provider.dart';
import '../../common/validators.dart';

class ForgotPasswordController extends Disposable {
  final _emailController = BehaviorSubject<String>();

  Stream<String> get emailStream =>
      _emailController.stream.transform(Validators.validateEmail);

  Function(String) get changeEmail => _emailController.sink.add;

  String get email => _emailController.value;

  Future<bool> recoverPassword() async {
    UserProvider userProvider = UserProvider();
    return userProvider.recoverPassword(email);
  }

  @override
  void dispose() {
    _emailController.close();
  }
}
