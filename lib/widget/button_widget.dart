import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf_generator/utils/colors.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final double? width;
  final double? height;
  final Color? color;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    this.width,
    this.height,
    this.color,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onClicked,
    child: new Container(
      width: width ?? 345.0,
      height: height ?? 50.0,
      decoration: new BoxDecoration(
        color: color ?? AppColor.btnColor,
        border: new Border.all(color: Colors.black, width: 2.0),
        borderRadius: new BorderRadius.circular(10.0),
      ),
      child: new Center(child: new Text(text, style:  GoogleFonts.roboto(
          fontSize: 13.0,
          fontWeight: FontWeight.w900,
          color: AppColor.btnColorText),),),
    ),
  );
}
