import 'dart:core';
import 'package:flutter/material.dart';

class CitiesWidget extends StatefulWidget {
  const CitiesWidget({Key? key}) : super(key: key);

  @override
  State<CitiesWidget> createState() => _CitiesWidget();

}

List namesCities = ['New York', 'London', 'Dubai', 'Paris'];
List assetsCities = ['assets/city_ny.png', 'assets/city_london.png', 'assets/city_dubai.png', 'assets/city_paris.png'];

late double vh;
late double vw;

class _CitiesWidget extends State<CitiesWidget> {

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

    return SizedBox(
      height: 1.7*vh,
      width: vw,
      child: Column(
        children: const [
          Padding(
            padding: EdgeInsets.only(top: 70, bottom: 35),
            child: Text('Check the weather in most \n popular cities in the world',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold
            ),
          )
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: CityWidget()),
          Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: CityWidget()),
          Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: CityWidget()),
          Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: CityWidget()),
        ],
      ),
    );
  }
}

class CityWidget extends StatefulWidget {

  const CityWidget({Key? key}) : super(key: key);

  @override
  State<CityWidget> createState() => _CityWidget();
}

int index = 0;
int i = -1;
class _CityWidget extends State<CityWidget> {

  @override
  Widget build(BuildContext context) {
    i = 0; // -!- ЗАБРАТЬ
   // ++i;
    //print(namesCities[i]);
    //print(assetsCities[i]);

    return Container(
      height: vh* 0.32,
      width: vw * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        image: DecorationImage(
            image: AssetImage(assetsCities[i]),fit:BoxFit.cover
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 14),
            child: Container(
              height: 36,
              width: 323,
              child:
              MaterialButton(onPressed: () {  },
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: const BorderSide(color: Colors.white),
                ),
                child: Text(namesCities[i], style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal
                ),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}