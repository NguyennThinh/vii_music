import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vii_music/contants.dart';
import 'package:vii_music/responsive/user_api.dart';
import 'package:vii_music/screen/home/home_screen.dart';
import 'package:vii_music/screen/sign%20in/signin_screen.dart';

import 'sign up/sigup_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      SharedPreferences.getInstance().then((value) => {
            if (value.get('tokenSession') == null)
              {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignupScreen(),
                    ),
                    (route) => false)
              }
            else
              {
                UserApi.loginToken(value.getString('tokenSession')!)
                    .then((value) => {
                          if (value)
                            {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomeScreen(),
                                  ),
                                  (route) => false)
                            }
                          else
                            {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SigninScreen(),
                                  ),
                                  (route) => false)
                            }
                        })
              }
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.bottomRight,
                    colors: [kPrimaryCyan, kPrimaryEmerald])),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/music.png"),
                  const Text(
                    "Start Turing Your ideas\n into Reality",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 27,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    "Listen to Vii Music",
                    style: TextStyle(
                      color: kgreen,
                      fontFamily: 'Poppins',
                      fontSize: 24,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
