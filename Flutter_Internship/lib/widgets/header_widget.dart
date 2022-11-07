import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_internship/api/fetch_weather.dart';
import 'package:flutter_internship/model/weather_data.dart';
import 'package:flutter_internship/controlers/keyboard_listener.dart'
    as Keyboard;
import 'package:jiffy/jiffy.dart';
import 'dart:ui';
import 'package:flutter/widgets.dart';
import '../model/deafault_weather.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  State<HeaderWidget> createState() => _HeaderWidget();
}

class _HeaderWidget extends State<HeaderWidget> {
  _HeaderWidget();

  var tempText;
  late double vh;
  late double vw;
  FetchWeatherAPI client = FetchWeatherAPI();
  Weather? data;
  List<Weather>? dataList;
  final DefaultWeather _defaultWeather = DefaultWeather();
  bool _isShowKeyboard = false;
  final _searchController = TextEditingController();
  String defaultNum = "City not found, please try to change your search query";
  var tmpCityName = [];
  ScrollController scrollController = ScrollController();
  bool showBtn = false;
  var resultList = [];

  final Keyboard.KeyboardListener _keyboardListener =
      Keyboard.KeyboardListener();
  List namesCities = ['New York', 'London', 'Dubai', 'Paris'];
  List assetsCities = [
    'assets/city_ny.png',
    'assets/city_london.png',
    'assets/city_dubai.png',
    'assets/city_paris.png'
  ];

  void _searchCities() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      getNewCities(query);
    }
    setState(() {
      resultList = resultList;
      tmpCityName = resultList;
    });
  }

  @override
  void initState() {
    scrollController.addListener(() {
      double showoffset =
          10.0;

      if (scrollController.offset > showoffset) {
        showBtn = true;
        setState(() {
        });
      } else {
        showBtn = false;
        setState(() {
        });
      }
    });
    super.initState();
    setDefaultWeather();
    _searchController.addListener(_searchCities);
    _keyboardListener.addListener(onChange: (bool isVisible) {
      setState(() {
        _isShowKeyboard = isVisible;
      });
    });
  }

  @override
  void dispose() {
    _keyboardListener.dispose();
    super.dispose();
  }

  Future<void> getNewCities(String city) async {
    try {
      var tmpData = await client.getCurrentWeatherListCities(city);
      print('$tmpData');
      if (tmpData != []) {
        resultList = [
          for (var item in tmpData) "${item['name']}, ${item['sys']['country']}"
        ];
      }
      if (resultList.length > 4) {
        resultList.length = 4;
      }
      for (var item in resultList) {
        print(item);
      }
    } catch (e) {
      print(e.runtimeType);
    }
  }

  Future<void> getNewData(String city) async {
    data = await client.getCurrentWeather(city);
    if (city.isNotEmpty) {
      try {
        print('$data');
      } catch (e) {
        print(e.runtimeType);
      }
      setState(() {
        data = data;
      });
    }
    if (data?.name == null) {
      setDefaultWeather();
      setState(() {
        setDefaultWeather();
      });
    }
  }

  void setDefaultWeather() {
    data = _defaultWeather;
  }

  void _scrollToTop() {
    scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    vh = MediaQuery.of(context).size.height;
    vw = MediaQuery.of(context).size.width;
    return Column(children: [
      Container(
        height: vh * 1,
        width: vw,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/hero_bg.png'), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            searchCity(),
          ],
        ),
      ),
      popularCity(),
    ]);
  }

  Widget popularCity() {
    return SizedBox(
      height: 1.7 * vh,
      width: vw,
      child: Column(
        children: [
          const Padding(
              padding: EdgeInsets.only(top: 70, bottom: 35),
              child: Text(
                  'Check the weather in most \n popular cities in the world',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ))),
          Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: popularCity1(assetsCities[0], namesCities[0])),
          Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: popularCity1(assetsCities[1], namesCities[1])),
          Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: popularCity1(assetsCities[2], namesCities[2])),
          Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: popularCity1(assetsCities[3], namesCities[3])),
        ],
      ),
    );
  }

  Widget weatherInfo() {
    return (Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
      ),
      height: vh * 0.5,
      child: Column(children: [
        Row(children: [
          Image(
            height: 100,
            width: 100,
            image: AssetImage('assets/${data?.icon}.png'),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      '${data?.temp?.round()} °C',
                      style:
                          const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text('${data?.main}',
                        style: const TextStyle(
                          fontSize: 16,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text('${data?.description}',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey)),
                  ),
                ],
              )),
        ]),
        cityDate(),
        Container(
            margin: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: const Divider(
              color: Colors.black,
              height: 50,
            )),
        minMaxTemp()
      ]),
    ));
  }


  Widget searchBar() {
    return (TextField(
      controller: _searchController,
      onSubmitted: (text) {
        if (text.isNotEmpty) {
          getNewData(_searchController.text);
          setState(() {
            getNewData(_searchController.text);
          });
        }
      },
      onChanged: (text) {
        _isShowKeyboard = true;
        if (text.isNotEmpty) {
          setState(() {
            tempText = text;
            print('PRINT STATE $tempText');
            if (text.isNotEmpty) getNewCities(text);
          });
        }
      },
      decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              if (tempText != null) {
                setState(() {
                  getNewData(tempText);
                });
              }
              _isShowKeyboard = false;
            },
            icon: const Icon(Icons.search),
            color: Colors.blue,
          ),
          hintStyle: const TextStyle(color: Colors.grey),
          hintText: "Start typing to search...",
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
            borderRadius: BorderRadius.circular(30.0),
          ),
          filled: true,
          fillColor: Colors.white),
    ));
  }

  Widget itemCitiesList(String newCity) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Container(
            width: 340,
            decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(30.0)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: MaterialButton(
                onPressed: () {
                  getNewData(newCity);
                  _isShowKeyboard = false;
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.0)),
                elevation: 18.0,
                splashColor: const Color.fromRGBO(144, 202, 249, 50),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    newCity,
                    style: const TextStyle(fontSize: 16), textAlign: TextAlign.left,
                  ),
                ),
              ),
            )));
  }

  Widget notFoundWidget() {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Center(
        child: Text(
          notFoundString,
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      ),
    );
  }

  String notFoundString =
      'City not found, please try to change your search query.';

  Widget citiesList() {
    return (Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(30.0)),
      height: 37 * (resultList.length + 1),
      width: 343,
      child: ListView(
        scrollDirection: Axis.vertical,
        itemExtent: 40,
        children: resultList == null || resultList.isEmpty
            ? [notFoundWidget()]
            : [for (var item in resultList) itemCitiesList(item)],
      ),
    ));
  }

  Widget searchCity() {
    return Container(
      width: vw,
      height: vh,
      child: Stack(
        children: [
          Positioned(
            left: vw * 0.03,
            right: vw * 0.03,
            top: 100,
            child: searchBar(),
          ),
          Positioned(
              top: 240,
              left: vw * 0.03,
              right: vw * 0.03,
              child: Opacity(
                opacity: 0.85,
                child: weatherInfo(),
              )),
          Positioned(
              top: 170,
              left: vw * 0.03,
              right: vw * 0.03,
              child: Opacity(
                opacity: _isShowKeyboard ? 1.0 : 0.0,
                //opacity: 1.0,
                child: citiesList(),
              )),
        ],
      ),
    );
  }

  Widget cityDate() {
    var date = Jiffy(DateTime.now()).yMMMMd;
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(30, 20, 0, 10),
            child: Text('${data?.name}, ${data?.country}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 30, 10),
            child:
                Text(date, style: const TextStyle(fontSize: 18, color: Colors.grey)),
          ),
        ]);
  }

  Widget minMaxTemp() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              const Text(
                'Min',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  '+${data?.tempMin?.round()} °C',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 50, child: VerticalDivider(color: Colors.black)),
          Column(
            children: [
              const Text(
                'Max',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  '+${data?.tempMax?.round()} °C',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void setCity(text) {
    setState(() {
      getNewData(text);
    });
  }

  Widget popularCity1(String url, String nameCity) {
    return Container(
      height: vh * 0.32,
      width: vw * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        image: DecorationImage(image: AssetImage(url), fit: BoxFit.cover),
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
              child: MaterialButton(
                onPressed: () {
                  setState(() {});

                  print('namesCities: {$nameCity}');
                  getNewData(nameCity.toString());
                },
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: const BorderSide(color: Colors.white),
                ),
                child: Text(
                  nameCity,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}