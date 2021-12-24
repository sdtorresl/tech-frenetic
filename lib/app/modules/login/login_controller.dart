import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';
import 'package:techfrenetic/app/models/session_model.dart';
import 'package:techfrenetic/app/providers/user_provider.dart';
import '../../common/validators.dart';

class LoginController extends Disposable {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<String> get emailStream =>
      _emailController.stream.transform(Validators.validateEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(Validators.validateLoginPassword);

  Stream<bool> get formValidStream =>
      Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  String get email => _emailController.value;
  String get password => _passwordController.value;

  Future<bool> login() async {
    UserProvider _userProvider = UserProvider();

    SessionModel? session = await _userProvider.login(email, password);

    if (session != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    _emailController.close();
    _passwordController.close();
  }
}
