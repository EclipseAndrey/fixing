import 'package:fixing/Database.dart';
import 'package:intl/intl.dart';

String tablehistoryDays = 'historyDays',
    historyDaysId = 'id',
    historyDaysDate = 'date',
    historyDaysComment = 'comment',
    historyDaysAddress = 'address',
    historyDaysTask = 'task',
    historyDaysTimeSpend = 'timeSpend',
    historyDaysTimeStart = 'timeStart',
    tablehistoryWekends = 'historyWekends',
    historyWekendsDate = 'date',
    tablehistoryVisit = 'historyVisit',
    historyVisitDate = 'date',
    historyVisitVisitOn = 'visitOn',
    historyVisitVisitOff = 'visitOff',
    tablecomments = 'comments',
    commentsDate = 'date',
    commentsComment = 'comment',
    tablehistoryMoneyMinus = 'historyMoneyMinus',
    historyMoneyMinusDate = 'date',
    historyMoneyMinusAssignId = 'assignId',
    historyMoneyMinusComment = 'comment',
    historyMoneyMinuSsumm = 'summ',
    historyMoneyMinusCorrect = 'correct',
    tablehistoryMoneyPlus = 'historyMoneyPlus',
    historyMoneyPlusDate = 'date',
    historyMoneyPlusSumm = 'summ',
    historyMoneyPlusComment = 'comment';

class Weekends {
  var date;

  Weekends(this.date);

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['date'] = date;
    return map;
  }

  Weekends.fromMap(Map<String, dynamic> map) {
    date = map['date'];
  }
}

class Comment {
  var date;
  String comment;

  Comment(this.date, this.comment);

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['date'] = date;
    map['comment'] = comment;
    return map;
  }

  Comment.fromMap(Map<String, dynamic> map) {
    date = map['date'];
    comment = map['comment'];
  }
}

class Visit {
  var date;
  var visitOn = "";
  var visitOff = "";

  Visit(this.date, this.visitOn, this.visitOff);

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['date'] = date;
    map['visitOn'] = visitOn;
    map['visitOff'] = visitOff;
    return map;
  }

  Visit.fromMap(Map<String, dynamic> map) {
    date = map['date'];
    visitOn = map['visitOn'];
    visitOff = map['visitOff'];
  }
}

class Expans {
  int assignId;
  var date;
  String comment;
  String correct;
  int summ;

  Expans(this.assignId, this.date, this.comment, this.summ, this.correct);

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['assignId'] = assignId;
    map['date'] = date;
    map['comment'] = comment;
    map['correct'] = correct;
    map['summ'] = summ;
    return map;
  }

  Expans.fromMap(Map<String, dynamic> map) {
    assignId = map['assignId'];
    date = map['date'];
    comment = map['comment'];
    correct = map['correct'];
    summ = map['summ'];
  }
}

class Note {
  List<Expans> expans = [];
  int id;
  var date;
  String comment = "no";
  String address;
  String task;
  var timeSpend;
  var timeStart;

  Note(this.id, this.date, this.address, this.task, this.timeSpend,
      this.timeStart, this.comment);

  Note.noId(this.date, this.address, this.task, this.timeSpend, this.timeStart,
      this.comment);

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['date'] = date;
    map['address'] = address;
    map['task'] = task;
    map['timeSpend'] = timeSpend;
    map['timeStart'] = timeStart;
    map['comment'] = comment;
    return map;
  }

  Note.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    date = map['date'];
    address = map['address'];
    task = map['task'];
    timeSpend = map['timeSpend'];
    timeStart = map['timeStart'];
    comment = map['comment'];
  }
}

class NoteMoneyPlus {
  var date;
  String comment;
  int summ;

  NoteMoneyPlus(this.date, this.comment, this.summ);

  Map<String, dynamic> toMap(){
    final map = Map<String, dynamic>();
    map['date'] = date;
    map['comment'] = comment;
    map['summ'] = summ;
    return map;
  }
  NoteMoneyPlus.fromMap(Map<String, dynamic> map){
    date = map['date'];
    comment = map['comment'];
    summ = map['summ'];
  }

}


String month(String month) {
  switch (month) {
    case "1":
      return "Января";
      break;
    case "2":
      return "Февраля";
      break;
    case "3":
      return "Марта";
      break;
    case "4":
      return "Апреля";
      break;
    case "5":
      return "Мая";
      break;
    case "6":
      return "Июня";
      break;
    case "7":
      return "Июля";
      break;
    case "8":
      return "Августа";
      break;
    case "9":
      return "Сентября";
      break;
    case "10":
      return "Октября";
      break;
    case "11":
      return "Ноября";
      break;
    case "12":
      return "Декабря";
      break;
  }
}

String setDateMode(DateTime date) {
  String ye, mo, da, ho, mi;
  ye = date.year.toString();
  mo = date.month < 10 ? "0" + date.month.toString() : date.month.toString();
  da = date.day < 10 ? "0" + date.day.toString() : date.day.toString();
  ho = date.hour < 10 ? "0" + date.hour.toString() : date.hour.toString();
  mi = date.minute % 60 < 10 ? "0" + (date.minute % 60).toString() : (date.minute % 60).toString();
  return ye + "." + mo + "." + da + " " + ho + ":" + mi;
}

String DateNull(String date1) {
  DateTime date = DateFormat("yyyy.MM.dd HH:mm").parse(date1);
  String ye, mo, da;
  ye = date.year.toString();
  mo = date.month < 10 ? "0" + date.month.toString() : date.month.toString();
  da = date.day < 10 ? "0" + date.day.toString() : date.day.toString();
  return ye + "." + mo + "." + da + " " + "00" + ":" + "00";
}

DateTime DateParse (String date){
  return DateFormat("yyyy.MM.dd HH:mm").parse(date);
}

class ContentBlocInfo {
  DateTime date;

  /*
  Загодовок дата
  Время посещения
  Блок выходного
  карточки заданий
  комментарий
   */
  Visit visit;
  bool weekends;
  List<Note> notes = [];
  String comment;

  ContentBlocInfo(
      this.date, this.visit, this.weekends, this.notes, this.comment);
}

class MoneyMinus{
  DateTime date;
  List<Note> notesList =[];
  List<Expans> plusList = [];
  MoneyMinus(this.date,this.notesList,this.plusList);
}

Future<List<MoneyMinus>> getContentMoneyMinus()async{
  List<DateTime> _Dates = [];
  List<Note> _ListNotes = [];
  List<Expans> _ListExpansM = [];
  List<MoneyMinus> _ListContent = [];

  _ListNotes = await DBProvider.db.getNotes();
  _ListExpansM = await DBProvider.db.getExpansCorrect();

  for(int i = 0; i < _ListNotes.length; i++){
    _ListNotes[i].expans = await DBProvider.db.getExpans(_ListNotes[i].id);
  }


  //если даты такой нет и есть затраты занести дату в список
  for (int i = 0; i < _ListNotes.length; i++) {
    DateTime step =
    DateFormat("yyyy.MM.dd HH:mm").parse(DateNull(_ListNotes[i].date));
    bool find = false;
    for (int j = 0; j < _Dates.length; j++) {
      if (_Dates[j] == step) {
          find = true;
          j = _Dates.length;
          break;
        }
    }
    if (find == false) {
      if(_ListNotes[i].expans.length > 0)
      _Dates.add(step);
    }
  }


  for (int i = 0; i < _ListExpansM.length; i++) {
    DateTime step =
    DateFormat("yyyy.MM.dd HH:mm").parse(DateNull(_ListExpansM[i].date));
    bool find = false;
    for (int j = 0; j < _Dates.length; j++) {
      if (_Dates[j] == step) {
        find = true;
        j = _Dates.length;
        break;
      }
    }
    if (find == false) {
      _Dates.add(step);
    }
  }



  if (_Dates.length > 1)
    for (int i = 0; i < _Dates.length-1; i++) {
      for (int r = 0; r < _Dates.length-1 - i; r++) {
        if (_Dates[r + 1].isAfter(_Dates[r])) {
          DateTime temp = _Dates[r];
          _Dates[r] = _Dates[r + 1];
          _Dates[r + 1] = temp;
        }
      }
    }

  for(int d= 0; d < _Dates.length; d++){
    DateTime date = _Dates[d];
    List<Note> noteslist = [];
    List<Expans> expansList = [];
    for(int i = 0; i < _ListNotes.length; i++){
      if (date ==
          DateFormat("yyyy.MM.dd HH:mm").parse(DateNull(_ListNotes[i].date))) {
        noteslist.add(_ListNotes[i]);
      }
    }
    for(int i = 0; i < _ListExpansM.length; i++){
      if (date ==
          DateFormat("yyyy.MM.dd HH:mm").parse(DateNull(_ListExpansM[i].date))) {
        expansList.add(_ListExpansM[i]);
      }
    }


    _ListContent.add(MoneyMinus(_Dates[d],noteslist,expansList ));
  }
  return _ListContent;

}

Future<List<ContentBlocInfo>> getContentBlocs() async {
  List<Visit> _ListVisit;
  List<Weekends> _ListWeekends;
  List<Note> _ListNotes;
  List<Comment> _ListComment;
  List<DateTime> _Dates = [];
  List<ContentBlocInfo> _ListContent = [];


  _ListVisit = await DBProvider.db.getVisits(); // 2
  _ListWeekends = await DBProvider.db.getWeekends(); // 3
  _ListNotes = await DBProvider.db.getNotes(); // 1
  _ListComment = await DBProvider.db.getAllComments(); // 4

  for (int i = 0; i < _ListNotes.length; i++) {
    DateTime step =
        DateFormat("yyyy.MM.dd HH:mm").parse(DateNull(_ListNotes[i].date));
    bool find = false;
    for (int j = 0; j < _Dates.length; j++) {
      if (_Dates[j] == step) {
        find = true;
        j = _Dates.length;
        break;
      }
    }
    if (find == false) {
      _Dates.add(step);
    }
  }
  for (int i = 0; i < _ListVisit.length; i++) {
    DateTime step =
        DateFormat("yyyy.MM.dd HH:mm").parse(DateNull(_ListVisit[i].date));
    bool find = false;
    for (int j = 0; j < _Dates.length; j++) {
      if (_Dates[j] == step) {
        find = true;
        j = _Dates.length;
        break;
      }
    }
    if (find == false) {
      _Dates.add(step);
    }
  }
  for (int i = 0; i < _ListWeekends.length; i++) {
    DateTime step =
        DateFormat("yyyy.MM.dd HH:mm").parse(DateNull(_ListWeekends[i].date));
    bool find = false;
    for (int j = 0; j < _Dates.length; j++) {
      if (_Dates[j] == step) {
        find = true;
        j = _Dates.length;
        break;
      }
    }
    if (find == false) {
      _Dates.add(step);
    }
  }
  for (int i = 0; i < _ListComment.length; i++) {
    DateTime step =
        DateFormat("yyyy.MM.dd HH:mm").parse(DateNull(_ListComment[i].date));
    bool find = false;
    for (int j = 0; j < _Dates.length; j++) {
      if (_Dates[j] == step) {
        find = true;
        j = _Dates.length;
        break;
      }
    }
    if (find == false) {
      _Dates.add(step);
    }
  }
  if (_Dates.length > 1)
    for (int i = 0; i < _Dates.length-1; i++) {
      for (int r = 0; r < _Dates.length-1 - i; r++) {
        if (_Dates[r + 1].isAfter(_Dates[r])) {
          DateTime temp = _Dates[r];
          _Dates[r] = _Dates[r + 1];
          _Dates[r + 1] = temp;
        }
      }
    }

  for (int i = 0; i < _Dates.length; i++) {
    print(i.toString() + " "+_Dates[i].toString());
  }

  for (int i = 0; i < _Dates.length; i++) {
    DateTime date = _Dates[i];
    Visit visit;
    bool weekends = false;
    List<Note> notes = [];
    String comment = "";





    for (int j = 0; j < _ListVisit.length; j++) {
      if (DateFormat("yyyy.MM.dd HH:mm").parse(DateNull(_ListVisit[j].date)) ==
          date) {
        visit = _ListVisit[j];
      }
    }
    for (int j = 0; j < _ListWeekends.length; j++) {
      if (date ==
          DateFormat("yyyy.MM.dd HH:mm")
              .parse(DateNull(_ListWeekends[j].date))) {
        weekends = true;
      }
    }
    for (int j = 0; j < _ListNotes.length; j++) {
      if (date ==
          DateFormat("yyyy.MM.dd HH:mm").parse(DateNull(_ListNotes[j].date))) {
        notes.add(_ListNotes[j]);
      }
    }
    for (int j = 0; j < _ListComment.length; j++) {
      if (date ==
          DateFormat("yyyy.MM.dd HH:mm")
              .parse(DateNull(_ListComment[j].date))) {
        comment = _ListComment[j].comment;
      }
    }
    if (notes.length > 1)
      for (int i = 0; i < notes.length-1; i++) {
        for (int r = 0; r < notes.length-1 - i; r++) {
          if (DateFormat("yyyy.MM.dd HH:mm").parse(notes[r + 1].date).isAfter(DateFormat("yyyy.MM.dd HH:mm").parse(notes[r].date))) {
            Note temp = notes[r];
            notes[r] = notes[r + 1];
            notes[r + 1] = temp;
          }
        }
      }


    for(int i = 0; i < notes.length; i++){
      notes[i].expans = await DBProvider.db.getExpans(notes[i].id);
    }


    _ListContent.add(ContentBlocInfo(date, visit, weekends, notes, comment));
  }

  return _ListContent;
}


List<NoteMoneyPlus> sortListMoneyPlus (List<NoteMoneyPlus> Notes){
  for( int i = 0; i < Notes.length; i++){
    for(int j = 0; j < Notes.length - i - 1; i++){
      DateTime a = Notes[j].date;
      DateTime b = Notes[j+1].date;

      if(a.isBefore(b)){
        Notes[j].date = b;
        Notes[j+1].date = a;
      }
    }
  }


  String total = "=== Money plus ===\n";
  for(int i = 0; i < Notes.length; i++){
    total += Notes[i].date.toString() + "\n";

  }
  print(total);

}


