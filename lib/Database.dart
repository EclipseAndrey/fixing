import 'dart:io';
import 'Objects.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBProvider{

  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if(_database != null) return _database;

    _database  = await _initDB();
    return _database;
  }

  Future<Database> _initDB()async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path  = dir.path+"base5.db";
    return await openDatabase(path, version: 1, onCreate : _createDB);
  }

  void _createDB (Database db, int version)async{
    //print('CREATE TABLE $tablehistoryDays( $historyDaysId INTEGER PRIMARY KEY AUTOINCREMENT, $historyDaysAddress TEXT, $historyDaysComment TEXT, $historyDaysDate DATETIME(), $historyDaysTask TEXT, $historyDaysTimeSpend TIME(), $historyDaysTimeStart DATETIME() );',);
    await db.execute('CREATE TABLE $tablehistoryDays ( $historyDaysId INTEGER PRIMARY KEY AUTOINCREMENT, $historyDaysAddress TEXT, $historyDaysComment TEXT, $historyDaysDate DATETIME, $historyDaysTask TEXT, $historyDaysTimeSpend TIME, $historyDaysTimeStart DATETIME )',);
    await db.execute('CREATE TABLE $tablehistoryWekends ( $historyWekendsDate DATETIME )',);
    await db.execute('CREATE TABLE $tablecomments ( $commentsDate DATETIME, $commentsComment TEXT )',);
    await db.execute('CREATE TABLE $tablehistoryMoneyMinus ( $historyMoneyMinusAssignId INTEGER, $historyMoneyMinusComment TEXT, $historyMoneyMinusCorrect TEXT, $historyMoneyMinusDate DATETIME, $historyMoneyMinuSsumm INT )',);
    await db.execute('CREATE TABLE $tablehistoryVisit ( $historyVisitDate DATETIME, $historyVisitVisitOn DATETIME,$historyVisitVisitOff DATETIME)',);
    await db.execute('CREATE TABLE $tablehistoryMoneyPlus ( $historyMoneyPlusDate DATETIME, $historyMoneyPlusSumm INTEGER, $historyMoneyPlusComment TEXT )',);
  }

  //all notes
  Future<List<Note>> getNotes()async{
    print("get Notes");
    Database db = await this.database;
    final List<Map<String,dynamic>> NotesMapList = await db.query(tablehistoryDays);
    final List<Note> NoteList = [];
    NotesMapList.forEach((element) {
      NoteList.add(Note.fromMap(element));
    });
    return NoteList;
  }

  Future<Note>insertNote(Note note, List<Expans> expansList)async{
    Database db = await this.database;
    print("connect Base ok");
    note.id = await db.insert(tablehistoryDays, note.toMap());
    print("insert note ${note.id}");


    for(int i = 0; i < expansList.length; i++){
      print("insert expans $i");
      expansList[i].assignId = note.id;
      await db.insert(tablehistoryMoneyMinus, expansList[i].toMap());
    }

  }

  Future<bool> deleteNote (String date)async{
    Database db = await this.database;
    print("delete note");
    final List<Map<String,dynamic>> NotesMapList = await db.query(tablehistoryDays, where: "$historyDaysDate = ?" ,whereArgs: [date]);
    final List<Note> NoteList = [];
    NotesMapList.forEach((element) {
      NoteList.add(Note.fromMap(element));
    });
    if(NoteList.length > 0){
      await db.delete(tablehistoryDays, where: "$historyDaysDate = ?", whereArgs: [date]);
      return true;
    }else{
      return false;
    }
  }

  Future<List<Expans>> getExpans(int id)async{
    print("get Expans");
    Database db = await this.database;
    final List<Map<String,dynamic>> ExpansMapList =
    await db.query(tablehistoryMoneyMinus,
        where: "$historyMoneyMinusAssignId = ?",
        whereArgs: [id]);
    final List<Expans> ExpansList = [];
    ExpansMapList.forEach((element) {
      ExpansList.add(Expans.fromMap(element));
    });
    return ExpansList;
  }

  Future<List<Expans>> getExpansCorrect()async{
    print("get Expans correct");
    Database db = await this.database;
    final List<Map<String,dynamic>> ExpansMapList =
    await db.query(tablehistoryMoneyMinus,
        where: "$historyMoneyMinusCorrect = ?",
        whereArgs: ["true"]);
    final List<Expans> ExpansList = [];
    ExpansMapList.forEach((element) {
      ExpansList.add(Expans.fromMap(element));
    });
    return ExpansList;
  }

  Future<bool> insertExpansCorrect(Expans expans)async{
    Database db = await this.database;
    print("insert correct expans");
    await db.insert(tablehistoryMoneyMinus, expans.toMap());
    return true;
  }

  Future<bool> deleteExpansCorrect(String date)async{
    Database db = await this.database;
    print("delete expans");
    await db.delete(tablehistoryMoneyMinus, where: "$historyMoneyPlusDate = ?", whereArgs: [date]);
    return true;
  }

  Future<List<Weekends>> getWeekends()async{
    print("getWeekends");
    Database db = await this.database;
    final List<Map<String,dynamic>> WeekendsMaplist =
        await db.query(tablehistoryWekends);
    final List<Weekends> WeekendsList = [];
    WeekendsMaplist.forEach((element) {
      WeekendsList.add(Weekends.fromMap(element));
    });
    return WeekendsList;
  }

  Future<int> insertWeekends(Weekends week)async{
    print("insertWeekends");
    Database db = await this.database;
    final List<Map<String,dynamic>> WeekendsMaplist =
    await db.query(tablehistoryWekends, where: "$historyWekendsDate = ?", whereArgs: [week.date]);
    final List<Weekends> WeekendsList = [];
    WeekendsMaplist.forEach((element) {
      WeekendsList.add(Weekends.fromMap(element));
      print(element.toString());
    });

    if(WeekendsList.length != 0) {
      print("insert Weekends error, found date ${week.date}");
      print("count found ${WeekendsList.length}");
      return 1;}
    print("insertWeekends inserting");

    await db.insert(tablehistoryWekends, week.toMap());
    return 200;
  }

  Future<bool> deleteWeekend (String date)async{
    print("delete Weekend");
    Database db = await this.database;
    final List<Map<String,dynamic>> WeekendsMaplist =
        await db.query(tablehistoryWekends, where: "$historyWekendsDate = ?", whereArgs: [date]);
    final List<Weekends> WeekendsList = [];
    WeekendsMaplist.forEach((element) {
      WeekendsList.add(Weekends.fromMap(element));
    });
    if(WeekendsList.length > 0){
      await db.delete(tablehistoryWekends, where: "$historyWekendsDate = ?", whereArgs: [date]);
      return true;
    }else{return false;}
  }

  Future<List<Comment>>getAllComments()async{
    print("getAllComments");
    Database db = await this.database;
    final List<Map<String,dynamic>> CommentsMapList =
        await db.query(tablecomments);
    final List<Comment> CommentsList = [];
    CommentsMapList.forEach((element) {
      CommentsList.add(Comment.fromMap(element));
    });

    return CommentsList;

  }

  Future<bool> deleteComment(String date)async{
    print("deleteComment");
    Database db = await this.database;
    db.delete(tablecomments, where: "$commentsDate = ?", whereArgs: [date]);
    return true;
  }

  Future<Comment>getCommentsForDate(String date)async{
    print("getAllComments");
    Database db = await this.database;
    final List<Map<String,dynamic>> CommentsMapList =
    await db.query(tablecomments, where: "$commentsDate = ?", whereArgs: [date]);
    final List<Comment> CommentsList = [];
    CommentsMapList.forEach((element) {
      CommentsList.add(Comment.fromMap(element));
    });

    if(CommentsList.length > 0) {return CommentsList[0];} else {return null;}

  }

  Future<int> insertComments (Comment comment)async{
    print("insertComments");
    Database db = await this.database;
    final List<Map<String,dynamic>> CommentsMapList =
        await db.query(tablecomments, where: "$commentsDate = ?", whereArgs:  [comment.date]);
    final List<Comment> CommentsList = [];
    CommentsMapList.forEach((element) {
      CommentsList.add(Comment.fromMap(element));
    });
    if(CommentsList.length > 0){
      print("Update comment");
      await db.update(tablecomments, comment.toMap(), where: '$commentsDate = ?', whereArgs: [comment.date]);
      return 1;
    }else{
      print("New comment");
      await db.insert(tablecomments, comment.toMap());
      return 2;
    }
  }

  Future<int> insertVisitOn (String date)async{
    print("inset visitOn");
    Database db = await this.database;
    final List<Map<String,dynamic>> VisitMapList =
        await db.query(tablehistoryVisit, where: "$historyVisitDate = ?", whereArgs: [DateNull(date)]);
    List<Visit> VisitList = [];
    VisitMapList.forEach((element) {
      VisitList.add(Visit.fromMap(element));
    });
    if(VisitList.length > 0){
      if(VisitList[0].visitOn != null ||VisitList[0].visitOn != ""){
        print("Update VisitOn");
      }else{
        print("insert VisitOn");
      }
      print("Проверка найденого элемента для редактирования Уход:"+VisitList[0].visitOff+ " Когда "+ VisitList[0].date);

      await db.delete(tablehistoryVisit, where: "$historyVisitDate = ?", whereArgs: [DateNull(date)]);
      VisitList[0].visitOn = date;
      await db.insert(tablehistoryVisit, VisitList[0].toMap());

      return 1;

    }else{
      print("insert visit for visitOn");

      await db.insert(tablehistoryVisit, Visit(DateNull(date),date,"").toMap());
    }

  }

  Future<int> insertVisitOff (String date)async{
    print("inset visitOff");
    Database db = await this.database;
    final List<Map<String,dynamic>> VisitMapList =
    await db.query(tablehistoryVisit, where: "$historyVisitDate = ?", whereArgs: [DateNull(date)]);
    List<Visit> VisitList = [];
    VisitMapList.forEach((element) {
      VisitList.add(Visit.fromMap(element));
    });
    if(VisitList.length > 0){
      if(VisitList[0].visitOff != null ||VisitList[0].visitOff != ""){
        print("Update VisitOff");
      }else{
        print("insert VisitOff");
      }
      VisitList[0].visitOff = date;
      print("Проверка найденого элемента для редактирования Приход:"+VisitList[0].visitOn+ " Когда "+ VisitList[0].date);
      await db.delete(tablehistoryVisit,where: "$historyVisitDate = ?", whereArgs: [DateNull(date)]);

      await db.insert(tablehistoryVisit, VisitList[0].toMap());
      return 1;

    }else{
      print("insert visit for visitOff");
      await db.insert(tablehistoryVisit, Visit(DateNull(date),date,"").toMap());
    }

  }

  Future<bool> deleteVisit(String date)async{
    print("delete visit ");
    Database db = await this.database;
    await db.delete(tablehistoryVisit,where: "$historyVisitDate = ?", whereArgs: [DateNull(date)]);
    return true;
  }

  Future<List<Visit>> getVisits()async{
    print("getVisit");
    Database db = await this.database;
    final List<Map<String,dynamic>> VisitMapList =
    await db.query(tablehistoryVisit);
    List<Visit> VisitList = [];
    VisitMapList.forEach((element) {
      print(element);
      VisitList.add(Visit.fromMap(element));
    });
    return VisitList;
  }








}