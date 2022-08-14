import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vii_music/responsive/user_api.dart';
import 'package:vii_music/screen/home/home_screen.dart';

import '../validator/login_validator.dart';

class LoginViewModel {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _btnLogin = BehaviorSubject<bool>();

  var emailValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    sink.add(LoginValidator.emailValidator(email)!);
  });

  var passValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (pass, sink) {
    sink.add(LoginValidator.paswordValidator(pass)!);
  });

  Stream<String> get emailStream => _email.stream.transform(emailValidator);
  Sink<String> get emailSink => _email.sink;

  Stream<String> get passwordStream =>
      _password.stream.transform(passValidator);
  Sink<String> get passwordSink => _password.sink;

  Stream<bool> get btnLoginStream => _btnLogin.stream;
  Sink<bool> get btnLoginSink => _btnLogin.sink;

  LoginViewModel() {
    Rx.combineLatest2(_email, _password, (email, password) {
      return LoginValidator.emailValidator(email.toString()) == null &&
          LoginValidator.paswordValidator(password.toString()) == null;
    }).listen((enable) {
      btnLoginSink.add(enable);
    });
  }
  dispone() {
    _email.close();
    _password.close();
    _btnLogin.close();
  }

  void login(String email, String password, BuildContext context) {
    UserApi.login(email, password).then((value) {
      final data = json.decode(value);
      Fluttertoast.showToast(
          msg: data["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey.shade300,
          textColor: Colors.black,
          fontSize: 16.0);

      if (data["token"] != null) {
        SharedPreferences.getInstance().then((value) => {
              value.remove("tokenSession"),
              value.setString('tokenSession', data['token']),
            });

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
            (route) => false);
      }
    });
  }
}
