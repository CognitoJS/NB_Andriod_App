import 'package:carousel_slider/carousel_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//userid
String userid = FirebaseAuth.instance.currentUser!.uid;
//Main Colors
Color bgColor = const Color(0xffffffff);
Color textFieldBorderColor = const Color(0xff222222);
Color buttonColor = const Color(0xff83b941);
Color buttonColorwithopacity = const Color(0xff83B735).withOpacity(0.5);
Color textColor = const Color(0xff222222);
Color errorColor = Colors.red;
Color headerColor = const Color(0xffD9D9D9);
Color headerColor1 = const Color(0xffD9D9D9).withOpacity(0.5);
//Global Form key
GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
GlobalKey<FormState> signupformKey = GlobalKey<FormState>();
GlobalKey<FormState> adminLoginFormkey = GlobalKey<FormState>();
//Text Editing Controllers

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController nameController = TextEditingController();
//admin dahboard controllers
TextEditingController productNameController = TextEditingController();
TextEditingController productPriceController = TextEditingController();
TextEditingController productCategoryController = TextEditingController();
TextEditingController productStockController = TextEditingController();
TextEditingController productColorController = TextEditingController();
TextEditingController productDescriptionController = TextEditingController();

//order editiors
TextEditingController adressController = TextEditingController();
TextEditingController cityController = TextEditingController();
TextEditingController postalcodeController = TextEditingController();
TextEditingController phoneNumController = TextEditingController();
//textstyle of productdetail scren
TextStyle txtstyle = GoogleFonts.playfairDisplay(fontSize: 15);

//
// textfields(
// text: "Adress",
// obsecuretext: false,
// controller: adressController),
// textfields(
// text: "City",
// obsecuretext: false,
// controller: cityController),
// textfields(
// text: "Postal Code",
// obsecuretext: false,
// controller: postalcodeController),
// textfields(
// text: "Phone Number",
// obsecuretext: false,
// controller: phoneNumController)

//slider image list
List slider_images = [
  {"id": 1, "image_path": 'assets/1.jpg'},
  {"id": 2, "image_path": 'assets/2.jpg'},
  {"id": 3, "image_path": 'assets/3.png'},
  {"id": 4, "image_path": 'assets/4.jpg'}
];
final CarouselController carouselController = CarouselController();
