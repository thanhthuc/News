
import 'dart:async';
import 'dart:ffi';
import 'package:flutter/foundation.dart';
import 'package:news/state_management/bloc_home_news_list/news_home_bloc.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc implements Bloc {

  // MARK: - Private properties
  final _username = BehaviorSubject.seeded('@');
  final _password = BehaviorSubject.seeded('');
  Stream<bool> get isValidToSubmit => Rx.combineLatest2(_username.stream, _password.stream, (u, p) {
    if (u.contains("@") && p.length > 3) {
      return true;
    } else {
      return false;
    }
  });

  // get stream
  Stream<String> get username => _username.stream.transform(_validateEmail);
  Stream<String> get password => _password.stream.transform(_validatePassword);

  // get sink: sink to listen event
  Sink<String> get usernameChange => _username.sink;
  Sink<String> get passwordChange => _password.sink;

  final _validateEmail = StreamTransformer<String, String>.fromHandlers(handleData: (data, eventSink) {
    if (data!.contains("@")) {
      eventSink.add(data);
    } else {
      eventSink.addError("Not valid username format");
    }
  });

  final _validatePassword = StreamTransformer<String, String>.fromHandlers(handleData: (data, eventSink) {
    if (data!.length > 3) {
      eventSink.add(data);
    } else {
      eventSink.addError("Not valid password length");
    }
  });

  LoginBloc() {
    print("init");
    // isValidToSubmit =
  }

  void login() {
    // call api login
    var username = _username.value;
    var password = _password.value;
    // call api
  }

  void register() {
    // call api register
    var username = _username.value;
    var password = _password.value;
  }

  @override
  void dispose() {
    _username.close();
    _password.close();
  }
}