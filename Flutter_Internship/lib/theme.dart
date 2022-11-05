import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final kDarkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.brown,
    backgroundColor:  Colors.brown,
        
  /*appBarTheme: AppBarTheme(
    backgroundColor: Colors.brown,
    color: Colors.brown,
  )*/
);
//final textTheme = Theme.of(context).textTheme;

final kLightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.brown,
    backgroundColor:  Colors.brown,
   // textTheme: GoogleFonts.robotoTextTheme(),
    /*textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
    body1: GoogleFonts.oswald(textStyle: textTheme.body1),*/
  );
  /*appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        color: Colors.white,

    )*/

