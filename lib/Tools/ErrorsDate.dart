import 'package:fixing/Objects.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

void errorDate() async {
  DateTime date = DateTime.now();
  String dateStep = setDateMode(date);

  final prefs = await SharedPreferences.getInstance();
  prefs.setString("DateUp", dateStep);
}