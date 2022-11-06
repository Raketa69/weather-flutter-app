import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_internship/api/fetch_weather.dart';
import 'package:flutter_internship/model/weather_data.dart';
import 'package:flutter_internship/controlers/keyboard_listener.dart'
    as Keyboard;
import 'package:jiffy/jiffy.dart';
import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:flutter_internship/data/cities_list_data.dart';
import 'cities_widget.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  State<HeaderWidget> createState() => _HeaderWidget();
}

class City {
  String? name;
  String? country;
}

class _HeaderWidget extends State<HeaderWidget> {
  late double vh;
  late double vw;
  FetchWeatherAPI client = FetchWeatherAPI();
  Weather? data;
  bool _isShowKeyboard = false;
  final _cities = citiesListData;
  final _searchController = TextEditingController();
  String defaultNum = "City not found, please try to change your search query";
  late String tmpCityName;
  late List<Map<String, String>> _filterCities = [{'name':'City not found', 'country':'please try to change your search query'}];
  final Keyboard.KeyboardListener _keyboardListener = Keyboard.KeyboardListener();
  List namesCities = ['New York', 'London', 'Dubai', 'Paris'];
  List assetsCities = ['assets/city_ny.png', 'assets/city_london.png', 'assets/city_dubai.png', 'assets/city_paris.png'];

  void _searchCities() {
    final query = _searchController.text;
      if(query.isNotEmpty)
        {
            _filterCities = _cities.where((element) {
              return element.containsValue(query);
            }).toList();
        }
      else {
        //_filterCities = defaultNum;
      }
    tmpCityName = _filterCities[0]['name'].toString() + ', '+ _filterCities[0]['country'].toString();
    print("tmpCityName: " + tmpCityName);
      setState((){
      });
  }

  @override
  void initState() {
    super.initState();
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

  Future<void> getNewData(String city) async {
    data = await client.getCurrentWeather(city);
    if (city.isNotEmpty) {
      setState(() {
        data = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    vh = MediaQuery.of(context).size.height;
    vw = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          height: vh * 1,
          width: vw,
          decoration: BoxDecoration(
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
      ],
    );
  }

  Widget popularCity(){
    return SizedBox(
      height: 1.7*vh,
      width: vw,
      child: Column(
        children:  [
          const Padding(
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
              child: popularCity1(assetsCities[0], namesCities[0])),
          Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: popularCity1(assetsCities[1], namesCities[1])),
          Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: popularCity1(assetsCities[2], namesCities[2])),
          Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
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
          const Image(
            height: 100,
            width: 100,
            image: AssetImage('assets/cloud.png'),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      '${data?.temp?.round()} °C',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text('${data?.main}',
                        style: const TextStyle(
                          fontSize: 16,
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text('${data?.description}',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey)),
                  ),
                ],
              )),
        ]),
        cityDate(),
        Container(
            margin: EdgeInsets.only(left: 30.0, right: 30.0),
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
        setState(() {
          if (text.isNotEmpty) getNewData(text);
        });
      },
      decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.grey),
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

  Widget itemCitiesList(String _filterCitiesItem)
  {
    return               Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
        child: Container(
          //margin: EdgeInsets.all(10),
          width: 340,
          child: Padding(
            padding: EdgeInsets.fromLTRB(14, 7, 14, 7),
            child: Text(
              '${_filterCitiesItem}',
              //'Not found',
              style: TextStyle(fontSize: 16),
            ),
          ),
          decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(30.0)),
        ));
  }

  Widget citiesList() {
    return (Container(
      decoration: BoxDecoration(
          color: Colors.blueAccent, borderRadius: BorderRadius.circular(30.0)),
      height: 196,
      width: 343,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        //itemCount: 4,
        itemExtent: 50,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: [
              itemCitiesList(tmpCityName),
              //itemCitiesList(_filterCities.elementAt(1).toString()),
              //itemCitiesList(_filterCities.elementAt(0).toString()),
             // itemCitiesList(_filterCities.elementAt(1).toString()),
            ],
          );
        },
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
    print(date);
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(30, 20, 0, 10),
            child: Text('${data?.name}, ${data?.country}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                )),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 30, 10),
            child:
                Text(date, style: TextStyle(fontSize: 18, color: Colors.grey)),
          ),
        ]);
  }

  Widget minMaxTemp() {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                'Min',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  '+${data?.tempMin?.round()} °C',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 50, child: VerticalDivider(color: Colors.black)),
          Column(
            children: [
              Text(
                'Max',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  '+${data?.tempMax?.round()} °C',
                  style: TextStyle(
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

  void setCity(text)
  {
    print('setCity getNewData WORK');
    setState(() {
      print('setCity getNewData WORK');
      getNewData(text);
    });

  }

  @override
  Widget popularCity1(String url, String nameCity) {

    return Container(
      height: vh* 0.32,
      width: vw * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        image: DecorationImage(
            image: AssetImage(url),fit:BoxFit.cover
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
              MaterialButton(

                onPressed: () {
                print('namesCities: {$nameCity}');
                if (nameCity.isNotEmpty) getNewData(nameCity.toString());
              },
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: const BorderSide(color: Colors.white),
                ),
                child: Text(nameCity,
                  style: const TextStyle(
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



/*
typedef KeyboardChangeListener = Function(bool isVisible);

class KeyboardListener with WidgetsBindingObserver {
  static final Random _random = Random();


  /// Колбэки, вызывающиеся при появлении и сокрытии клавиатуры
  final Map<String, KeyboardChangeListener> _changeListeners = {};
  /// Колбэки, вызывающиеся при появлении клавиатуры
  final Map<String, VoidCallback> _showListeners = {};
  /// Колбэки, вызывающиеся при сокрытии клавиатуры
  final Map<String, VoidCallback> _hideListeners = {};

  bool get isVisibleKeyboard =>
      WidgetsBinding.instance.window.viewInsets.bottom > 0;

  KeyboardListener() {
    _init();
  }



  void dispose() {
    // Удаляем текущий класс из списка наблюдателей
    WidgetsBinding.instance.removeObserver(this);
    // Очищаем списки колбэков
    _changeListeners.clear();
    _showListeners.clear();
    _hideListeners.clear();
  }


  /// При изменениях системного UI вызываем слушателей
  @override
  void didChangeMetrics() {
    _listener();
  }


  /// Метод добавления слушателей
  String addListener({
    String? id,
    KeyboardChangeListener? onChange,
    VoidCallback? onShow,
    VoidCallback? onHide,
  }) {
    assert(onChange != null || onShow != null || onHide != null);
    /// Для более удобного доступа к слушателям используются идентификаторы
    id ??= _generateId();

    if (onChange != null) _changeListeners[id] = onChange;
    if (onShow != null) _showListeners[id] = onShow;
    if (onHide != null) _hideListeners[id] = onHide;
    return id;
  }

  /// Методы удаления слушателей
  void removeChangeListener(KeyboardChangeListener listener) {
    _removeListener(_changeListeners, listener);
  }

  void removeShowListener(VoidCallback listener) {
    _removeListener(_showListeners, listener);
  }

  void removeHideListener(VoidCallback listener) {
    _removeListener(_hideListeners, listener);
  }

  void removeAtChangeListener(String id) {
    _removeAtListener(_changeListeners, id);
  }

  void removeAtShowListener(String id) {
    _removeAtListener(_changeListeners, id);
  }

  void removeAtHideListener(String id) {
    _removeAtListener(_changeListeners, id);
  }

  void _removeAtListener(Map<String, Function> listeners, String id) {
    listeners.remove(id);
  }

  void _removeListener(Map<String, Function> listeners, Function listener) {
    listeners.removeWhere((key, value) => value == listener);
  }

  String _generateId() {
    return _random.nextDouble().toString();
  }

  void _init() {
    WidgetsBinding.instance.addObserver(this); // Регистрируем наблюдателя
  }

  void _listener() {
    if (isVisibleKeyboard) {
      _onShow();
      _onChange(true);
    } else {
      _onHide();
      _onChange(false);
    }
  }

  void _onChange(bool isOpen) {
    for (KeyboardChangeListener listener in _changeListeners.values) {
      listener(isOpen);
    }
  }

  void _onShow() {
    for (VoidCallback listener in _showListeners.values) {
      listener();
    }
  }

  void _onHide() {
    for (VoidCallback listener in _hideListeners.values) {
      listener();
    }
  }
}*/
