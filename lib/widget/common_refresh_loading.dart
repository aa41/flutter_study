import 'package:flutter/material.dart';

class CommonRefreshLoading extends StatefulWidget {
  @override
  _CommonRefreshLoadingState createState() => _CommonRefreshLoadingState();
}

class _CommonRefreshLoadingState extends State<CommonRefreshLoading> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(strokeWidth: 1.5,),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text("正在加载...",style: TextStyle(color: Colors.black45,fontSize: 14.0),),
            ),
          ],
        ),
      ),
    );
  }
}
