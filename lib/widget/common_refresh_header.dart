import 'package:flutter/material.dart';
import 'dart:core';

class CommonRefreshHeader extends StatefulWidget  {


  final bool isAutoPlay;

  final double fraction;

  const CommonRefreshHeader({Key key, this.isAutoPlay, this.fraction})
      : super(key: key);

  @override
  _CommonRefreshHeaderState createState() => _CommonRefreshHeaderState();
}

class _CommonRefreshHeaderState extends State<CommonRefreshHeader> with TickerProviderStateMixin {
  AnimationController _controller;
  double _fraction=0.0;
  //<double> tween=new Tween(begin: 0.0,end: 4.0);

  @override
  void initState() {
    super.initState();

    _controller=new AnimationController(vsync: this,duration: Duration(milliseconds: 1500),lowerBound: 0.0,upperBound: 1.0);

  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new CustomPaint(
              painter: CustomerHeader(
                  isAutoPlay: widget.isAutoPlay, fraction:widget.isAutoPlay?_fraction: widget.fraction,animation: widget.isAutoPlay?_controller:null),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(
                "听说经常听喜马拉雅的人，运气都不会太差",
                style: TextStyle(fontSize: 14.0, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomerHeader extends CustomPainter  {
  final bool isAutoPlay;

  final double fraction;

  final AnimationController _animation;

  Paint _paint;
  double baseW = 2.5, baseH = 2.0;
  double percent=0.0;

  CustomerHeader({this.isAutoPlay = false, this.fraction = 0.0,AnimationController animation})
    :_paint = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..isAntiAlias = true,
    _animation=animation

  ,super(repaint:animation);




  @override
  void paint(Canvas canvas, Size size) {
    if(_animation!=null){
      _animation.addListener((){
      percent=_animation.value/0.4%1/0.4;
      });
    }
    //print("percent:${percent}");
    canvas.save();
    canvas.translate(0.0, size.height / 2);

    if (isAutoPlay) {
      if(_animation!=null && _animation.status!=AnimationStatus.forward){
        _animation.forward();
      }
      for (int i = 0; i < 4; i++) {
        canvas.drawRRect(
            new RRect.fromLTRBR(
                baseW * (i) + baseW * (i),
                -baseH * ((percent - i).abs()) - baseH,
                baseW * (i + 1) + baseW * (i),
                baseH * ((percent - i).abs()) + baseH,
                Radius.circular(1.5)),
            _paint);
      }
    } else {
      percent = fraction / 0.4 % 1 / 0.4;
      for (int i = 0; i < 4; i++) {
        canvas.drawRRect(
            new RRect.fromLTRBR(
                baseW * (i) + baseW * (i),
                -baseH * ((percent - i).abs()) - baseH,
                baseW * (i + 1) + baseW * (i),
                baseH * ((percent - i).abs()) + baseH,
                Radius.circular(1.5)),
            _paint);
      }
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }





}
