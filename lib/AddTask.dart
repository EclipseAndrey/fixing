import 'package:fixing/Database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Objects.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class zatrat {
  String comment;
  int summ;

  zatrat(this.summ, this.comment);
}

TextEditingController controllerAddress = TextEditingController();
TextEditingController controllerTask = TextEditingController();
TextEditingController controllerComment = TextEditingController();
String dateTask =
    DateFormat("yyyy.MM.dd HH:mm", "en_US").format(DateTime.now()).toString();
String timeSpend = "2020.07.09 00:00";
String timeStart =
    DateFormat("yyyy.MM.dd HH:mm", "en_US").format(DateTime.now()).toString();
List<Expans> zatraty = [
  Expans(1, "2020.07.09 11:57", "На такси", 200, "false"),
  Expans(1, "2020.07.09 11:57", "На такси обратно", 200, "false")
];

void setDateTask(DateTime date) {
  print("sdfsdfsdfsdfsdfsdfsdfsdf" + date.toString());
  String ye, mo, da, ho, mi;
  ye = date.year.toString();
  mo = date.month < 10 ? "0" + date.month.toString() : date.month.toString();
  da = date.day < 10 ? "0" + date.day.toString() : date.day.toString();
  ho = date.hour < 10 ? "0" + date.hour.toString() : date.hour.toString();
  mi = date.minute % 60 < 10
      ? "0" + (date.minute % 60).toString()
      : (date.minute % 60).toString();

  print(ye + "." + mo + "." + da + " " + ho + ":" + mi);

  dateTask = ye + "." + mo + "." + da + " " + ho + ":" + mi;
}

void setSpendTask(DateTime date) {
  String ye, mo, da, ho, mi;
  ye = date.year.toString();
  mo = date.month < 10 ? "0" + date.month.toString() : date.month.toString();
  da = date.day < 10 ? "0" + date.day.toString() : date.day.toString();
  ho = date.hour < 10 ? "0" + date.hour.toString() : date.hour.toString();
  mi = date.minute % 60 < 10
      ? "0" + (date.minute % 60).toString()
      : (date.minute % 60).toString();
  timeSpend = ye + "." + mo + "." + da + " " + ho + ":" + mi;
}

double op = 0;
List<zatrat> testzatrat = [];

class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          actionsIconTheme: IconThemeData(color: Colors.black),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                if (controllerTask.text != "" && controllerAddress.text != "") {
                  op = 1;
                  Note step = Note.noId(
                      dateTask,
                      controllerAddress.text.toString(),
                      controllerTask.text.toString(),
                      timeSpend,
                      timeStart,
                      controllerComment.text.toString());
                  List<Expans> step2 = [];
                  for (int i = 0; i < testzatrat.length; i++) {
                    step2.add(Expans(1, dateTask, testzatrat[i].comment,
                        testzatrat[i].summ, "false"));
                  }
                  await DBProvider.db.insertNote(step, step2);
                  controllerAddress.text = "";
                  controllerComment.text = "";
                  controllerTask.text = "";
                  testzatrat = [];
                  Future.delayed(const Duration(milliseconds: 300), () {
                    Navigator.pop(context);
                  });
                } else {
                  Fluttertoast.showToast(
                      msg: "Адрес или задача не введены",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
                setState(() {});
              },
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Opacity(
              opacity: op,
              child: Center(
                child: Icon(Icons.check, color: Colors.green),
              ),
            ),
            Opacity(
              opacity: 1 - op,
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Builder(
                    builder: (context) => Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Column(
                            children: <Widget>[
                              selectDate(context),
                              Padding(
                                padding: const EdgeInsets.only(top: 14.0),
                                child: selectAddress(),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 14.0),
                                child: selectTask(),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 14.0),
                                child: selectExpanses(),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 14.0),
                                child: selectComment(),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 14.0),
                                child: selectTimeSpend(),
                              ),
                              SizedBox(height: 20,)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  String minute0(int min) {
    if (min < 10) {
      return "0" + min.toString();
    } else {
      return min.toString();
    }
  }

  Widget selectDate(BuildContext context) {
    Widget button() {
      return GestureDetector(
        onTap: () {
          bottomDate(context);
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(34, 15, 45, .3),
                    blurRadius: 10,
                    offset: Offset(-2.5, 5))
              ]),
          width: MediaQuery.of(context).size.width * 0.95,
          height: MediaQuery.of(context).size.width * 0.20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, left: 18),
                    child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "Дата",
                          style: TextStyle(color: Colors.black87, fontSize: 18),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 13.0, right: 18),
                    child: Icon(Icons.access_time),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  left: 18,
                ),
                child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      DateFormat("yyyy.MM.dd HH:mm", "en_US")
                              .parse(dateTask)
                              .day
                              .toString() +
                          " " +
                          month(DateFormat("yyyy.MM.dd HH:mm", "en_US")
                              .parse(dateTask)
                              .month
                              .toString()) +
                          "  " +
                          DateFormat("yyyy.MM.dd HH:mm", "en_US")
                              .parse(dateTask)
                              .hour
                              .toString() +
                          ":" +
                          minute0(DateFormat("yyyy.MM.dd HH:mm", "en_US")
                              .parse(dateTask)
                              .minute) +
                          " ",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600),
                    )),
              ),
            ],
          ),
        ),
      );
    }

    return button();
  }

  void bottomDate(BuildContext context) {
    void _showModalBottomSheet(BuildContext context) {
      showModalBottomSheet<void>(
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
                            onPressed: () {
                              Navigator.pop(context);
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
                                        "Отмена",
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
                            onPressed: () {
                              Navigator.pop(context);
                              setState(() {});
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
                                        "Сохранить",
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
                            print(dateTime.toString());
                            setDateTask(dateTime);
                            setState(() {});
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

  void bottomSpand(BuildContext context) {
    void _showModalBottomSheet(BuildContext context) {
      showModalBottomSheet<void>(
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
                            onPressed: () {
                              Navigator.pop(context);
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
                                        "Отмена",
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
                            onPressed: () {
                              Navigator.pop(context);
                              setState(() {});
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
                                        "Сохранить",
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
                          initialDateTime: DateParse(timeSpend),
                          mode: CupertinoDatePickerMode.time,
                          onDateTimeChanged: (DateTime dateTime) {
                            print(dateTime.toString());
                            setState(() {
                              setSpendTask(dateTime);
                            });
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

  Widget selectAddress() {
    return GestureDetector(
      onTap: () {
        bottomDate(context);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(34, 15, 45, .3),
                  blurRadius: 10,
                  offset: Offset(-2.5, 5))
            ]),
        width: MediaQuery.of(context).size.width * 0.95,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12.0, left: 18),
                  child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Адрес",
                        style: TextStyle(color: Colors.black87, fontSize: 18),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 13.0, right: 18),
                  child: Icon(Icons.location_on),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, left: 18, bottom: 8, right: 18),
              child: TextField(
                controller: controllerAddress,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget selectTask() {
    return GestureDetector(
      onTap: () {
        bottomDate(context);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(34, 15, 45, .3),
                  blurRadius: 10,
                  offset: Offset(-2.5, 5))
            ]),
        width: MediaQuery.of(context).size.width * 0.95,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12.0, left: 18),
                  child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Задача",
                        style: TextStyle(color: Colors.black87, fontSize: 18),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 13.0, right: 18),
                  child: Icon(Icons.transfer_within_a_station),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, left: 18, bottom: 8, right: 18),
              child: TextField(
                controller: controllerTask,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget selectTimeSpend() {
    String end = "";
    var timeSpend1 = DateFormat("yyyy.MM.dd HH:mm", "en_US").parse(timeSpend);
    if (timeSpend1.hour > 0) end += "${timeSpend1.hour} ч. ";
    end += (timeSpend1.minute % 60).toString() + " мин.";

    return GestureDetector(
      onTap: () {
        bottomSpand(context);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(34, 15, 45, .3),
                  blurRadius: 10,
                  offset: Offset(-2.5, 5))
            ]),
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.width * 0.20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12.0, left: 18),
                  child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Длительность",
                        style: TextStyle(color: Colors.black87, fontSize: 18),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 13.0, right: 18),
                  child: Icon(Icons.access_time),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                left: 18,
              ),
              child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    end,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget selectExpanses() {
    TextEditingController summNoteController = TextEditingController();
    TextEditingController commentNoteController = TextEditingController();

    void displayDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) => new CupertinoAlertDialog(
          title: new Text("Новая запись"),
          content: Column(
            children: <Widget>[
              Material(
                color: Colors.transparent,
                child: TextField(
                  controller: summNoteController,
                  decoration: InputDecoration(hintText: "Сумма"),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: TextField(
                  controller: commentNoteController,
                  decoration: InputDecoration(hintText: "Комментарий"),
                ),
              )
            ],
          ),
          actions: [
            CupertinoDialogAction(
                isDestructiveAction: true, child: new Text("Закрыть")),
            CupertinoDialogAction(
                onPressed: () {
                  setState(() {
                    testzatrat.add(zatrat(int.parse(summNoteController.text),
                        commentNoteController.text));
                  });
                  Navigator.pop(context);
                },
                isDefaultAction: true,
                child: new Text("Добавить")),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        displayDialog();
      },
      onLongPress: () {
        testzatrat = [];
        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(34, 15, 45, .3),
                  blurRadius: 10,
                  offset: Offset(-2.5, 5))
            ]),
        width: MediaQuery.of(context).size.width * 0.95,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, left: 18),
                    child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "Затраты",
                          style: TextStyle(color: Colors.black87, fontSize: 18),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 13.0, right: 18),
                    child: Icon(Icons.attach_money),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 8),
                child: Column(
                  children: List.generate(testzatrat.length, (index) {
                    zatrat a = testzatrat[index];

                    print(a.comment);
                    return Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            testzatrat[index].summ.toString(),
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            testzatrat[index].comment.toString(),
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  left: 18,
                ),
                child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "+ Добавить ",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget selectComment() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(34, 15, 45, .3),
                  blurRadius: 10,
                  offset: Offset(-2.5, 5))
            ]),
        width: MediaQuery.of(context).size.width * 0.95,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, left: 18),
                    child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "Комментарий",
                          style: TextStyle(color: Colors.black87, fontSize: 18),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 13.0, right: 18),
                    child: Icon(Icons.textsms),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 18, right: 18),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: controllerComment,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
