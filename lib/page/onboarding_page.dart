import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf_generator/page/login_page.dart';
import 'package:pdf_generator/utils/colors.dart';
import 'package:pdf_generator/widget/button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}


class _OnboardingPageState extends State<OnboardingPage> {
  void onClicked() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('showLoginPage', true);

    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: screenHeight / 5),
            Image.asset("assets/onboarding.png"),
            SizedBox(height: screenHeight / 14),
            Text("Start creating your\n  professional PDF",style: GoogleFonts.inter(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: AppColor.textColor,
            ),),
            SizedBox(height: screenHeight / 25),
            Text("      Take advantage of the PDF\n template features by personalizing",
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: AppColor.textColor
            ),),
            SizedBox(height: screenHeight / 20),
            ButtonWidget(text: "CREATE NOW!", onClicked: onClicked)
          ],
        ),
      )
    );
  }
}
