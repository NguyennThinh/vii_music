import 'package:flutter/material.dart';
import 'package:vii_music/contants.dart';
import 'package:vii_music/screen/sign%20up/sigup_screen.dart';

import '../../view_model/login_view_model.dart';
import 'compinent/button_sigin_google.dart';
import 'compinent/button_sign_in.dart';
import 'compinent/input_email.dart';
import 'compinent/input_password.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final loginViewModel = LoginViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController.addListener(() {
      loginViewModel.emailSink.add(_emailController.text);
    });

    _passwordController.addListener(() {
      loginViewModel.passwordSink.add(_passwordController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/image_backgound.png"),
                fit: BoxFit.cover)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 70,
                  width: 70,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [kPrimaryCyan, kPrimaryEmerald])),
                  child: Image.asset("assets/images/music.png"),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Welcome to Vii Music",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 24,
                    color: kgreen,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Sign in to your account",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 28,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Email",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InputEmail_Signin(
                    controller: _emailController, model: loginViewModel),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Password",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InputPassword_Signin(
                    controller: _passwordController, model: loginViewModel),
                const SizedBox(
                  height: 40,
                ),
                ButtonSignin(
                    model: loginViewModel,
                    signin: () {
                      setState(() {
                        loginViewModel.login(_emailController.text,
                            _passwordController.text, context);
                      });
                    }),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: const [
                    Expanded(
                      child: Divider(
                        thickness: 2,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Or continue with",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        color: kgrayLight,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 2,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const ButtonSigninGoogle(),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already haven't an account? ",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        color: kgrayLight,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignupScreen(),
                            ));
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          color: kgreen,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
