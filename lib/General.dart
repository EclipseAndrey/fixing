import 'package:fixing/Database.dart';
import 'package:fixing/views/VisitBottom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'AddTask.dart';
import 'Objects.dart';

class General extends StatefulWidget {
  @override
  _GeneralState createState() => _GeneralState();
}

double blurSize = 10;
bool loadContent= true;
List<Note> noteList = [];
List<ContentBlocInfo> contentBloc = [];
String Visitdate = "";


class _GeneralState extends State<General> {

  void addTaskPush(){
    op = 0;
    Navigator.of(context).pushNamed("/add");
  }

@override
  void initState() {

     updateContent();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    TextEditingController controllertext = TextEditingController();
    void commentBottom(){
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
                      Container(
                        width: MediaQuery.of(context).size.width*0.90,

                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
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
                                    if(controllertext.text != "" && controllertext.text != null)await DBProvider.db.insertComments(Comment(DateNull(setDateMode(DateTime.now())), controllertext.text));
                                    Navigator.pop(context);
                                    await updateContent();
                                    setState(() {

                                    });
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
                                              "Сегодня",
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
                                padding: const EdgeInsets.only(left: 12.0, top: 12),
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                      side: BorderSide(color: Colors.redAccent)),
                                  color: Colors.transparent,
                                  textColor: Colors.redAccent,
                                  onPressed: ()async {
                                    print("DATE COMMENT INSERT "+DateNull(setDateMode(DateTime.now().add(Duration(days: -1)))));
                                    if(controllertext.text != "" && controllertext.text != null)await DBProvider.db.insertComments(Comment(DateNull(setDateMode(DateTime.now().add(Duration(days: -1)))), controllertext.text));

                                    Navigator.pop(context);
                                    await updateContent();
                                    setState(() {

                                    });
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
                                              "Вчера",
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
                                    setState(() {

                                    });
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
                                              "Другой день",
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
                        ),
                      ),
                      Container(
                        height: 300,

                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: TextField(
                            decoration: InputDecoration(hintText: "Комментарий", hintStyle: TextStyle(color: Colors.black54), ),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,


                          controller: controllertext,
                          ),
                        ),
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


    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width*0.95,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: GestureDetector(
                  onTap: (){
                    addTaskPush();
                  } ,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [BoxShadow(
                            color: Color.fromRGBO(34, 15, 45, .3),
                            blurRadius: blurSize,
                            offset: Offset(-2.5, 5)
                        )]
                    ),
                    width: MediaQuery.of(context).size.width*0.95,
                    height: MediaQuery.of(context).size.width*0.20,
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
                                  child: Text("Добавить запись", style: TextStyle(fontSize: 18),)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 13.0, right: 18),
                              child: Icon(Icons.add),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 18, ),
                          child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text("Создать новое событие в истории", style: TextStyle(fontSize: 16, color: Colors.black45),)),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: ()async {
                        Visitdate = setDateMode(DateTime.now());

                        await VisitBottom(Visitdate, context);
                        await updateContent();
                        setState(() {

                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(
                                color: Color.fromRGBO(34, 15, 45, .3),
                                blurRadius: blurSize,
                                offset: Offset(-2.5, 5)
                            )]
                        ),
                        width: MediaQuery.of(context).size.width*0.28,
                        height: MediaQuery.of(context).size.width*0.20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 14.0, left: 14, ),
                              child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text("Отметиться", style: TextStyle(fontSize: 16, color: Colors.black),)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 14.0, left: 18, ),
                              child: FittedBox(
                                  fit: BoxFit.scaleDown,

                                  child: Text("   ", style: TextStyle(fontSize: 18, color: Colors.black45),)),
                            ),

                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap:(){
                        commentBottom();
                      } ,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(
                                color: Color.fromRGBO(34, 15, 45, .3),
                                blurRadius: blurSize,
                                offset: Offset(-2.5, 5)
                            )]
                        ),
                        width: MediaQuery.of(context).size.width*0.28,
                        height: MediaQuery.of(context).size.width*0.20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 14.0, left: 18,right: 12 ),
                              child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text("Заметка", style: TextStyle(fontSize: 16, color: Colors.black, decoration: TextDecoration.none),)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 14.0, left: 18, ),
                              child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text("Добавить", style: TextStyle(fontSize: 16, color: Colors.black54, decoration: TextDecoration.none),)),
                            ),

                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap:(){
                        final action = CupertinoActionSheet(

                          title: Text(
                            "Меню",
                            style: TextStyle(fontSize: 30),
                          ),

                          actions: <Widget>[
                            CupertinoActionSheetAction(

                              child: Text("Создать заметку"),
                              isDefaultAction: true,
                              onPressed: () {
                                commentBottom();
                                print("Создать заметку");

                              },
                            ),
                            CupertinoActionSheetAction(
                              child: Text("Выходной"),
                              isDefaultAction: true,
                              onPressed: () {
                                print("Выходной");
                                bottomDateWeekend(context);
                              },
                            ),
                            CupertinoActionSheetAction(
                              child: Text("Добавить запись"),
                              isDefaultAction: true,
                              onPressed: () {
                                print("Добавить запись");
                                addTaskPush();
                              },
                            ),
                            CupertinoActionSheetAction(
                              child: Text("Отметиться"),
                              isDestructiveAction: false,
                              onPressed: () {
                                print("Отметиться");
                              },
                            )
                          ],
                          cancelButton: CupertinoActionSheetAction(
                            isDestructiveAction: true,

                            child: Text("Cancel"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        );
                        showCupertinoModalPopup(
                            context: context, builder: (context) => action);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(
                                color: Color.fromRGBO(34, 15, 45, .3),
                                blurRadius: blurSize,
                                offset: Offset(-2.5, 5)
                            )]
                        ),
                        width: MediaQuery.of(context).size.width*0.28,
                        height: MediaQuery.of(context).size.width*0.20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 14.0),
                              child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text("Меню", style: TextStyle(fontSize: 18, color: Colors.black, decoration: TextDecoration.none),)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only( top: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 8, bottom: 7),
                      child: Text("История",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontFamily: "MPLUS",
                        ), ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*0.85,
                      child: Divider(

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 28.0),
                      child: Column(
                        children: List.generate(contentBloc.length, (index) {
                          return ContentBloc(contentBloc[index]);
                        }),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  updateContent()async{
    loadContent = true;
    setState(() {});

//    noteList = await DBProvider.db.getNotes();
//    for(int i = 0; i < noteList.length; i++){
//      noteList[i].expans = await DBProvider.db.getExpans(noteList[i].id);
//    }

    contentBloc = await getContentBlocs();

    loadContent = false;
    setState(() {});
  }


  Widget Content(){
    if(loadContent)
    return Center(
      child: CupertinoActivityIndicator(),
    );
    else{
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Column(
              children: List.generate(noteList.length, (index)  {

                return NoteWidget(noteList[noteList.length-1 - index]);
              }),
            ),
          ],
        ),
      );
    }
  }

  Widget NoteWidget (Note note){

    List<Expans> expans = note.expans;

    Widget exp (){
      if(expans.length > 0)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 18, right: 0),
                child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text("Затраты", style: TextStyle(fontSize: 16, decoration: TextDecoration.none, color: Colors.black),)),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 18),
            child: Column(
              children: List.generate(expans.length, (index) {
                return Row(children: <Widget>[
                  Text(expans[index].summ.toString()+"руб. ", style: TextStyle(fontSize: 16, color: Colors.red, decoration: TextDecoration.none, fontWeight: FontWeight.w400),),
                  Text(expans[index].comment, style: TextStyle(fontSize: 16, color: Colors.black, decoration: TextDecoration.none, fontWeight: FontWeight.w400),),
                ],);
              }),
            ),
          )
        ],
      );
      else {
        return SizedBox();
      }
    }

    String minutes0(int min){
      if(min < 10)return "0"+min.toString();else return min.toString();
    }
var dateTask = note.date;
    return  Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: (){

        } ,
        child: CupertinoContextMenu(
          actions: <Widget>[
            CupertinoContextMenuAction(
              child: const Text('Редактировать'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoContextMenuAction(
              isDestructiveAction: true,

              child: const Text('Удалить'),
              onPressed: () async{
                await DBProvider.db.deleteNote(note.date);
                Navigator.pop(context);
                await updateContent();
                setState(() {
                  
                });
              },
            ),

          ],

          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(
                    color: Color.fromRGBO(34, 15, 45, .3),
                    blurRadius: blurSize,
                    offset: Offset(-2.5, 5)
                )]
            ),
            width: MediaQuery.of(context).size.width*0.95,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0, left: 18,right: 18),
                        child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              DateFormat("yyyy.MM.dd HH:mm", "en_US").parse(dateTask).day.toString() +" "+ month( DateFormat("yyyy.MM.dd HH:mm", "en_US").parse(dateTask).month.toString())+"  "+ DateFormat("yyyy.MM.dd HH:mm", "en_US").parse(dateTask).hour.toString() +":" + minutes0(DateFormat("yyyy.MM.dd HH:mm", "en_US").parse(dateTask).minute)
                            , style: TextStyle(fontSize: 18,decoration: TextDecoration.none, color: Colors.black),)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 18, right: 18 ),
                    child: Text(note.task, style: TextStyle(fontSize: 16, color: Colors.black45, decoration: TextDecoration.none),),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0, left: 18, right: 18),
                        child: Text("Место: "+note.address, style: TextStyle(fontSize: 16, decoration: TextDecoration.none, color: Colors.black),),
                      ),
                    ],
                  ),
                  SpandWiget(note.timeSpend),

                  CommentW(note),
                  exp()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget SpandWiget(String date){
    var timeSpend = new DateFormat("yyyy.MM.dd HH:mm", "en_US").parse(date);

    print(date);
    String end = "";
    if(timeSpend.hour > 0) end +="${timeSpend.hour} ч. ";
    end += (timeSpend.minute%60).toString() + " мин.";

    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12.0, left: 18, ),
          child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text("Продолжительность $end", style: TextStyle(fontSize: 16, decoration: TextDecoration.none, color: Colors.black),)),
        ),
      ],
    );

  }
  Widget CommentW(Note note){
    return note.comment == ""?SizedBox():Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 18),
      child: Text("Комментарий: "+note.comment, style: TextStyle(fontSize: 16, color: Colors.black54, decoration: TextDecoration.none, ),),
    );
  }



  void bottomDateWeekend(BuildContext context) {
    String setDateMode2(DateTime date){
      String ye,mo,da,ho,mi;
      ye = date.year.toString();
      mo = date.month<10? "0"+date.month.toString(): date.month.toString();
      da = date.day<10? "0"+date.day.toString(): date.day.toString();
      return  ye+"."+mo+"."+da;
    }
    DateTime setDateWeekend = DateFormat("yyyy.MM.dd").parse(setDateMode2(DateTime.now()));
    String setDateMode(DateTime date){
      String ye,mo,da,ho,mi;
      ye = date.year.toString();
      mo = date.month<10? "0"+date.month.toString(): date.month.toString();
      da = date.day<10? "0"+date.day.toString(): date.day.toString();
      ho = date.hour<10? "0"+date.hour.toString(): date.hour.toString();
      mi = date.minute%60<10?"0"+(date.minute%60).toString():(date.minute%60).toString();
      return  ye+"."+mo+"."+da+" "+ ho+":"+mi ;
    }

    void _showModalBottomSheet(BuildContext context) {
      //ВЫХОДНОЙ
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
                              DBProvider.db.insertWeekends(Weekends(setDateMode(setDateWeekend)));
                              Navigator.pop(context);
                              Navigator.pop(context);

                              setState(() {

                              });
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
                          mode: CupertinoDatePickerMode.date,
                          onDateTimeChanged: (DateTime dateTime) {
                            print(dateTime.toString());
                            setDateWeekend = dateTime;
                            setState(() {

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

  Widget ContentBloc (ContentBlocInfo content){

    DateTime date = content.date;


    /*
    0 - нет ничего
    1 - только приход
    2 - только уход
    3 - полный
    */
    int statusVisit;
    if(content.visit == null){
      statusVisit = 0;
    }else{
      print(content.visit.toMap().toString());
      print(content.visit.date +" on: "+ content.visit.visitOn +" off: "+ content.visit.visitOff);
      if(content.visit.visitOn == ""){
        statusVisit = 2;
        if(content.visit.visitOff == ""){
          statusVisit = 0;
        }
      }else{
        if(content.visit.visitOff != ""){
          statusVisit = 3;
        }else{
          statusVisit = 1;
        }
      }
    }

    //Нет стиля текста
    Widget dateHead(DateTime dateBloc){

      String dayWeek (int dayWeek){
        switch(dayWeek -1){
          case 6:{
            return "Воскресенье";
          }
          case 0:{
            return "Понедельник";
          }
          case 1:{
            return "Вторник";
          }
          case 2:{
            return "Среда";
          }
          case 3:{
            return "Четверг";
          }
          case 4:{
            return "Пятница";
          }
          case 5:{
            return "Суббота";
          }

        }
      }
      bool nowYear (DateTime dateNote)
      {if(dateNote.year == DateTime.now().year) return true; else return false;}



      return Padding(
        padding: const EdgeInsets.only(top: 18, left: 8, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 0,  ),
              child: Text(
                  "${dayWeek(dateBloc.weekday)}", style:
              TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontFamily: "MPLUS",
              ),
              ),
            ),
            Text(
              "${dateBloc.day} ${month(dateBloc.month.toString())} ${nowYear(date)?"":date.year}",
              style:
            TextStyle(
              color: Colors.black54,
              fontSize: 16,
              fontFamily: "MPLUS",
            ),
            ),
          ],
        ),
      );
    }

    Widget visitVidget (){
      print(content.visit);
      String _time (DateTime time){
        String ho, mi;
        ho = time.hour < 10 ? "0" + time.hour.toString() : time.hour.toString();
        mi = time.minute % 60 < 10 ? "0" + (time.minute % 60).toString() : (time.minute % 60).toString();
        return ho+":"+mi;
      }
      bool outFromDay(){
        DateTime nowTime = DateTime.now();
        if(DateParse(content.visit.date).day < nowTime.day){
          print("Условие 1");

          return true;
        }else if(DateParse(content.visit.date).day == nowTime.day && nowTime.hour > 18){
          print("Условие 2");
          return true;}
        return false;
      }

      if(statusVisit == 0 && !content.weekends&& content.visit !=null){

        return outFromDay()?Text("Визит не отмечен", style: TextStyle(fontSize: 14, color: Colors.red.withOpacity(0.8)),):SizedBox();
      }
      if(statusVisit == 0){
        return SizedBox();
      }

      if(statusVisit == 1){
        return Row(
          children: <Widget>[
            Text(_time(DateParse(content.visit.visitOn)), style: TextStyle(color: Colors.black54, fontSize: 16),),
            outFromDay()?Text(" Время ухода", style:  TextStyle(color:  Colors.red.withOpacity(0.8), fontSize: 16),):SizedBox()
          ],
        );
      }
      if(statusVisit == 2){
        return Row(
          children: <Widget>[
            Text("Приход не указан ", style:  TextStyle(color:  Colors.red.withOpacity(0.8), fontSize: 16),),
            Text("- "+_time(DateParse(content.visit.visitOff)), style: TextStyle(color: Colors.black54, fontSize: 16),),

          ],
        );
      }
      if(statusVisit == 3){
        return Row(
          children: <Widget>[
            Text(_time(DateParse(content.visit.visitOn)), style: TextStyle(color: Colors.black54, fontSize: 16),),

            Text(" - "+_time(DateParse(content.visit.visitOff)), style: TextStyle(color: Colors.black54, fontSize: 16),),

          ],
        );
      }


    }

    Widget WeekendWidget(){
      if(content.weekends){
        return  Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 0),
          child: GestureDetector(
            onTap: (){
              showDialog(
                context: context,
                builder: (BuildContext context) => new CupertinoAlertDialog(
                  title: new Text("Выходной"),
                  content: Text("Выберите действие"),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: (){
                        Navigator.pop(context);

                      },
                        isDestructiveAction: true, child: new Text("Отмена")),
                    CupertinoDialogAction(
                        onPressed: ()async{
                          await DBProvider.db.deleteWeekend(DateNull(setDateMode(content.date)));
                          await updateContent();
                          setState(() {

                          });
                          Navigator.pop(context);
                        },
                        isDefaultAction: true, child: new Text("Удалить")

                    ),

                  ],
                ),
              );
            } ,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(
                      color: Color.fromRGBO(150, 15, 45, .3),
                      blurRadius: blurSize,
                      offset: Offset(-2.5, 5)
                  )]
              ),
              width: MediaQuery.of(context).size.width*0.95,
              height: MediaQuery.of(context).size.width*0.20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment:  MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0),
                    child: Text("Выходной день", style: TextStyle(fontSize: 20, color: Colors.red.withOpacity(0.8), shadows: [
                      Shadow(
                      color: Colors.white,
                      offset: Offset(-3, -3),
                      blurRadius: 3,
                    ),]),),
                  )
                ],
              ),
            ),
          ),
        );
      }else {
        return SizedBox();
      }
    }

    Widget NotesWidget(){
      return Column(
        children: List.generate(content.notes.length, (index) {
          return NoteWidget(content.notes[index]);
        }),
      );
    }

    Widget CommentWidget(){
      if(content.comment != null && content.comment != ""){
        return  Padding(
          padding: const EdgeInsets.only(top: 10),
          child: GestureDetector(
            onTap: (){
              showDialog(
                context: context,
                builder: (BuildContext context) => new CupertinoAlertDialog(
                  title: new Text("Заметка"),
                  content: Text("Выберите действие"),
                  actions: [
                    CupertinoDialogAction(
                        onPressed: (){
                          Navigator.pop(context);

                        },
                        isDestructiveAction: true, child: new Text("Отмена")),
                    CupertinoDialogAction(
                        onPressed: ()async{
                          await DBProvider.db.deleteComment(DateNull(setDateMode(content.date)));
                          Navigator.pop(context);

                          await updateContent();
                          setState(() {

                          });
                        },
                        isDefaultAction: true, child: new Text("Удалить")

                    ),

                  ],
                ),
              );
            } ,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(1),
                  borderRadius: BorderRadius.circular(10),

                  boxShadow: [BoxShadow(
                      color: Color.fromRGBO(23, 23, 23, .3),
                      blurRadius: blurSize,
                      offset: Offset(-2.5, 5)
                  )]
              ),
              width: MediaQuery.of(context).size.width*0.95,
              height: MediaQuery.of(context).size.width*0.20,
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 12, bottom: 12,right: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment:  MainAxisAlignment.start,
                  children: [
                    Text("Заметка дня", style: TextStyle(fontSize: 16, color: Colors.black,),),
                    Text(content.comment, style: TextStyle(fontSize: 16, color: Colors.black54,),),
                  ],
                ),
              ),
            ),
          ),
        );
      }else{
        return SizedBox();
      }
    }



    return Container(
      width: MediaQuery.of(context).size.width*0.90,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            dateHead(date),
            statusVisit != 0?Padding(
              padding: const EdgeInsets.only(top: 4, left: 8, bottom: 4),
              child: GestureDetector(
                  onLongPress: ()async{
                    await DBProvider.db.deleteVisit(content.visit.date);
                    await updateContent();
                    setState(() {

                    });
                  },
                  child: visitVidget()),
            ):SizedBox(),
            WeekendWidget(),
            NotesWidget(),
            CommentWidget(),
          ],
        ),
      ),
    );
  }


}



























