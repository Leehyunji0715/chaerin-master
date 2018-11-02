// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.


import 'package:flutter/material.dart';
// Comment out lines 7 and 10 to suppress the visual layout at runtime.
import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;
import 'menu.dart';
import 'gloals.dart' as globals;


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  static String tag ='my-page';
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[200],
        title: Text('My Page'),
      ),
      drawer:MenuPage(),


      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            new Expanded(
                flex:1,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    textBaseline: TextBaseline.alphabetic,
                    children: [

                    ]
                )
            ),
            new Expanded(
              flex:3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/happiness.jpg'),
                    radius: 70.0,
                  ),
                  new Expanded(
                      child: Row(
                          children: [
                            new Expanded(
                              flex:1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                textDirection: TextDirection.rtl,
                                children: [
                                  Text(" "),
                                  Text(" "),
                                  Text(" "),
                                  Text(
                                    "ID : ",
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5,
                                      fontSize: 19.0,
                                    ),
                                  ),

                                  Text(
                                    "E-Mail : ",
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5,
                                      fontSize: 19.0,
                                    ),
                                  ),

                                ],
                              ),

                            ),
                            new Expanded(
                              flex:2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(" "),
                                  Text(" "),
                                  Text(" "),
                                  Text(globals.userName,
                                    //"로그인 ID 값: ",
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  Text(
                                    globals.userEmail,
                                    //"로그인 E-Mail 값 : ",
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  Text(" "),
                                  Text(" "),
                                  Text(" "),
                                ],
                              ), 

                            )
                          ]
                      )
                  )
                ],
              ),
            ),
            new Expanded(
                flex:5,

                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "My Posts",
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.5,
                          fontSize: 25.0,
                        ),
                      ),
                      //list view로 포스트 출력
                    ]
                )
            )
          ],
        ),
      ),
    );
  }
}

