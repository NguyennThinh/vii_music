import 'package:flutter/material.dart';
import 'package:vii_music/model/user.dart';

import '../../../contants.dart';
import '../../../view_model/signup_view_model.dart';

class ButtonSignup extends StatelessWidget {
  const ButtonSignup({
    Key? key,
    required this.model,
    required this.signup,
  }) : super(key: key);

  final SignupViewModel model;

  final VoidCallback signup;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [kPrimaryCyan, kPrimaryEmerald]),
        borderRadius: BorderRadius.circular(15),
      ),
      child: StreamBuilder<bool>(
          stream: model.btnSignupStream,
          builder: (context, snapshot) {
            return TextButton(
                onPressed: signup,
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Sign up",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    )
                  ],
                ));
          }),
    );
  }
}
