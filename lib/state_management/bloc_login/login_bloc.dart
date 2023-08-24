
import 'dart:async';

import 'package:rxdart/rxdart.dart';

class LoginBloc {

  final StreamController<String?> _username = PublishSubject();
  final StreamController<String?> _password = PublishSubject();
  final StreamController<bool> _isValid = BehaviorSubject();

  Stream<String?> get usernameSink => _username.stream;
  Stream<String?> get passwordSink => _password.stream;
  late Stream<String?> validateStringStream;
  late Stream<bool> isValidAccount;

  LoginBloc() {
    isValidAccount = _isValid.stream;
    validateStringStream = CombineLatestStream
        .combine2(
        _username.stream.where((event) => (event != null)),
        _password.stream.where((event) => (event != null)),
            (userName, passWord) {
          if (userName!.length < 3) {
            _isValid.add(false);
            return "username not valid";
          }
          if (passWord!.length < 3) {
            _isValid.add(false);
            return "password not valid";
          }
          _isValid.add(true);
    });
  }

  void login() {
  }
}