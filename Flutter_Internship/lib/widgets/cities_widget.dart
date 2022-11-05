import 'package:flutter/material.dart';

class CitiesWidget extends StatefulWidget {
  const CitiesWidget({Key? key}) : super(key: key);

  @override
  State<CitiesWidget> createState() => _CitiesWidget();

}

class _CitiesWidget extends State<CitiesWidget> {

  late double vh;
  late double vw;

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
      height: 2*vh,
      width: vw,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 70, bottom: 35),
            child: Text('Check the weather in most \n popular cities in the world',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold
            ),
          )
          ),
          Container(
            height: vh* 0.32,
            width: vw * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              image: const DecorationImage(
                  image: AssetImage('assets/city_ny.png'),fit:BoxFit.cover
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
                            side: BorderSide(color: Colors.white),
                            ),
                            child: const Text('New York', style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal
                          ),),

                        ),
                    ),
                ),
              ],
            ),
          )
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

class _CityWidget extends State<CityWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}