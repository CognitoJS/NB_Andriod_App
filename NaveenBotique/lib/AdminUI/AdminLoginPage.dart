import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naveenbotique/AdminUI/AdminDashoboard.dart';
import 'package:naveenbotique/UI/loadingscreen.dart';
import 'package:naveenbotique/functions/screensfucntion.dart';

import '../Constants/constants.dart';
import '../Widgets/buttonwidget.dart';
import '../Widgets/textfieldwidget.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({Key? key}) : super(key: key);

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
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

  adminLogin() {
    if (emailController.text == 'naveen@gmail.com' ||
        passwordController.text == '1122') {
      nextScreen(context, const AdminDashboard());
    } else {
      return ScaffoldMessenger.of(context).showSnackBar(
        alertmessage(context, "OOPs!", "Something went Wrong", errorColor),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: adminLoginFormkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 150 / MediaQuery.of(context).devicePixelRatio,
                ),
                SizedBox(
                  height: 150,
                  child: Image.asset("assets/Naveen Boutique new logo.png"),
                ),
                SizedBox(
                  height: 100 / MediaQuery.of(context).devicePixelRatio,
                ),
                Text(
                  "Admin Login",
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
                SizedBox(
                  height: 50 / MediaQuery.of(context).devicePixelRatio,
                ),
                Button(
                  text: 'LOGIN',
                  ontap: () {
                    adminLogin();
                  },
                ),
                SizedBox(
                  height: 50 / MediaQuery.of(context).devicePixelRatio,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
