import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/constant/page_contstant.dart';
import 'package:flutter_module/constant/win.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  int times=1;
  Timer timer;
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    _startTime();
  }

  @override
  Widget build(BuildContext context) {
    Win.windowsSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Center(
            child: Image.asset("assets/logo_ycy.jpg",
                fit: BoxFit.cover, height: Win.windowsSize.height),
          ),
          Positioned(
              child: Container(

                padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 5.0),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                //  border: new Border.all(width: 1,color: Colors.white),
                  color: Colors.black45,

                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: new InkWell(
                  child: Text("跳过${times}s",style: new TextStyle(color: Colors.white,fontSize: 14.5),),
                  onTap: (){
                    Navigator.pushReplacementNamed(context, HOME_PAGE);
                  },
                ),
              ),
            right: 20.0,
            top: 20.0,
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    timer=null;
    super.dispose();

  }

  void _startTime() {
    timer= new Timer(Duration(seconds: 1), (){
      if(!mounted)return;
      setState(() {
        times-=1;

        if(times==0){
          Navigator.pushReplacementNamed(context, HOME_PAGE);
        }else{
          _startTime();
        }
      });
    });
  }
}
