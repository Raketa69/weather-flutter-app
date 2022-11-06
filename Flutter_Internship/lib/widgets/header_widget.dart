import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_internship/api/fetch_weather.dart';
import 'package:flutter_internship/model/weather_data.dart';
import 'package:jiffy/jiffy.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  State<HeaderWidget> createState() => _HeaderWidget();

}

class _HeaderWidget extends State<HeaderWidget> {

  late double vh;
  late double vw;
  FetchWeatherAPI client = FetchWeatherAPI();
  Weather? data;

 Future<void> getData() async {
    //data = await client.getCurrentWeather('London');
    setState(() {
      data = data;
    });
  }
  Future<void> getNewData(String city) async {
    data = await client.getCurrentWeather(city);
    setState(() {
      data = data;
    });
  }
  /*void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }
    (context as Element).visitChildren(rebuild);
  }*/

  @override
  Widget build(BuildContext context) {

    vh = MediaQuery.of(context).size.height;
    vw = MediaQuery.of(context).size.width;
    //getData();

    return Container(
            height: vh,
            width: vw,
            decoration:  BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/hero_bg.png'),fit:BoxFit.cover
              ),
            ),
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(16, vh * 0.2, 16, 50),
                  child: TextField(
                    onSubmitted: (text) {
                        setState(() {
                          getNewData(text);
                        });
                      },
                    decoration: InputDecoration(
                        hintStyle:  TextStyle(color: Colors.grey),
                        hintText: "Start typing to search...",
                        border: OutlineInputBorder(
                          borderSide:  BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      filled: true,
                      fillColor: Colors.white
                    ),
                  ),
                ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, vh*0.07 , 16, 0),
                child: Container(
                  decoration:BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  height: vh * 0.5,
                  child: Column(
                      children: [
                        Row(
                            children: [
                                 Image(
                                  height: 100,
                                  width: 100,
                                  image: AssetImage('assets/cloud.png'),),
                                Padding(padding:  EdgeInsets.fromLTRB(20, 20, 0, 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(padding:  EdgeInsets.all(5),
                                        child: Text('${data?.temp?.round()} °C' ,
                                          style:  TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold
                                        ),),
                                      ),
                                      Padding(padding:  EdgeInsets.all(5),
                                        child: Text('${data?.main}',
                                            style:  TextStyle(
                                            fontSize: 16,)),
                                      ),
                                      Padding(padding:  EdgeInsets.all(5),
                                      child: Text('${data?.description}',
                                          style:  TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey)),
                                      ),
                                    ],
                                  )),
                              ]
                        ),
                        cityDate(),
                        Container(
                            margin:  EdgeInsets.only(left: 30.0, right: 30.0),
                            child:  Divider(
                              color: Colors.black,
                              height: 50,
                            )),
                        minMaxTemp()
                      ]
                    ),
                  )
                ),
                ],
            ),
          );
  }

  Widget cityDate() {
    var date = Jiffy(DateTime.now()).yMMMMd;
    print(date);
   return Row(
       crossAxisAlignment: CrossAxisAlignment.start,
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
         Padding(padding:  EdgeInsets.fromLTRB(30, 20, 0, 10),
           child: Text('${data?.name}, ${data?.country}',
               style:  TextStyle(
                 fontWeight: FontWeight.bold,
                 fontSize: 18,)),
         ),
         Padding(padding:  EdgeInsets.fromLTRB(0, 20, 30, 10),
           child: Text(date,
               style:  TextStyle(
                   fontSize: 18,
                   color: Colors.grey)),
         ),
       ]
   );
  }

  Widget minMaxTemp(){
    return Padding(
      padding:  EdgeInsets.fromLTRB(30, 10, 30, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
               Text('Min' , style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey
              ),),
              Padding(
                padding:  EdgeInsets.all(5.0),
                child: Text('+${data?.tempMin?.round()} °C', style:  TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),),
              ),
            ],
          ),
           SizedBox(height: 50, child: VerticalDivider(color: Colors.black)),
          Column(
            children: [
               Text('Max' , style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey
              ),),
              Padding(
                padding:  EdgeInsets.all(5.0),
                child: Text('+${data?.tempMax?.round()} °C', style:  TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

