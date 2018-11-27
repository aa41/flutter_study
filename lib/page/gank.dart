import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_module/http/http_util.dart';
import 'package:flutter_module/page/gank_item_page.dart';
import 'package:flutter_module/page/gank_normal_page.dart';
import 'package:flutter_module/page/search.dart';
import 'package:flutter_module/widget/search_bar.dart';
import 'package:flutter_module/widget/topbar.dart';

class GankPage extends StatefulWidget {
  @override
  _GankPageState createState() => _GankPageState();
}

class _GankPageState extends State<GankPage> with TickerProviderStateMixin {
  TabController _tabController;
  List<String> tabs = ["福利", "Android", "iOS"];
  double scrollPercent = 0.0;
  double colorSelect;
  int index = 0;
  Color lerpColor = Colors.blue;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        index = _tabController.index;
      });
    });

    _tabController.animation.addListener(() {
      var v = _tabController.animation.value;
      setState(() {
        scrollPercent = v;
        lerpColor =
            Color.lerp(Colors.blue, Colors.green, v / (tabs.length - 1));
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
          background: lerpColor, child: Padding(padding: EdgeInsets.all(0.0))),
      body: Container(
          child: Stack(
        children: <Widget>[
          Container(
            color: lerpColor,
            height: 200,
          ),
          _buildColumn(context)
        ],
      )),
    );
  }

  Column _buildColumn(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SearchBar(
            searchTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => SearchPage()));
            },
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
          // padding: const EdgeInsets.all(8.0),
          //color: Colors.white,
          width: double.infinity,
          child: Center(
            child: Container(
              height: 40.0,
              decoration: BoxDecoration(
                color: Colors.cyan,
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.white, width: 2.0),
              ),
              child: TabBar(
                tabs: tabs.map((s) {
                  return new Tab(
                    child: Text(
                      s,
                      style: TextStyle(fontSize: 12.0),
                    ),
                  );
                }).toList(),
                isScrollable: true,
                indicatorPadding: EdgeInsets.all(0.0),
                controller: _tabController,
                labelColor: Colors.white,
                indicatorWeight: 0.0,

                unselectedLabelColor: Colors.black54,
                indicatorColor: Colors.red,
                indicator: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: _indicatorColor(),
                  borderRadius: _borderRadius(),
                ),
//                  indicator: UnderlineTabIndicator(
//                    borderSide: BorderSide(
//                        color: Colors.white, width: 2.0, style: BorderStyle.solid),
//                  ),
              ),
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            children: tabs.map((s) {
              if ("福利" == s) {
                return GankItemPage(type: s);
              } else {
                return GankNormalPage(type: s);
              }
            }).toList(),
            controller: _tabController,
            //  physics: ScrollPhysics(parent: FixedExtentScrollPhysics()),
          ),
        )
      ],
    );
  }

  _borderRadius() {
    if (tabs.length == 1) {
      return BorderRadius.all(Radius.circular(30.0));
    } else if (tabs.length == 2) {
      var distance = 30.0 - (30.0 * scrollPercent);
      return BorderRadius.only(
          topLeft: Radius.circular(distance),
          bottomLeft: Radius.circular(distance),
          bottomRight: Radius.circular(30.0 - distance),
          topRight: Radius.circular(30.0 - distance));
    } else {
      if (scrollPercent >= 0 && scrollPercent < 1) {
        var distance = 30.0 - (30.0 * scrollPercent);
        return BorderRadius.only(
            topLeft: Radius.circular(distance),
            bottomLeft: Radius.circular(distance));
      } else if (scrollPercent <= tabs.length - 1 &&
          scrollPercent > tabs.length - 2) {
        var distance = 30.0 - 30.0 * (tabs.length - 1 - scrollPercent);
        return BorderRadius.only(
            topRight: Radius.circular(distance),
            bottomRight: Radius.circular(distance));
      } else {
        return BorderRadius.all(Radius.circular(0.0));
      }
    }
  }

  _indicatorColor() {
    return lerpColor ?? Colors.blue;
  }
}
