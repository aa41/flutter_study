import 'package:flutter/material.dart';

class TopBar extends PreferredSize{

  final Widget child;

  final Color background;

  TopBar({@required this.child, this.background=Colors.white}):super(child:child,preferredSize:Size(double.infinity, 300.0));

  @override
  Widget build(BuildContext context) {
    return Container(
      color: background,
      child: SafeArea(child: child),
    );
  }




}