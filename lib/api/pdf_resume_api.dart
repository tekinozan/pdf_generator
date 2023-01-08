import 'dart:math';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf_generator/api/pdf_api.dart';

import '../model/resume.dart';


const PdfColor green = PdfColor.fromInt(0xff9ce5d0);
const PdfColor lightGreen = PdfColor.fromInt(0xffcdf1e7);
const sep = 120.0;

class PdfResumeApi {
  static Future<File> generateResume(PdfPageFormat format, Resume resume) async {
    final pdf = pw.Document();


    final pageTheme = await _myPageTheme(format);

    pdf.addPage(
      pw.MultiPage(
        pageTheme: pageTheme,
        build: (pw.Context context) =>
        [
          pw.Partitions(
            children: [
              pw.Partition(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: <pw.Widget>[
                    pw.Container(
                      padding: const pw.EdgeInsets.only(left: 30, bottom: 20),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: <pw.Widget>[
                          pw.Text(resume.info.nameSurname,
                              textScaleFactor: 2,
                              style: pw.Theme
                                  .of(context)
                                  .defaultTextStyle
                                  .copyWith(fontWeight: pw.FontWeight.bold)),
                          pw.Padding(padding: const pw.EdgeInsets.only(top: 10)),
                          pw.Text(resume.info.job,
                              textScaleFactor: 1.2,
                              style: pw.Theme.of(context)
                                  .defaultTextStyle
                                  .copyWith(
                                  fontWeight: pw.FontWeight.bold,
                                  color: green)),
                          pw.Padding(padding: const pw.EdgeInsets.only(
                              top: 20)),
                          pw.Row(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            mainAxisAlignment: pw.MainAxisAlignment
                                .spaceBetween,
                            children: <pw.Widget>[
                              pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: <pw.Widget>[
                                  pw.Text(resume.info.address),
                                ],
                              ),
                              pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: <pw.Widget>[
                                  pw.Text(resume.info.pNumber),
                                  _UrlText(resume.info.email,
                                      'mailto:${resume.info.email}'),
                                ],
                              ),
                              pw.Padding(padding: pw.EdgeInsets.zero)
                            ],
                          ),
                        ],
                      ),
                    ),
                    _Category('Skills'),
                    _Skills(resume),
                    _Category('Work Experience'),
                    _WorkExperience(resume),
                    pw.SizedBox(height: 20),
                    _Category('Education'),
                    _EducationExperience(resume),
                  ],
                ),
              ),
              pw.Partition(
                width: sep,
                child: pw.Column(
                  children: [
                    pw.Container(
                      height: pageTheme.pageFormat.availableHeight,
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: <pw.Widget>[
                          pw.SizedBox(height: 0.8 * PdfPageFormat.cm),
                          pw.BarcodeWidget(
                            data: resume.info.nameSurname,
                            width: 60,
                            height: 60,
                            barcode: pw.Barcode.qrCode(),
                            drawText: false,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
    return PdfApi.saveDocument(name: "name", pdf: pdf);
  }

  static Future<pw.PageTheme> _myPageTheme(PdfPageFormat format) async {
    final bgShape = await rootBundle.loadString('assets/resume.svg');

    format = format.applyMargin(
        left: 2.0 * PdfPageFormat.cm,
        top: 4.0 * PdfPageFormat.cm,
        right: 2.0 * PdfPageFormat.cm,
        bottom: 2.0 * PdfPageFormat.cm);
    return pw.PageTheme(
      pageFormat: format,
      buildBackground: (pw.Context context) {
        return pw.FullPage(
          ignoreMargins: true,
          child: pw.Stack(
            children: [
              pw.Positioned(
                child: pw.SvgImage(svg: bgShape),
                left: 0,
                top: 0,
              ),
              pw.Positioned(
                child: pw.Transform.rotate(
                    angle: pi, child: pw.SvgImage(svg: bgShape)),
                right: 0,
                bottom: 0,
              ),
            ],
          ),
        );
      },
    );
  }

  static pw.Container _Category(String title) {
    return pw.Container(
      decoration: const pw.BoxDecoration(
        color: lightGreen,
        borderRadius: pw.BorderRadius.all(pw.Radius.circular(6)),
      ),
      margin: const pw.EdgeInsets.only(bottom: 10, top: 20),
      padding: const pw.EdgeInsets.fromLTRB(10, 4, 10, 4),
      child: pw.Text(
        title,
        textScaleFactor: 1.5,
      ),
    );
}



static pw.UrlLink _UrlText(String text, String url) {

    return pw.UrlLink(
      destination: url,
      child: pw.Text(text,
          style: const pw.TextStyle(
            decoration: pw.TextDecoration.underline,
            color: PdfColors.blue,
          )),
    );
}

static pw.Table _WorkExperience(Resume resume){
  final headers = [
    'Company Name',
    'Position',
    'Start Date',
    'End Date',
  ];

    final data = resume.workExperience.map((item) {
      return [
        item.companyName,
        '${item.position}',
        '${item.startDate}',
        '${item.endDate} ',
      ];
    }).toList();
    return pw.Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerDecoration: pw.BoxDecoration(color: PdfColors.grey50),
      headerAlignment: pw.Alignment.centerLeft,
      cellHeight: 30,
    );

}

static pw.Table _EducationExperience(Resume resume) {
  final headers = [
    'School Name',
    'Departmant',
    'Start Date',
    'End Date',
  ];
    final data = resume.education.map((item) {
      return [
        item.schoolName,
        '${item.departmant}',
        '${item.startDate}',
        '${item.endDate} ',
      ];
    }).toList();
    return pw.Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerDecoration: pw.BoxDecoration(color: PdfColors.grey50),
      headerAlignment: pw.Alignment.centerLeft,
      cellHeight: 30,
    );
}
  static pw.Container _Skills(Resume resume) {
    return pw.Container(
      decoration: const pw.BoxDecoration(
          border: pw.Border(left: pw.BorderSide(color: green, width: 2))),
      padding: const pw.EdgeInsets.only(left: 10, top: 5, bottom: 5),
      margin: const pw.EdgeInsets.only(left: 5),
      child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: <pw.Widget>[
            pw.Text(resume.skills.description),
          ]),
    );
  }

}




