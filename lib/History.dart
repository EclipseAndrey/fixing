import 'package:fixing/General.dart';
import 'package:fixing/Tools/GetContentHistory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Objects.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {

  @override
  void initState() {
    _updateContent();
    super.initState();
  }

  List<ContentBlocInfo> contentHistoryList = [];
  bool _load = true;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Container(
          width: width*0.90,
          child: Column(
            children: <Widget>[
              Content(),
              SizedBox(
                height: 20,
              )
            ],
          ),

        ),
      ),
    );
  }

  Widget Content(){
    return _load ? Center(child:CupertinoActivityIndicator(),):
    Column(
      children: List.generate(contentHistoryList.length, (index) => ItemList(contentHistoryList[index])),
    );
  }




  Widget ItemList(ContentBlocInfo contentBlocInfo){
    return Column(
      children: <Widget>[
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 24.0, bottom : 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      contentBlocInfo.date.day.toString()  + " " + month(contentBlocInfo.date.month.toString()),
                      style: TextStyle(fontSize: 17, color:  Colors.black87, )
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width*0.90,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(contentBlocInfo.notes.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                    width: MediaQuery.of(context).size.width*0.90,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        boxShadow: [BoxShadow(
                            color: Color.fromRGBO(34, 15, 180, .3),
                            blurRadius: blurSize,
                            offset: Offset(-2.5, 7)
                        )]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(contentBlocInfo.notes[index].task, style: TextStyle(fontSize: 16, decoration: TextDecoration.none, color: Colors.black)),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text("Адрес: "+contentBlocInfo.notes[index].address, style: TextStyle(fontSize: 16, decoration: TextDecoration.none, color: Colors.black54)),
                          ),
                        ],
                      ),
                    )),
              );
            }),
          ),
        ),
      ],
    );
  }










  void _updateContent()async{
    _load = true;
    setState(() {});
    contentHistoryList = await getContentHistory();
    _load = false;
    setState(() {});
  }
}
