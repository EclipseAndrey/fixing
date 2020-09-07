import 'package:fixing/Database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Objects.dart';

void VisitBottom(String Visitdate, BuildContext context){


  Future<bool> _showModalBottomSheet(BuildContext context) async{
    showModalBottomSheet<bool>(
      context: context,
      barrierColor: Colors.black45,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState2) {
            return Container(
              height: 370,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, top: 12),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20.0)),
                              side: BorderSide(color: Colors.redAccent)),
                          color: Colors.transparent,
                          textColor: Colors.redAccent,
                          onPressed: () async{
                            if(Visitdate != "")await DBProvider.db.insertVisitOn(Visitdate);
                            Visitdate = "";
                            Navigator.pop(context);
                            return true;
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 3.0, right: 3, top: 3, bottom: 3),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Row(
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(right: 3.0),
                                    child: SizedBox(
                                      width: 4,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      "Пришел",
                                      style: TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 16,
                                          fontFamily: "MPLUS",
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 12.0, top: 12, right: 12),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20.0)),
                              side: BorderSide(color: Colors.blue)),
                          color: Colors.transparent,
                          textColor: Colors.blue,
                          onPressed: () async {
                            if(Visitdate != "")await DBProvider.db.insertVisitOff(Visitdate);
                            Visitdate = "";
                            Navigator.pop(context);
                            return true;
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 3.0, right: 3, top: 3, bottom: 3),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Row(
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(right: 3.0),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      "Ушел",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 16,
                                          fontFamily: "MPLUS",
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 300,

                    child: CupertinoDatePicker(
                        initialDateTime: DateTime.now(),
                        mode: CupertinoDatePickerMode.dateAndTime,
                        onDateTimeChanged: (DateTime dateTime) {
                          Visitdate = setDateMode(dateTime);
                          print(dateTime.toString());
                          return true;

                        }),
                  ),
                ],
              ),
            );
          },
        );
        //     return MakeOrder();
      },
    );
  }

  _showModalBottomSheet(context);
}
