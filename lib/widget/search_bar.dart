import 'package:flutter/material.dart';
typedef SearchTap();

class SearchBar extends StatefulWidget {
  final SearchTap searchTap;

  const SearchBar({Key key, this.searchTap}) : super(key: key);
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        shape: BoxShape.rectangle,
        color: Colors.white,
        border: Border.all(color: Colors.white,width: 0.5),
      ),
      child: InkWell(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon( Icons.search,color: Colors.blue, size: 20.0,),
            Expanded(child: Center(child: Text("请搜索你感兴趣的内容",style: TextStyle(color: Colors.black45,fontSize: 14.0),)))

          ],
        ),
        onTap: widget.searchTap,
      ),
    );
  }
}
