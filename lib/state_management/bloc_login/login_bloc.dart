
import 'dart:async';

import 'package:rxdart/rxdart.dart';

class LoginBloc {

  StreamController<String> username = BehaviorSubject();
  StreamController<String> password = BehaviorSubject();

  void login() {

  }
}