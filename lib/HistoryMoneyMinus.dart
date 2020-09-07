import 'package:fixing/Database.dart';
import 'package:fixing/Objects.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageMinus extends StatefulWidget {
  @override
  _PageMinusState createState() => _PageMinusState();
}

List<MoneyMinus> contentMoneyMinus = [];
class _PageMinusState extends State<PageMinus> {

  bool loadContentM = true;

  updateContent()async{

    print("- Экран затрат Обновление началось");
    loadContentM = true;
    setState(() {});
    contentMoneyMinus = await getContentMoneyMinus();
    loadContentM = false;
    setState(() {});
    print("- Экран затрат Обновление завершилось");

  }



  int Summ =0;

  @override
  void initState() {


    super.initState();
    updateContent();
    setState(() {

    });

  }


  Icon iconSumm(int summ){
    if(summ > 0){
      return Icon(Icons.arrow_upward, color:Colors.green);
    }
    if(summ == 0){
      return Icon(Icons.check, color: Colors.green);
    }
    if(summ < 0){
      return Icon(Icons.arrow_downward, color: Colors.red);
    }
  }

  Color colorSumm(int summ){
    if(summ > 0){
      return Colors.green;
    }
    if(summ == 0){
      return Colors.green;
    }
    if(summ < 0){
      return Colors.red;
    }
  }

  double blurSize = 10;
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width*0.95,
        child: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child:
                SingleChildScrollView(
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
                              side: BorderSide(color: Colors.green)),
                          color: Colors.transparent,
                          textColor: Colors.green,
                          onPressed: () async{
                            displayDialog(false);
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
                                      "Пополнить",
                                      style: TextStyle(
                                          color: Colors.green,
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
//                      Padding(
//                        padding: const EdgeInsets.only(left: 12.0, top: 12),
//                        child: FlatButton(
//                          shape: RoundedRectangleBorder(
//                              borderRadius:
//                              BorderRadius.all(Radius.circular(20.0)),
//                              side: BorderSide(color: Colors.blueAccent)),
//                          color: Colors.transparent,
//                          textColor: Colors.blueAccent,
//                          onPressed: ()async {
//
//                          },
//                          child: Padding(
//                            padding: const EdgeInsets.only(
//                                left: 3.0, right: 3, top: 3, bottom: 3),
//                            child: FittedBox(
//                              fit: BoxFit.scaleDown,
//                              child: Row(
//                                children: [
//                                  Padding(
//                                    padding:
//                                    const EdgeInsets.only(right: 3.0),
//                                    child: SizedBox(
//                                      width: 4,
//                                    ),
//                                  ),
//                                  Padding(
//                                    padding:
//                                    const EdgeInsets.only(right: 8.0),
//                                    child: Text(
//                                      "Корректировка",
//                                      style: TextStyle(
//                                          color: Colors.blueAccent,
//                                          fontSize: 16,
//                                          fontFamily: "MPLUS",
//                                          fontStyle: FontStyle.normal,
//                                          fontWeight: FontWeight.w500),
//                                    ),
//                                  ),
//                                ],
//                              ),
//                            ),
//                          ),
//                        ),
//                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 12.0, top: 12, right: 12),
                        child: FlatButton(
                          onPressed: ()async {
                            await updateContent();
                            setState(() {

                            });
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20.0)),
                              side: BorderSide(color: colorSumm(Summ))),
                          color: Colors.transparent,
                          textColor: Colors.black,

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
                                    child: iconSumm(Summ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      Summ.toString(),
                                      style: TextStyle(
                                          color: colorSumm(Summ),
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
              Content()
            ],
          ),
        ),
      ),
    );
  }
  Widget Content(){

    if(loadContentM){
      return Center(
        child: CupertinoActivityIndicator(),
      );
    }
    else{
      return Padding(
        padding: const EdgeInsets.only(top : 8.0),
        child: Column(
          children: List.generate(contentMoneyMinus.length, (index) {
           if(index == 0)    Summ = 0;

            return Day(contentMoneyMinus[index]);
          }),
        ),
      );
    }
  }

  //Добавление корректировки
  void displayDialog(bool marker) {
    TextEditingController controllersumm = TextEditingController();
    TextEditingController controllerComment = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) => new CupertinoAlertDialog(
        title:  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Новая запись"),
            GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
                displayDialog(!marker);

              },
              child: Icon(Icons.monetization_on, color: marker?Colors.green:Colors.red,  size: 24,),
            )
          ],
        ),
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
            onPressed: (){
              Navigator.pop(context);
            },
              isDestructiveAction: true, child: new Text("Закрыть")),
          CupertinoDialogAction(
              onPressed: ()async{
                if(controllersumm.text != "" || controllersumm != null) {
                  if (controllerComment.text != ""|| controllerComment != null) {
                    print(marker);
                    await DBProvider.db.insertExpansCorrect(Expans(
                        marker ? 999998 : 999999,
                        DateNull(setDateMode(DateTime.now())),
                        controllerComment.text, int.parse(controllersumm.text),
                        "true"));
                    await updateContent();
                    setState(() {

                    });
                    Navigator.pop(context);
                  }
                }
              },
              isDefaultAction: true, child: new Text("Добавить")

          ),

        ],
      ),
    );
  }


  Widget Day(MoneyMinus contentOneDay){
    print("- Экран загрузки Содержание записи ");


    //Выводит сумму нужного цвета
    Widget summController(int summ, bool identificationSumm){
      identificationSumm? Summ += summ: Summ+=0;
      if(summ > 0){
        return Text("+"+summ.toString(), style: TextStyle(color: Colors.green, fontSize: 18),);
      }else{
        if(summ == 0){
          return Text(""+summ.toString(), style: TextStyle(color: Colors.green, fontSize: 18),);
        }else{
          return Text(""+summ.toString(), style: TextStyle(color: Colors.red, fontSize: 18),);
        }
      }
    }

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top :18.0, bottom: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
                color: Colors.white70,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(contentOneDay.date.day.toString()+ " " + month (contentOneDay.date.month.toString()), style: TextStyle(fontSize: 17, color:  Colors.black87, ),),
                )),
          ),
        ),
        Column(
          children: List.generate(contentOneDay.plusList.length, (index) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(
                      color: contentOneDay.plusList[contentOneDay.plusList.length - index - 1].assignId==999999?Color.fromRGBO(34, 15, 180, .3):Color.fromRGBO(70, 240, 30, .3),
                      blurRadius: blurSize,
                      offset: Offset(-2.5, 7)
                  )]
              ),     
              width: MediaQuery.of(context).size.width*0.90,
              child: Padding(
                padding: EdgeInsets.all(18.0),
                child: Row(
                  children: <Widget>[
                    summController(contentOneDay.plusList[contentOneDay.plusList.length - index - 1].summ,contentOneDay.plusList[contentOneDay.plusList.length - index - 1].assignId==999998?false:true ),
                    SizedBox(width: 10,),
                    Text(contentOneDay.plusList[contentOneDay.plusList.length - index - 1].comment, style: TextStyle(color: Colors.black87, fontSize: 16),),
                  ],
                ),
              ),
            );
          }),
        ),
        Container(

          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(
                  color: Color.fromRGBO(34, 15, 45, .3),
                  blurRadius: blurSize,
                  offset: Offset(-2.5, 7)
              )]
          ),               width: MediaQuery.of(context).size.width*0.90,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(contentOneDay.notesList.length, (index) {
            return Column(children: List.generate(contentOneDay.notesList[index].expans.length, (index2) {
              print("- Экран затрат "+ contentOneDay.notesList[index].expans[index2].summ.toString());

            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: <Widget>[
                  summController(-contentOneDay.notesList[index].expans[index2].summ,true),
                  SizedBox(width: 10,),
                  Text(contentOneDay.notesList[index].expans[index2].comment, style: TextStyle(color: Colors.black87, fontSize: 16),),
                ],
              )
            );
            }),);
          }) , ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }

}
