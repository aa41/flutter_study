import 'package:flutter/material.dart';
import 'package:flutter_module/widget/topbar.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
   TextEditingController _editingController;
  // String value;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _editingController=new TextEditingController();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _editingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        background: Colors.blue,
        child: Padding(
          padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
          child:new Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.arrow_back,color: Colors.white,size: 25.0),
                ),
              ),
              Expanded(
                child: new Container(
                  height: 30.0,
                  // color: Colors.white,
                  // height: 35.0,
                  //  padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      //gradient: LinearGradient(colors: [Colors.blue,Colors.red]),
                        border: Border.all(color: Colors.white, width: 0.2),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    child:new Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: _editingController,
                            cursorColor: Colors.black45,
                            cursorWidth: 1,
                            autofocus: true,
                            style: TextStyle(fontSize: 14.0, color: Colors.black45),
                            decoration: InputDecoration(
                                hintText: "请输入您想搜索的内容",
                                contentPadding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 8.0),
                                hintStyle:
                                TextStyle(fontSize: 14.0, color: Colors.black45)),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            //print("text:"+_editingController.text);
                            //TODO
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Icon(
                              Icons.search,
                              color: Colors.blue,
                              size: 20.0,
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              ),

            ],
          ),

        ),
      ),
    );
  }
}
