import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vii_music/model/user.dart';
import 'package:vii_music/responsive/user_api.dart';
import 'package:vii_music/validator/signup_validator.dart';

class SignupViewModel {
  final _username = BehaviorSubject<String>();
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _btnSignup = BehaviorSubject<bool>();

  var userValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (username, sink) {
    sink.add(SignUpValidator.userNameValidator(username)!);
  });

  var emailValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    sink.add(SignUpValidator.emailValidator(email)!);
  });

  var passValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (pass, sink) {
    sink.add(SignUpValidator.paswordValidator(pass)!);
  });

  Stream<String> get usernameStream =>
      _username.stream.transform(userValidator);
  Sink<String> get usernameSink => _username.sink;

  Stream<String> get emailStream => _email.stream.transform(emailValidator);
  Sink<String> get emailSink => _email.sink;

  Stream<String> get passwordStream =>
      _password.stream.transform(passValidator);
  Sink<String> get passwordSink => _password.sink;

  Stream<bool> get btnSignupStream => _btnSignup.stream;
  Sink<bool> get btnSignupSink => _btnSignup.sink;

  SignupViewModel() {
    Rx.combineLatest3(_username, _email, _password,
        (username, email, password) {
      return SignUpValidator.userNameValidator(username.toString()) == null &&
          SignUpValidator.emailValidator(email.toString()) == null &&
          SignUpValidator.paswordValidator(password.toString()) == null;
    }).listen((enable) {
      btnSignupSink.add(enable);
    });
  }

  dispone() {
    _username.close();
    _email.close();
    _password.close();
    _btnSignup.close();
  }

  void signUp(Users users) {
    UserApi.signUp(users).then((value) {
      if (value) {
        Fluttertoast.showToast(
            msg: "Đăng ký thành công ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey.shade300,
            textColor: Colors.black,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Đăng ký không thành công ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey.shade300,
            textColor: Colors.black,
            fontSize: 16.0);
      }
    });
  }
}
