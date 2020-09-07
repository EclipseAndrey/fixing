import 'package:intl/intl.dart';

import '../Database.dart';
import '../Objects.dart';

Future<List<ContentBlocInfo>> getContentHistory() async {
  List<Note> _ListNotes;
  List<DateTime> _Dates = [];
  List<ContentBlocInfo> _ListContent = [];

  _ListNotes = await DBProvider.db.getNotes(); // 1

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


    for (int j = 0; j < _ListNotes.length; j++) {
      if (date ==
          DateFormat("yyyy.MM.dd HH:mm").parse(DateNull(_ListNotes[j].date))) {
        notes.add(_ListNotes[j]);
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

