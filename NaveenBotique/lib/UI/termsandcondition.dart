import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naveenbotique/Constants/constants.dart';

import '../Widgets/textcontainerss.dart';

class TermsandConditions extends StatefulWidget {
  const TermsandConditions({Key? key}) : super(key: key);

  @override
  State<TermsandConditions> createState() => _TermsandConditionsState();
}

class _TermsandConditionsState extends State<TermsandConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: textColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 50 / MediaQuery.of(context).devicePixelRatio,
              ),
              Text(
                "Privacy Policy",
                style: GoogleFonts.playfairDisplaySc(
                    color: buttonColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              SizedBox(
                height: 50 / MediaQuery.of(context).devicePixelRatio,
              ),
              const textheadingcontainer(
                text: 'Introduction',
                fontsize: 20,
              ),
              const textcontainer(
                fontsize: 10,
                text:
                    'This privacy policy (the “Policy”) describes how Naveen Boutique collects, uses, and discloses your personal information when you visit or make a purchase from our website www.naveenboutique.com.',
              ),
              const textheadingcontainer(
                text: 'Personal Information We Collect',
                fontsize: 15,
              ),
              textcontainer(
                  text:
                      'When you visit the Site, we collect certain information about your device, including your IP address, browser type, operating system, and referring pages. We also collect information about the pages you visit on the Site, the products you view or add to your shopping cart, and the actions you take on the Site (such as clicking on links).We collect this information using cookies and other tracking technologies. For more information about cookies, please see the “Cookies” section below.',
                  fontsize: 10),
              textheadingcontainer(
                  text: 'How We Use Your Personal Information', fontsize: 10),
            ],
          ),
        ),
      ),
    );
  }
}
