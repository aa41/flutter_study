import 'package:flutter/material.dart';
import 'package:flutter_module/page/home.dart';
import 'package:flutter_module/page/splash.dart';

const String HOME_PAGE = "home_page";
const String SPLASH = "splash_page";

Map<String, WidgetBuilder> routes(BuildContext context) {
  return {
     HOME_PAGE: (context) => HomePage(),
    SPLASH: (_) => SplashPage(),
  };
}
