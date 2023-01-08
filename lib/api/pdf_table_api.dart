import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf_generator/api/pdf_api.dart';



final dataTable = [];
var headers = [];
var name;
var color;

class PdfTableApi {
  static List addRows(String text){
    var list = text.split(',');
    dataTable.add(list);
    return dataTable;
  }
  static List addHeaders(String text){
    headers = text.split(',');
    return headers;
  }
  static String tableName(String text){
    name = text;
    return name;
  }
  static String chooseColor(String text){
    color = text;
    return color;
  }
  static void clearLists(){
    dataTable.clear();
    headers.clear();
  }
  static Future<File> generateTable() async {
    final pdf = pw.Document();
    pdf.addPage(pw.Page(
        build: (context) => pw.Center(child: pw.Column(
            children: [
              pw.Text(name.toUpperCase(),style: pw.TextStyle(
                fontSize: 24
              )),
              pw.SizedBox(height: 30),
            pw.Table.fromTextArray(
          border: pw.TableBorder.all(
            color: PdfColor.fromHex(color),
          ),
          headers: headers,
          data: List<List<dynamic>>.generate(
            dataTable.length,
                (index) => <dynamic>[
              for(int i = 0 ; i < headers.length  ; i++)
                dataTable[index][i],
            ],
          ),
        )]))));

    return PdfApi.saveDocument(name: name , pdf: pdf);
  }


}