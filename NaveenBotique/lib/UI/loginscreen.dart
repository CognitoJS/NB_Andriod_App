import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naveenbotique/UI/loadingscreen.dart';
import 'package:naveenbotique/UI/signupscreen.dart';
import 'package:naveenbotique/functions/screensfucntion.dart';

import '../Constants/constants.dart';
import '../Widgets/buttonwidget.dart';
import '../Widgets/textfieldwidget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void loginUser() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoadingScreen()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          alertmessage(
              context, "Oh snap!", "No user found for that email", errorColor),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          alertmessage(context, "Oh snap!", "Wrong Password", errorColor),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: loginFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 150 / MediaQuery.of(context).devicePixelRatio,
                ),
                Container(
                  height: 150,
                  child: Image.asset("assets/Naveen Boutique new logo.png"),
                ),
                SizedBox(
                  height: 100 / MediaQuery.of(context).devicePixelRatio,
                ),
                Text(
                  "Login",
                  style: GoogleFonts.playfairDisplaySc(
                      color: buttonColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                SizedBox(
                  height: 50 / MediaQuery.of(context).devicePixelRatio,
                ),
                textfields(
                  controller: emailController,
                  text: 'Email',
                  obsecuretext: false,
                ),
                SizedBox(
                  height: 50 / MediaQuery.of(context).devicePixelRatio,
                ),
                textfields(
                    controller: passwordController,
                    text: "Password",
                    obsecuretext: true),
                SizedBox(
                  height: 50 / MediaQuery.of(context).devicePixelRatio,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot Password ?",
                        style: GoogleFonts.playfairDisplay(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50 / MediaQuery.of(context).devicePixelRatio,
                ),
                Button(
                  text: 'LOGIN',
                  ontap: () {
                    loginUser();
                  },
                ),
                SizedBox(
                  height: 50 / MediaQuery.of(context).devicePixelRatio,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 25 / MediaQuery.of(context).devicePixelRatio),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () {
                          nextScreen(
                            context,
                            const SignupScreen(),
                          );
                        },
                        child: Text(
                          "Don't Have an Account? Signup Here",
                          style: GoogleFonts.playfairDisplay(
                              color: textColor, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
