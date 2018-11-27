import 'dart:ui';

import 'package:flutter/material.dart';

class WidgetUtils{
  static Size getWidgetSize(GlobalKey key){
    RenderBox renderObject = key?.currentContext?.findRenderObject();
    return renderObject?.size;
  }

  static Offset getWidgetInScreen(GlobalKey key){
    RenderBox renderObject = key?.currentContext?.findRenderObject();
    return renderObject?.localToGlobal(Offset.zero);
  }
}