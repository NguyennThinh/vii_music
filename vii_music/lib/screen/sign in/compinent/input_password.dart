import 'package:flutter/material.dart';
import 'package:vii_music/view_model/login_view_model.dart';

import '../../../contants.dart';

class InputPassword_Signin extends StatelessWidget {
  const InputPassword_Signin({
    Key? key,
    required this.controller,
    required this.model,
  }) : super(key: key);
  final TextEditingController controller;
  final LoginViewModel model;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: model.passwordStream,
        builder: (context, snapshot) {
          return TextField(
            controller: controller,
            style: const TextStyle(
              color: kgray,
              fontFamily: 'Inter',
              fontSize: 16,
            ),
            decoration: InputDecoration(
                errorText: snapshot.data,
                contentPadding: const EdgeInsets.only(
                    top: 0, left: 10, right: 10, bottom: 0),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          );
        });
  }
}
