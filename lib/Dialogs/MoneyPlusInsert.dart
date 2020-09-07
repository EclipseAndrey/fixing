import 'package:fixing/bloc/bloc.dart';
import 'package:fixing/bloc/events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fixing/Database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Objects.dart';

void displayDialog(BuildContext context) {
  TextEditingController controllersumm = TextEditingController();
  TextEditingController controllerComment = TextEditingController();

  // ignore: close_sinks
  final ContentBloc bloc = BlocProvider.of<ContentBloc>(context);

  showDialog(
    context: context,
    builder: (BuildContext context) => new CupertinoAlertDialog(
      title: new Text("Новая запись"),
      content: Column(
        children: <Widget>[
          Material(
            color: Colors.transparent,
            child: TextField(
              controller: controllersumm,
              decoration: InputDecoration(
                  hintText: "Сумма"
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: TextField(
              controller: controllerComment,
              decoration: InputDecoration(
                  hintText: "Комментарий"
              ),
            ),
          )

        ],
      ),
      actions: [
        CupertinoDialogAction(
            isDestructiveAction: true, child: new Text("Закрыть")),
        CupertinoDialogAction(
            onPressed: ()async{
              await DBProvider.db.insertNoteMoneyPlus(NoteMoneyPlus(setDateMode(DateTime.now()),controllerComment.text,int.parse(controllersumm.text)));
              bloc.add(EventBase());
              Navigator.pop(context);
            },
            isDefaultAction: true, child: new Text("Добавить")

        ),

      ],
    ),
  );
}
