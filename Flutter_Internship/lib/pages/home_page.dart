import 'package:flutter/material.dart';
import 'package:flutter_internship/widgets/header_widget.dart';
import 'package:flutter_internship/widgets/cities_widget.dart';
import 'package:flutter_internship/widgets/faq_widget.dart';
import 'package:flutter_internship/widgets/footer_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:  ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          scrollDirection: Axis.vertical,
          children: const [
            HeaderWidget(),
            FAQ(),
            FooterWidget(),
          ],
        )
    )
    );
  }
}


/*Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage('assets/hero_bg.png'),fit:BoxFit.cover
    ),
    ),
          child: Column(
            children: [
              Text('Text', style: TextStyle(fontSize: 50),),
              Text('Text', style: TextStyle(fontSize: 50),),
            ],
          ),
    )*/




//////////////////////////////////////////////////////////////
/*Container(
        decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/hero_bg.png"),
        fit: BoxFit.cover,
      ),
    ),
    child: null /* add child content here */,
        ),*/



/*child: Row (
          children:
          [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(0.0),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/hero_bg.png"),
                  //fit: BoxFit.cover,
                ),
              ),
              child: const Text(
                'Привет Flutter!',
                textDirection: TextDirection.ltr,
              ),
            ),
          ]
        )*/