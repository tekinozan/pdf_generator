import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf_generator/page/login_page.dart';
import 'package:pdf_generator/page/signup_page.dart';
import 'package:pdf_generator/widget/folder_cards_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';
import '../utils/colors.dart';
import '../utils/user_preferences.dart';
import 'edit_invoice_page.dart';
import 'edit_resume_page.dart';
import 'edit_table_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user_preferences = UserPreferences();
  SharedPreferences? logindata;
  String? username;
  String? password;
  String? job;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata?.getString('username')!;
      password = logindata?.getString('password')!;
      job = logindata?.getString('job')!;
    });
  }

  void storeData(){
    final newUser = User(username, password, job);
    print(jsonEncode(newUser));

    user_preferences.saveUser(newUser);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          children: [
            SizedBox(height: screenHeight / 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Welcome back,\n$username!",style: GoogleFonts.inter(
                    fontSize: 24, fontWeight: FontWeight.bold, color: AppColor.textColor
                ),),
                Image.asset("assets/user.jpg")
              ],
            ),
            Divider(color: Colors.amber,thickness: 2, indent: 5, endIndent: 180,),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditInvoicePage() ));
                      },
                      child: SizedBox(
                        height: 150,
                          width: 225,
                          child: FolderCard(borderColor: AppColor.folder1, text: 'Create invoice, and proform ', textColor: AppColor.folder1, )),
                    ),
                    SizedBox(height: screenHeight / 25),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditTable() ));
                      },
                      child: SizedBox(
                          height: 150,
                          width: 225,
                          child: FolderCard(borderColor: AppColor.folder2, text: 'Create table ', textColor: AppColor.folder2, )),
                    ),
                    SizedBox(height: screenHeight / 25),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditResume()));
                      },
                      child: SizedBox(
                          height: 150,
                          width: 225,
                          child: FolderCard(borderColor: AppColor.folder3, text: 'Create resume ', textColor: AppColor.folder3, )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ClipOval(
                          child: Material(
                            color: Colors.red, // Button color
                            child: InkWell(
                              splashColor: Colors.grey, // Splash color
                              onTap: () {
                                logindata?.setBool('login', true);
                                storeData();
                                Navigator.pushReplacement(context,
                                    new MaterialPageRoute(builder: (context) => LoginPage()));
                              },
                              child: SizedBox(width: 56, height: 56, child: Icon(Icons.logout)),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
