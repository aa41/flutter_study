import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_module/http/http_util.dart';

class GankNormalPage extends StatefulWidget {
  final String type;

  const GankNormalPage({Key key, this.type}) : super(key: key);

  @override
  _GankNormalPageState createState() => _GankNormalPageState();
}

class _GankNormalPageState extends State<GankNormalPage> {
  List<dynamic> _pagerData = [];

  PageController _pageController;

  Timer _timer;

  int maxCount = pow(2, 32);

  double _page;

  double _scrollPercent;

  double _scrollUpdate=0.0;

  ScrollController _controller;

  @override
  void initState() {
    _pageController = new PageController();
    _pageController.addListener(() {
      // print("page::::${_pageController.page}");
      // print("position::::${_pageController.position}");
      setState(() {
        _page = _pageController.page;
        _scrollPercent = 1 - _pageController.page % 1;
      });
    });

    _controller=new ScrollController();
    _controller.addListener((){
      setState(() {
       // _scrollUpdate=_controller.offset;
        print("down？？？？？？");
      });
    });
    super.initState();
    getBannerData();
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }

  void getBannerData() {
    HttpUtils.getDynamic("", {"limit": "10", "first": "1"}, type: "paper")
        .then((value) {
      List list = value["res"]["vertical"];
      setState(() {
        _pagerData = list;
        if (_pagerData.length > 0) {
          int allCount = maxCount - maxCount % _pagerData.length;
          _pageController.jumpToPage((((allCount / 2).toInt())));
          _startRoll();
        }
      });
    }).catchError((e) {
      showDialog(
          context: context,
          builder: (c) {
            return Text(e.toString());
          });
    });
  }

  void _startRoll() {
    if (_timer != null && _timer.isActive) {
      _timer.cancel();
      _timer = null;
    }
    if (_timer == null) {
      _timer = new Timer.periodic(Duration(seconds: 3), (timer) {
        _pageController.nextPage(
            duration: Duration(milliseconds: 1000), curve: Curves.linear);
      });
    }
  }

  void _pauseRoll() {
    if (_timer != null && _timer.isActive) {
      _timer.cancel();
      _timer = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return
       Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Container(
            height: 200-_scrollUpdate>=0?200-_scrollUpdate:0.0,
            child: GestureDetector(
                onPanStart: (_) {
                  _pauseRoll();
                },
                onHorizontalDragEnd: (_) {
                  _startRoll();
                },
                child: PageView.builder(
                  itemBuilder: (_, index) {
                    if (_pagerData.length == 0) {
                      return Container();
                    }
                    var realIndex = index % _pagerData.length;
                    return FractionalTranslation(
                      translation: Offset((_page - index) / 2, 0.0),
                      child: Transform.scale(
                        scale: _page.floor() == index
                            ? _scrollPercent
                            : 1 - _scrollPercent,
                        child: Container(
                          // padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 15.0),
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    _pagerData[realIndex]["thumb"],
                                  ),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                    );
                  },
                  itemCount: maxCount,
                  controller: _pageController,
                  onPageChanged: (index) {},
                )),
          ),

          Expanded(
            flex: 1,
            child: Container(
              height: double.infinity,
              child: RawGestureDetector(
                behavior: HitTestBehavior.opaque,
                gestures: { CustomGestureRecognizer:
                GestureRecognizerFactoryWithHandlers<
                    CustomGestureRecognizer>(
                      () => CustomGestureRecognizer(),  //構造函數
                      (CustomGestureRecognizer instance) {  //初始化器
                    instance.onTap = ()=> print("down!!!!!!!!!!!!!!!!!");
                  },
                )},
                child: ListView.builder(itemBuilder: (_,index){
                  return Container(
                    // padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 15.0),
                    child: Text("sdfsdfkdjsfklsjflskdfjksdlfjlksdjflksdfj"),
                  );
                },
                itemCount: 500,
                  controller: _controller,
                  //controller: _controller,
                ),
              ),
            ),
          )
        ],
    );
  }
}


class CustomGestureRecognizer extends TapGestureRecognizer{


  @override
  void rejectGesture(int pointer) {
    //super.rejectGesture(pointer);
    acceptGesture(pointer);
  }

}
