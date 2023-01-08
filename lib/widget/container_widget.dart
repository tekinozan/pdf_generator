import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf_generator/utils/colors.dart';

class ContainerWidget extends StatelessWidget {
  final double height;
  final Widget widget;
  final String? header;

  const ContainerWidget({
    Key? key,
    required this.height, required this.widget, this.header,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(header!, style: GoogleFonts.manrope(
        fontWeight: FontWeight.bold,
        fontSize: 14
      ),),
      SizedBox(height: 10),
      Container(
        height: height,
        width: MediaQuery.of(context).size.width,
        decoration: new BoxDecoration(
          color: AppColor.editPageBox,
          border: new Border.all(color: Colors.black, width: 1.2),
          borderRadius: new BorderRadius.circular(15.0),
        ),
        child: widget,
      ),
    ],
  );
}
