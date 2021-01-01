import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme buildNunitoTextTheme(BuildContext context) {
  return GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme.copyWith(
      // book title in list
      headline1: TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black),
      // authors
      headline2: TextStyle(
          fontSize: 14.5,
          fontWeight: FontWeight.normal,
          color: Colors.grey[700]),
      // book title in the details page
      headline3: TextStyle(
          fontSize: 22.0, fontWeight: FontWeight.w600, color: Colors.black),
      // book description in the details page
      bodyText1: TextStyle(fontSize: 16, color: Colors.black),
      // app bar title
      headline4: TextStyle(fontSize: 18, color: Colors.white),
      bodyText2: TextStyle(fontSize: 14, color: Colors.black)));
}
