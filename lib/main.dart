import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_module/constant/page_contstant.dart';
import 'package:flutter_module/constant/win.dart';
import 'package:flutter_module/page/splash.dart';

void main(){
  runZoned(()=>runApp(MyApp()),onError: (obj,stack){

  });

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: routes(context),
      title: 'test flutter',
      theme: ThemeData(
        highlightColor: Colors.lightBlueAccent,
          primarySwatch: Colors.blue,
          primaryColor: Colors.blue,
          inputDecorationTheme: new InputDecorationTheme(
            errorMaxLines: null,
            border: InputBorder.none,
            labelStyle: null,
            helperStyle: null,
            errorStyle: null,
            isCollapsed: true,
          )),
      home: SplashPage(),
    );
  }
}
