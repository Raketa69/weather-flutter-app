import 'package:flutter/material.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  State<HeaderWidget> createState() => _HeaderWidget();

}

class _HeaderWidget extends State<HeaderWidget> {

  late double vh;
  late double vw;

  @override
  Widget build(BuildContext context) {

    vh = MediaQuery.of(context).size.height;
    vw = MediaQuery.of(context).size.width;

    return Container(
      height: vh,
      width: vw,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/hero_bg.png'),fit:BoxFit.cover
        ),
      ),
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.fromLTRB(16, vh * 0.2, 16, 50),
            child: TextField(
              decoration: InputDecoration(
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
                fillColor: Colors.white
              ),
            ),
          ),
        Padding(
          padding: EdgeInsets.fromLTRB(16, vh*0.07 , 16, 0),
          child: Container(
            decoration:BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),),
            height: vh * 0.5,
            child: Column(
                children: [
                  Row(
                      children: [
                          const Image(
                            height: 100,
                            width: 100,
                            image: AssetImage('assets/cloud.png'),),
                          Padding(padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Padding(padding: EdgeInsets.all(5),
                                  child: Text('+ 23 C' ,
                                    style: TextStyle(
                                    fontSize: 18,
                                  ),),
                                ),
                                Padding(padding: EdgeInsets.all(5),
                                  child: Text('Drizzle',
                                      style: TextStyle(
                                      fontSize: 16,)),
                                ),
                                Padding(padding: EdgeInsets.all(5),
                                child: Text('Light intensity drizzle',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey)),
                                ),
                              ],
                            )),
                        ]
                  ),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Padding(padding: EdgeInsets.all(19),
                          child: Text('Odessa, Ukraine',
                              style: TextStyle(
                              fontSize: 18,)),
                        ),
                        Padding(padding: EdgeInsets.all(16),
                          child: Text('10 March 2020',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey)),
                        ),
                      ]
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 30.0, right: 30.0),
                      child: const Divider(
                        color: Colors.black,
                        height: 100,
                      )),
                 /* Row(
                    children: [
                      Column(
                        children: const [
                          Text('Min'),
                          Text('-33°C'),
                        ],
                      ),
                      Column(
                        children: const [
                          Text('Min'),
                          Text('-33°C'),
                        ],
                      )
                    ],
                  )*/
                ]
              ),
            )
          ),
          ],
      ),
    );
  }


}