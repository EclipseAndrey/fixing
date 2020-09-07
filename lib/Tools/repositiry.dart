
import 'package:fixing/Database.dart';

import '../Objects.dart';

class Repository {

Future<List<NoteMoneyPlus>> getNotesMoneyPlus() => DBProvider.db.getNotesMoneyPlus();
Future<bool> insertNoteMoneyPlus (NoteMoneyPlus note) => DBProvider.db.insertNoteMoneyPlus(note);
Future<bool> deleteNoteMoneyPlus (NoteMoneyPlus note) => DBProvider.db.deleteNoteMoneyPlus(note);
Future<bool> updateDateUp (String date) => DBProvider.db.updateDateUp(date);
Future<String> getDateUp () => DBProvider.db.getDateUp();

}