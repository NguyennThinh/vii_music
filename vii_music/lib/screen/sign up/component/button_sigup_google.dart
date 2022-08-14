import 'package:flutter/material.dart';

import '../../../contants.dart';

class ButtonSignupGoogle extends StatelessWidget {
  const ButtonSignupGoogle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {},
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/google.png"),
            const Text(
              "Sign up with Google",
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: kgray,
              ),
            )
          ],
        ));
  }
}
