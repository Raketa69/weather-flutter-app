import 'package:flutter/material.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  State<HeaderWidget> createState() => _HeaderWidget();

}

class _HeaderWidget extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/hero_bg.png'),fit:BoxFit.cover
        ),
      ),
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(16, 130, 16, 50),
          child: TextField(
            decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey),
                hintText: "Start typing to search...",
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
              filled: true,
              fillColor: Colors.white
            ),
          ),
          )

        ],
      ),
    );
  }


}