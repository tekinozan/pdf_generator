import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class FolderCard extends StatelessWidget {
  const FolderCard({
    super.key,
    required this.borderColor,required this.text, required this.textColor,
  });

  final Color borderColor;

  final String text;

  final Color textColor;


  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            heightFactor: .9,
            alignment: Alignment.centerLeft,
            child: Container(
              height: 30,
              width: 70,
              decoration: BoxDecoration(
                color: borderColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(8),
                ),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
          //-----------------------------
          // Card Body
          //-----------------------------
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: borderColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 10.0,
                      offset: Offset(0, 2)
                    ),
                  ]
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Text(text,style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: textColor
                  ),),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}