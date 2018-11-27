import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/constant/color.dart';
import 'package:flutter_module/http/http_util.dart';
import 'package:flutter_module/page/gank.dart';
import 'package:flutter_module/page/splash.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TabInfo> tabs = [
    TabInfo("妹纸", "assets/icon_tab_sy2.png"),
    TabInfo("妹纸", "assets/icon_tab_sj2.png"),
    TabInfo("妹纸", "assets/icon_tab_gx2.png"),
  ];
  int activeIndex = 0;

  Widget _body;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    _body = IndexedStack(
      children: <Widget>[
        new GankPage(),
        new Container(
          color: Colors.red,
        ),
        new Text("3"),
      ],
      index: activeIndex,
    );
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: new Column(
            children: <Widget>[
              Expanded(child: _body),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: _buildItems(),
              ),
            ],
          )),
    );
  }

  _buildItems() {
    return tabs.map((info) => _buildItem(info)).toList();
  }

  Widget _buildItem(TabInfo info) {
    var index = tabs.indexOf(info);
    var isActive = (index == activeIndex);
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            activeIndex = index;
          });
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
          color: Colors.white,
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                info.imgPath,
                width: 30.0,
                height: 30.0,
                color: (isActive ? Colors.red : Colors.blue),
              ),
              Text(
                info.label,
                style: new TextStyle(
                    fontSize: 12.0,
                    color: (isActive ? Colors.red : Colors.blue)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TabInfo {
  String label;
  String imgPath;

  TabInfo(this.label, this.imgPath);
}
