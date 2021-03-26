import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Accueil extends StatefulWidget {
  @override
  _Accueil createState() => _Accueil();
}

class _Accueil extends State<Accueil> {
  List<Image> actus = [
    Image.asset("assets/img/i1.jpg"),
    Image.asset("assets/img/i2.jpg"),
    Image.asset("assets/img/i3.jpg"),
    Image.asset("assets/img/i4.jpg")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 15.0),
                child:
                  RichText(
                    text: TextSpan(
                      text: "Bienvenue ",
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900, color: Colors.black),
                    ),
                    textAlign: TextAlign.center,
                  )
              ),
              Card(
                  margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                  clipBehavior: Clip.antiAlias,
                  elevation: 5.0,
                  color: Colors.white,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 7.0),
                      child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "Actualités",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff3C3B3A),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Container(
                                      width: double.infinity,
                                      height: MediaQuery.of(context).size.height * 0.35,
                                    child:
                                    CarouselSlider(
                                      options: CarouselOptions(
                                        height: 400,
                                        aspectRatio: 16/9,
                                        viewportFraction: 0.8,
                                        initialPage: 0,
                                        enableInfiniteScroll: true,
                                        reverse: false,
                                        autoPlay: true,
                                        autoPlayInterval: Duration(seconds: 4),
                                        autoPlayAnimationDuration: Duration(milliseconds: 1000),
                                        autoPlayCurve: Curves.fastOutSlowIn,
                                        enlargeCenterPage: true,
                                        scrollDirection: Axis.horizontal,
                                        ),
                                      items: actus.map((i) {
                                        Builder(
                                          builder: (BuildContext context) {
                                            return i;
                                          },
                                        );
                                      }).toList(),
                                    )
                                  ),
                                ],
                              ),
                            ),
                          ]
                      )
                  )
              ),

              Card(
                margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                clipBehavior: Clip.antiAlias,
                elevation: 5.0,
                color: Colors.white,
                child:
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 7.0),
                    child: Row(
                    children: [
                      Expanded(
                        child: Column(
                        children: [
                          Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.20,
                          child:
                            Container(

                            ),
                          ),
                        ])
                      )
                    ]
                    )
                  )
              )
            ]
        )
    );
  }
}