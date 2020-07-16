import 'package:fixing/AddTask.dart';
import 'package:flutter/material.dart';
import './History.dart' as history;
import './HistoryMoneyMinus.dart' as minus;
import './HistoryMoneyPlus.dart' as plus;
import './General.dart' as general;

final routes = <String, WidgetBuilder>{
  // Путь
  '/add': (BuildContext context) => AddTask(),
};

void main() {


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,

      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController controller;


  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 4, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
//        bottomOpacity: 0.0,
        elevation: 0.0,
        title: TabBar(

            indicatorColor: Colors.black,
            controller: controller,
            tabs: <Tab>[
              new Tab(icon: new Icon(Icons.money_off, color: Colors.black,)),
              new Tab(icon: new Icon(Icons.home, color: Colors.black,)),
              new Tab(icon: new Icon(Icons.history, color: Colors.black,)),
              new Tab(icon: new Icon(Icons.monetization_on, color: Color.fromRGBO(0, 0, 0, 1),)),
            ]
        ),
      ),
      backgroundColor: Colors.white.withOpacity(0.94),
      body: TabBarView(

        controller: controller,
          children: <Widget>[
            minus.PageMinus(),
            general.General(),
            history.History(),
            plus.PagePlus(),
          ],
      ),
    );
  }
}



