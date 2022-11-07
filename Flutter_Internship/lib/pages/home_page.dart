import 'package:flutter/material.dart';
import 'package:flutter_internship/widgets/header_widget.dart';
import 'package:flutter_internship/widgets/faq_widget.dart';
import 'package:flutter_internship/widgets/footer_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ListView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      scrollDirection: Axis.vertical,
      children: const [
        HeaderWidget(),
        FAQ(),
        FooterWidget(),
      ],
    )));
  }
}
