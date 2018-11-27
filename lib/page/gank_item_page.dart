import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_module/data/gank_item_data.dart';
import 'package:flutter_module/http/http_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_module/widget/common_refresh.dart';

class GankItemPage extends StatefulWidget {
  final String type;

  const GankItemPage({Key key, @required this.type}) : super(key: key);

  @override
  _GankItemPageState createState() => _GankItemPageState();
}

class _GankItemPageState extends State<GankItemPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  List<GankItemData> _list = [];
  ScrollController _scrollController;
  GlobalKey<State> _listKey = new GlobalKey();
  GlobalKey<CommonRefreshState> _refreshKey = new GlobalKey();
  List<GlobalKey> itemsKey = [];
  double listViewTop = 0.0;
  int firstVisibleItem = 0;
  double scrollPercent = 0.0;



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshKey.currentState.show();
    });

    _scrollController = new ScrollController();
    _scrollController.addListener(() {
      var offset = _scrollController.position.pixels;

      if (listViewTop == 0.0) {
        listViewTop = _getPosition(_listKey)?.dy;
      }
      if (listViewTop == 0) return;
      for (var key in itemsKey) {
        Offset offset = _getPosition(key);
//        if (offset != null && 0 == itemsKey.indexOf(key)) {
//          print("offset::${offset?.dy}");
//        }
        if (offset != null &&
            offset?.dy + listViewTop >= 0 &&
            offset?.dy <= listViewTop) {
          Size size = _getSize(key);
          //print("first:::${itemsKey.indexOf(key)}");
          setState(() {
            firstVisibleItem = itemsKey.indexOf(key);
            if (size != null) {
              scrollPercent = -(offset.dy - listViewTop) / size.height;
            }
            return;
          });
        }
      }
      //  print("?????scroll:${_getPosition(_listKey)}");

      if (offset == 0) {
        setState(() {
          firstVisibleItem = 0;
          scrollPercent = 0.0;
        });
      }
    });
  }

  Size _getSize(GlobalKey key) {
    RenderBox renderBox = key?.currentContext?.findRenderObject();
    return renderBox?.size;
  }

  Offset _getPosition(GlobalKey key) {
    RenderBox renderBox = key?.currentContext?.findRenderObject();
    return renderBox?.localToGlobal(Offset.zero);
  }

  @override
  Widget build(BuildContext context) {

    return Container(
       // color: Colors.white,
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) {

            if(notification is ScrollStartNotification){

            }

//            if (notification is ScrollUpdateNotification) {
//              var pixels = notification.metrics.pixels;
//             // var outOfRange = notification.metrics.outOfRange;
//              var atEdge = notification.metrics.atEdge;
//            //  var extentBefore = notification.metrics.extentBefore;
//             // var extentAfter = notification.metrics.extentAfter;
//              if (pixels >= notification.metrics.maxScrollExtent && atEdge) {
//                _getListData(isLoad: true);
//              }
//            //  print("piexs:${pixels}   outRange:${outOfRange}   extentBefore:${extentBefore}   extentAfter:${extentAfter}");
//            }
            if (notification is ScrollEndNotification) {
           //   print("notifcation:${notification.toString()}");

              //scrollPercent=scrollPercent.round().toDouble();

              if (scrollPercent <= 0.0 ||
                  scrollPercent == 1.0 ||
                  _scrollController.offset >=
                      _scrollController.position.maxScrollExtent) {
                setState(() {});
              } else {
                var key = itemsKey[firstVisibleItem];
                Size size = _getSize(key);
                if (size != null) {
                  var childHeight = size.height;
                  Future.delayed(Duration.zero, () {
                    _scrollController.animateTo(
                        _scrollController.offset +
                            (scrollPercent < 0.5
                                    ? -scrollPercent
                                    : (1 - scrollPercent)) *
                                childHeight,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.linear);

                    scrollPercent = 0.0;
                  });
                }
              }

              return true;
            }
          },
          child: Container(
            height: double.infinity,
            child: CommonRefresh(
              key: _refreshKey,
              onRefresh: () {
                return _getListData();
              },
              onLoad: (){
                return _getListData(isLoad: true);
              },

              child: Container(
                color: Colors.white,
                child: ListView.builder(
                  key: _listKey,
                  itemBuilder: (c, index) {
                    return FractionalTranslation(
                      translation: Offset(
                          /*(index == firstVisibleItem) ? scrollPercent :*/
                          0.0,
                          0.0),
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity:
                            (index == firstVisibleItem) ? 1 - scrollPercent : 1.0,
                        child: Container(
                          key: itemsKey[index],
                          width: double.infinity,
                          height: 200,
                          child: CachedNetworkImage(
//                        _list[index].images == null
//                            ? _list[index].url
//                            : _list[index].images[0] == null
//                                ? ""
//                                : _list[index].images[0],
//                        fit: BoxFit.cover,
//                        alignment: Alignment(0.0,
//                            (index == firstVisibleItem ? scrollPercent : 0.0)),
                              imageUrl: _list[index].url,
                              fit: BoxFit.cover,
                              placeholder: Icon(Icons.equalizer,color: Colors.blue, size: 40.0,),
                              alignment: Alignment(
                                  0.0,
                                  (index == firstVisibleItem
                                      ? scrollPercent
                                      : 0.0))),
                        ),
                      ),
                    );
                  },
                  itemCount: _list.length ,
                  controller: _scrollController,
                ),
              ),
            ),
          ),
        ));
  }

  int page = 1;

  Future<Null> _getListData({bool isLoad = false}) async {
    if (isLoad) {
      page++;
    } else {
      page = 1;
    }
    await HttpUtils.get("api/data/${widget.type}/10/${page}", null)
        .then((value) {
      Map map = json.decode(value);
      List<dynamic> list = map["results"];
      var data = list.map((m) {
        var gankItemData = new GankItemData.fromJson(m);
        return gankItemData;
      }).toList();

      setState(() {
        if (!isLoad) {
          _list = data;
          itemsKey = [];
        } else {
          _list.addAll(data);
        }

        for (var value in data) {
          var globalKey = GlobalKey();
          itemsKey.add(globalKey);
        }
      });
    }).catchError((e) {
      print("error:${e}");
    });
    return null;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
