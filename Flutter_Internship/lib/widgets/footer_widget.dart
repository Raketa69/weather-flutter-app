import 'dart:core';
import 'package:flutter/material.dart';

class FooterWidget extends StatefulWidget {
  const FooterWidget({Key? key}) : super(key: key);

  @override
  State<FooterWidget> createState() => _FooterWidget();

}

late double vh;
late double vw;

class _FooterWidget extends State<FooterWidget> {


  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year);
    String year = date.year.toString();
    vh = MediaQuery
        .of(context)
        .size
        .height;
    vw = MediaQuery
        .of(context)
        .size
        .width;

    return Container(
      height:   0.14*vh,
      width: vw,
      child: Center(
        child: Text('Vladyslav Rokytenko - $year'),
      )

    );
  }
}
