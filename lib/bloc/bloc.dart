import 'package:fixing/Objects.dart';
import 'package:fixing/Tools/ErrorsDate.dart';
import 'package:fixing/Tools/repositiry.dart';
import 'package:fixing/bloc/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import 'events.dart';


class ContentBloc extends Bloc<Event, StateBase>{
  final Repository repository;


  ContentBloc({this.repository}):assert (Repository != null), super(StateStart());

  @override
  Stream<StateBase> mapEventToState(event) async* {
    if(event is EventBase){
      yield StateStart();
      try{
       var notes = await repository.getNotesMoneyPlus();
       var date = await repository.getDateUp();
       if(date == 'none'){
         await errorDate();
         date = await repository.getDateUp();

       }
       yield StateCompleteContext(notes);
       yield StateCompleteSummBU(date, notes);
      }
      catch(_){
        yield StateErr();
      }
    }


    if(event is EventAddNullDate){
      yield StateLoadingSummBU();
      await repository.updateDateUp(setDateMode(DateTime.now()));
      var date = await repository.getDateUp();
      if(date == 'none'){
        await errorDate();
        date = await repository.getDateUp();
      }
      var notes = await repository.getNotesMoneyPlus();
      yield StateCompleteContext(notes);
      yield StateCompleteSummBU(date, notes);

    }
    if( event is EventDialogClose){

    }
    if(event is EventBase){

    }


    throw UnimplementedError();
  }
}