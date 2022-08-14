import 'package:flutter/material.dart';
import 'package:vii_music/contants.dart';
import 'package:vii_music/model/user.dart';
import 'package:vii_music/screen/sign%20in/signin_screen.dart';
import 'package:vii_music/view_model/signup_view_model.dart';

import 'component/button_sign_up.dart';
import 'component/button_sigup_google.dart';
import 'component/input_email.dart';
import 'component/input_name.dart';
import 'component/input_password.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final signupViewModel = SignupViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _usernameController.addListener(() {
      signupViewModel.usernameSink.add(_usernameController.text);
    });
    _emailController.addListener(() {
      signupViewModel.emailSink.add(_emailController.text);
    });

    _passwordController.addListener(() {
      signupViewModel.passwordSink.add(_passwordController.text);
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
                  "Create your account",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 28,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Họ và tên",
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
                InputName_SignUp(
                  controller: _usernameController,
                  model: signupViewModel,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "EMail",
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
                InputEmail_SignUp(
                    controller: _emailController, model: signupViewModel),
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
                InputPassword_SignUp(
                    controller: _passwordController, model: signupViewModel),
                const SizedBox(
                  height: 40,
                ),
                ButtonSignup(
                  model: signupViewModel,
                  signup: () {
                    setState(() {
                      String timeStamp =
                          DateTime.now().millisecondsSinceEpoch.toString();
                      signupViewModel.signUp(Users(
                          email: _emailController.text,
                          name: _usernameController.text,
                          createAt: timeStamp,
                          updateAt: timeStamp,
                          password: _passwordController.text,
                          isAdmin: false));
                    });
                  },
                ),
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
                const ButtonSignupGoogle(),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        color: kgrayLight,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SigninScreen(),
                            ),
                            (route) => false);
                      },
                      child: const Text(
                        "Sign in",
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
