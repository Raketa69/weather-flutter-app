import 'package:flutter/material.dart';
import 'package:faq/faq.dart';

class FAQ extends StatefulWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  State<FAQ> createState() => _FAQ();

}

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class _FAQ extends State<FAQ> {
  late double vh;
  late double vw;

  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {

    vh = MediaQuery
        .of(context)
        .size
        .height;
    vw = MediaQuery
        .of(context)
        .size
        .width;

    return Container(
      height: 0.85*vh,
      width: vw,
      child: Column(
        children: const [
          Padding(
            padding: EdgeInsets.only(top: 50, bottom: 30),
            child: Text('Frequently Asked \n Questions',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold
              ),
            )
          ),
          DropdownButton(),
        ]
      ),
    );
  }
}

class DropdownButton extends StatefulWidget {
  const DropdownButton({Key? key}) : super(key: key);


  @override
  State<DropdownButton> createState() => _DropdownButton();
}

class _DropdownButton extends State<DropdownButton> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return faqList(
      title: 'Expandable List demo',
      data: _generateData(),
    );
  }
  List<List<String>> _generateData() {
    int numberOfGroups = 4;
    List<List<String>> results = <List<String>>[];
    for (int i = 0; i < numberOfGroups; i++) {
      // List<String> items = List<String>();
      // for (int j = 0; j < 1; j++) {
      //   items.add("Item $j in group $i");
      // }
      results.add([
        "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful."
      ]);
    }
    return results;
  }
}