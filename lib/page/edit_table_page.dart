import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pdf_generator/widget/button_widget.dart';
import 'package:pdf_generator/widget/edit_page_textfield_widget.dart';

import '../api/pdf_api.dart';
import '../api/pdf_table_api.dart';
import '../utils/colors.dart';
import '../widget/container_widget.dart';

class EditTable extends StatefulWidget {
  const EditTable({Key? key}) : super(key: key);

  @override
  State<EditTable> createState() => _EditTableState();
}
TextEditingController tableName = new TextEditingController();
TextEditingController headers = new TextEditingController();
TextEditingController row_data = new TextEditingController();

String _startValue = '#000000';
var colors = {
  'Black': '#000000',
  'Red': '#ff0a00',
  'Blue': '#1d0ed1',
};



class _EditTableState extends State<EditTable> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar( //appbar widget on Scaffold
        title:Text("Edit PDF - Table",style: TextStyle(fontSize: 16,color: Colors.black),), //title aof appbar
        backgroundColor: Colors.white, //background color of appbar
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0,right: 5.0,left: 5.0),
          child: Column(
            children: [
              ContainerWidget(
                header: "",
                height: 400,
                widget: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EditPageTextField(controller: tableName,hintText: "Name",labelText: "Table Name" , width: 100),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          EditPageTextField(controller: headers,hintText: "Enter the items seperated by comma",labelText: "Header Names" , width: 300),
                          ClipOval(
                            child: Material(
                              color: Colors.amber, // Button color
                              child: InkWell(
                                splashColor: Colors.grey, // Splash color
                                onTap: () async {
                                  PdfTableApi.addHeaders(headers.text);
                                },
                                child: SizedBox(width: 24, height: 24, child: Icon(Icons.add)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          EditPageTextField(controller: row_data,hintText: "Enter the row datas by comma and click the add button for each",labelText: "Row Data" , width: 300),
                          ClipOval(
                            child: Material(
                              color: Colors.amber, // Button color
                              child: InkWell(
                                splashColor: Colors.grey, // Splash color
                                onTap: () async {
                                  PdfTableApi.addRows(row_data.text);
                                  row_data.clear();
                                },
                                child: SizedBox(width: 24, height: 24, child: Icon(Icons.add)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight / 50 ),
                      Row(
                        children: [
                          Text("Border Color: ",style: TextStyle(fontWeight: FontWeight.bold),),
                          DropdownButton(
                            items: colors
                                .map((description, value) {
                              return MapEntry(
                                  description,
                                  DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(description),
                                  ));
                            })
                                .values
                                .toList(),
                            value: _startValue,
                            onChanged: (newValue) {
                              if (newValue != null) {
                                setState(() {
                                  _startValue = newValue;
                                  print(_startValue);
                                });
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight / 30 ),
                      Row(
                        children: [
                          SizedBox(width: 32, height: 32, child: Icon(Icons.info,color: Colors.amber,)),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.3,
                            height: screenHeight / 10,
                            decoration: BoxDecoration(
                              color: HexColor("#EFEFEF"),
                              borderRadius: BorderRadius.circular(5.0)
                            ),
                            child: Center(
                              child: Text("After clicking the add button, Enter your\nnew row datas. ",style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w500
                              ),),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight / 8),
              ButtonWidget(text: "CREATE TABLE", onClicked: () async {
                PdfTableApi.tableName(tableName.text);
                PdfTableApi.chooseColor(_startValue);
                final pdfFile = await PdfTableApi.generateTable();
                PdfApi.openFile(pdfFile);
                tableName.clear();
                headers.clear();
                PdfTableApi.clearLists();
              })
            ],
          ),
        ),
      ),
    );
  }
}
