import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pdf_generator/page/signup_page.dart';
import 'package:pdf_generator/utils/colors.dart';
import 'package:pdf_generator/widget/button_widget.dart';
import 'package:pdf_generator/widget/textfield_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user.dart';
import '../utils/user_preferences.dart';
import 'homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final user_preferences = UserPreferences();

  SharedPreferences? logindata;
  bool? newuser;
  String? username_check;
  String? password_check;

  final username_controller = TextEditingController();
  final password_controller = TextEditingController();

  void onClicked() async {
    String? username = username_controller.text;
    String? password = password_controller.text;

    print(username_check);
    print(password_check);

    if (username.isNotEmpty && password.isNotEmpty && username == username_check && password == password_check )  {
      logindata?.setBool('login', false);
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
    }
    else{
      print("failed");
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    check_if_already_login();
    initial();
  }

  void initial() async {
    final user =  await user_preferences.getUser();
    setState(() {
      username_check = user.username;
      password_check = user.password;
    });
  }

  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata?.getBool('login') ?? true);

    print(newuser);

    if (newuser == false) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    username_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: screenHeight / 20),
                Image.asset("assets/pdf_icon.jpg",width: 350,height: 300),
                SizedBox(height: screenHeight / 20),
                CustomTextField(controller: username_controller,hintText: "Enter your username",labelText: "username"),
                SizedBox(height: screenHeight / 25),
                CustomTextField(controller: password_controller,hintText: "Enter your password",labelText: "password"),
                SizedBox(height: screenHeight / 15),
                ButtonWidget(text: "LOGIN", onClicked: onClicked),
                SizedBox(height: screenHeight / 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Don't have an account? ",style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500
                    ),),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                      },
                      child: Text(
                        "Sign up",style: GoogleFonts.poppins(
                          fontSize: 12, fontWeight: FontWeight.bold,color: HexColor("#FBBD18")
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
