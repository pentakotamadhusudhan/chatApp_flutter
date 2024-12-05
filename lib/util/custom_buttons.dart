import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


Widget submitButton(
{
  required String label,
  required VoidCallback onpressed,
  double width = 200.0,
}
    ){
  return SizedBox(
    height: 40,
    width: width,
    child: ElevatedButton(
      onPressed: onpressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue),
      child: Text(
        label,
        style: GoogleFonts.aBeeZeeTextTheme()
            .headlineLarge!
            .copyWith(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: Colors.white),
      ),
    ),
  );
}