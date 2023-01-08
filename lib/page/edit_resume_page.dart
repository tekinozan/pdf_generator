import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf_generator/api/pdf_resume_api.dart';
import 'package:pdf_generator/model/resume.dart';
import 'package:pdf_generator/widget/button_widget.dart';

import '../api/pdf_api.dart';
import '../utils/colors.dart';
import '../widget/container_widget.dart';
import '../widget/edit_page_textfield_widget.dart';

class EditResume extends StatefulWidget {
  const EditResume({Key? key}) : super(key: key);

  @override
  State<EditResume> createState() => _EditResumeState();
}

List<WorkExperience> _workExperience = [];
List<Education> _education = [];
int countWorks = _workExperience.length;
int countEducations = _education.length;


TextEditingController nameSurname = TextEditingController();
TextEditingController job = TextEditingController();
TextEditingController email = TextEditingController();
TextEditingController pnumber = TextEditingController();
TextEditingController address = TextEditingController();
TextEditingController companyName = TextEditingController();
TextEditingController position = TextEditingController();
TextEditingController startDate = TextEditingController();
TextEditingController endDate = TextEditingController();
TextEditingController schoolName = TextEditingController();
TextEditingController departmant = TextEditingController();
TextEditingController edstartDate = TextEditingController();
TextEditingController edEndDate = TextEditingController();
TextEditingController skills = TextEditingController();

class _EditResumeState extends State<EditResume> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar( //appbar widget on Scaffold
        title:Text("Edit PDF - Resume",style: TextStyle(fontSize: 16,color: Colors.black),), //title aof appbar
        backgroundColor: Colors.white, //background color of appbar
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              ContainerWidget(
                  height: 300,
                  header: 'Information',
                  widget: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            EditPageTextField(controller: nameSurname, width: 125, labelText: "Name Surname",),
                            EditPageTextField(controller: job, width: 125, labelText: "Job",),
                          ],
                        ),
                        EditPageTextField(controller: email, width: 300, labelText: "E-mail address", keyboardType: TextInputType.emailAddress),
                        EditPageTextField(controller: pnumber, width: 300, labelText: "Phone Number", keyboardType: TextInputType.phone),
                        EditPageTextField(controller: address, width: 300, labelText: "Address",)
                      ],
                    ),
                  )),
              SizedBox(height: screenHeight / 15),
              ContainerWidget(
                  height: 350,
                  header: 'Work Experience',
                  widget: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        EditPageTextField(controller: companyName,labelText: "Company Name"),
                        EditPageTextField(controller: position, labelText: "Position"),
                        EditPageTextField(controller: startDate, labelText: "Start Date", keyboardType: TextInputType.datetime,),
                        EditPageTextField(controller: endDate, labelText: "End Date",keyboardType: TextInputType.datetime),
                        SizedBox(height: screenHeight / 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ButtonWidget(text: "+Add experience",color: Colors.amberAccent, width: 200,  height: 30, onClicked: () async {
                              _workExperience.add(
                                  WorkExperience(companyName: companyName.text, position: position.text, startDate: startDate.text, endDate: endDate.text ?? "-"));
                              setState(() {
                                countWorks = _workExperience.length;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("You have added an item",textAlign: TextAlign.center,),)
                              );
                              companyName.clear();
                              position.clear();
                              startDate.clear();
                              endDate.clear();
                            }),
                            ButtonWidget(text: "Remove", onClicked: (){
                              _workExperience.removeLast();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Last item adedd",textAlign: TextAlign.center,),backgroundColor: Colors.redAccent,)
                              );
                              setState(() {
                              countWorks = _workExperience.length;
                            });},color: Colors.redAccent,width: 55,height: 30,)
                          ],
                        ),
                        SizedBox(height: screenHeight / 100),
                        Text("Added work exp.: ${countWorks}",style: TextStyle(fontWeight: FontWeight.bold),)
                      ],
                    ),
                  )),
              SizedBox(height: screenHeight / 15),
              ContainerWidget(
                  height: 350,
                  header: 'Education',
                  widget: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        EditPageTextField(controller: schoolName,labelText: "School Name"),
                        EditPageTextField(controller: departmant, labelText: "Department"),
                        EditPageTextField(controller: edstartDate, labelText: "Start Date", keyboardType: TextInputType.datetime),
                        EditPageTextField(controller: edEndDate, labelText: "End Date", keyboardType: TextInputType.datetime),
                        SizedBox(height: screenHeight / 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ButtonWidget(text: "+Add experience",color: Colors.amberAccent, width: 200,  height: 30, onClicked: () async {
                              _education.add(
                                  Education(schoolName: schoolName.text, departmant: departmant.text, startDate: edstartDate.text, endDate: edEndDate.text));
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("You have added an item",textAlign: TextAlign.center,),)
                              );
                              setState(() {
                                countEducations = _education.length;
                              });
                              schoolName.clear();
                              departmant.clear();
                              edstartDate.clear();
                              edEndDate.clear();
                            }),
                            ButtonWidget(text: "Remove", onClicked: (){
                              _education.removeLast();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Last item removed",textAlign: TextAlign.center,),backgroundColor: Colors.redAccent,)
                              );
                              setState(() {
                                countEducations = _education.length;
                            });},color: Colors.redAccent,width: 55,height: 30,)
                          ],
                        ),
                        SizedBox(height: screenHeight / 100),
                        Text("Added education exp.: ${countEducations}",style: TextStyle(fontWeight: FontWeight.bold),)
                      ],
                    ),
                  )),
              SizedBox(height: screenHeight / 15),
              Text('Skills', style: GoogleFonts.manrope(
                  fontWeight: FontWeight.bold,
                  fontSize: 14
              ),),
              TextField(
                controller: skills,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.editPageBox,
                    hintText: "Enter your skills e.g = 'Excel, Word, Dart' ",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.redAccent)
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.black)
                    )
                ),

              ),

              SizedBox(height: screenHeight / 15),

              ButtonWidget(text: "CREATE RESUME", onClicked: () async {
                final resume = Resume(
                    info: ContactInfo(nameSurname: nameSurname.text, job: job.text, email: email.text, pNumber: pnumber.text, address: address.text),
                    workExperience: _workExperience,
                    education: _education,
                    skills: Skills(description: skills.text));
                final pdfFile = await PdfResumeApi.generateResume(PdfPageFormat.a4, resume);

                _education.clear();
                _workExperience.clear();
                nameSurname.clear();
                job.clear();
                email.clear();
                pnumber.clear();
                address.clear();
                companyName.clear();
                position.clear();
                startDate.clear();
                endDate.clear();
                schoolName.clear();
                departmant.clear();
                edstartDate.clear();
                edEndDate.clear();
                skills.clear();

                setState(() {
                  countWorks = _workExperience.length;
                  countEducations = _education.length;
                });

                PdfApi.openFile(pdfFile);
              }),
            ],

          ),
        ),
      ),
    );
  }
}
