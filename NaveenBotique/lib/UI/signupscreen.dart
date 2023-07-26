import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naveenbotique/UI/termsandcondition.dart';
import 'package:naveenbotique/functions/screensfucntion.dart';
import 'package:naveenbotique/functions/validationfunction.dart';

import '../Constants/constants.dart';
import '../Widgets/buttonwidget.dart';
import '../Widgets/textfieldwidget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  void createUser() async {
    try {
      signupvalidation();
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          )
          .whenComplete(
            () => storeData(),
          );

      popupScreen(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          alertmessage(context, "Oh snap!", "The password provided is too weak",
              errorColor),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          alertmessage(context, "Oh snap!", "Email already in use", errorColor),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  storeData() async {
    final userid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection("Customers").doc(userid).set(
      {
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
        "name": nameController.text.trim(),
      },
    ).whenComplete(
      () => ScaffoldMessenger.of(context).showSnackBar(
        alertmessage(context, "Successfully Registered",
            "Redirecting to Login Page", buttonColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: signupformKey,
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
                  height: 50 / MediaQuery.of(context).devicePixelRatio,
                ),
                Text(
                  "SIGNUP",
                  style: GoogleFonts.playfairDisplaySc(
                      color: buttonColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                SizedBox(
                  height: 50 / MediaQuery.of(context).devicePixelRatio,
                ),
                textfields(
                  controller: nameController,
                  text: 'Name',
                  obsecuretext: false,
                ),
                SizedBox(
                  height: 50 / MediaQuery.of(context).devicePixelRatio,
                ),
                textfields(
                    controller: emailController,
                    text: "Email",
                    obsecuretext: false),
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
                      onPressed: () {
                        nextScreen(
                          context,
                          const TermsandConditions(),
                        );
                      },
                      child: Text(
                        "Terms and Conditions",
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
                  text: 'SIGNUP',
                  ontap: () {
                    createUser();
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
                          popupScreen(context);
                        },
                        child: Text(
                          "Already Have an Account? Login Here",
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
