import 'package:flutter/material.dart';

import '../../../contants.dart';
import '../../../view_model/signup_view_model.dart';

class InputEmail_SignUp extends StatelessWidget {
  const InputEmail_SignUp({
    Key? key,
    required this.controller,
    required this.model,
  }) : super(key: key);
  final TextEditingController controller;
  final SignupViewModel model;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: model.emailStream,
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
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.only(
                    top: 0, left: 10, right: 10, bottom: 0),
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          );
        });
  }
}
