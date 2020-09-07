import 'package:flutter/cupertino.dart';
import 'Database.dart';
import 'Objects.dart';

class PagePlus extends StatefulWidget {
  @override
  _PagePlusState createState() => _PagePlusState();
}

class _PagePlusState extends State<PagePlus> {

  @override
  void initState() {
    print("Loading Money plus");

    up();
    super.initState();
  }

  void up(){
     DBProvider.db.getNotesMoneyPlus();

  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
