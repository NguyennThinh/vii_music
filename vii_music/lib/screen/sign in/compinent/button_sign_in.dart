import 'package:flutter/material.dart';
import 'package:vii_music/screen/home/home_screen.dart';
import 'package:vii_music/view_model/login_view_model.dart';

import '../../../contants.dart';

class ButtonSignin extends StatelessWidget {
  const ButtonSignin({
    Key? key,
    required this.signin,
    required this.model,
  }) : super(key: key);
  final VoidCallback signin;
  final LoginViewModel model;
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
          stream: model.btnLoginStream,
          builder: (context, snapshot) {
            return TextButton(
                onPressed: signin,
                style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.cyan),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Sign in",
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
