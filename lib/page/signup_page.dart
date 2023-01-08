import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pdf_generator/page/homepage.dart';
import 'package:pdf_generator/utils/user_preferences.dart';
import 'package:pdf_generator/widget/button_widget.dart';
import 'package:pdf_generator/widget/textfield_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user.dart';
import '../utils/colors.dart';
import 'login_page.dart';

class SignUp extends StatefulWidget {
  /*getSavedData() => createState().getSavedData();
  storeData() => createState().storeData();*/
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final user_preferences = UserPreferences();
  final username_controller = TextEditingController();
  final password_controller = TextEditingController();
  final job_controller = TextEditingController();

  SharedPreferences? logindata;
  bool? newuser;

  /*void storeData(){
    final newUser = User(username_controller.text, password_controller.text, job_controller.text);
    print(jsonEncode(newUser));

    user_preferences.saveUser(newUser);

  }

   Future<Map<String, dynamic>> getSavedData() async {
    Map<String, dynamic> userdata = jsonDecode(logindata!.getString('userdata')!);
    return userdata;
  }*/


  void onClicked() async {

    String? username = username_controller.text;
    String? password = password_controller.text;
    String? job = job_controller.text;

    if (username.isNotEmpty && password.isNotEmpty && job.isNotEmpty) {

      logindata?.setBool('login', false);

      logindata?.setString('username', username);

      logindata?.setString('password', password);

      logindata?.setString('job', job);


      //storeData();

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }

  }
  void initState() {
    // TODO: implement initState
    super.initState();
    check_if_already_login();
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
        child: Column(
          children: [
            Container(
              height: screenHeight / 1.5,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: screenHeight / 6),
                      Text("Sign Up",style: GoogleFonts.inter(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColor.textColor
                      ),),
                      CustomTextField(controller: username_controller,hintText: "Enter your username",labelText: "username",),
                      CustomTextField(controller: password_controller,hintText: "Enter your password",labelText: "password",),
                      CustomTextField(controller: job_controller ,hintText: "Your job",labelText: "job",),
                    ],
                  ),
                ),
              ),
            ),
            ButtonWidget(text: "Sign Up", onClicked: onClicked),
            SizedBox(height: screenHeight / 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Already have an account? ",style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500
                ),),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text(
                    "Log in",style: GoogleFonts.poppins(
                    fontSize: 12, fontWeight: FontWeight.bold,color: HexColor("#FBBD18")
                  ),
                  ),

                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
