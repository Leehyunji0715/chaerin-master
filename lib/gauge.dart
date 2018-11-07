import 'package:flutter/material.dart';
import 'mainPageMH.dart';

class GaugeWidget extends StatefulWidget{
  @override
  _GaugeWidgetState createState() => _GaugeWidgetState();
}

class _GaugeWidgetState extends State<GaugeWidget> {

  Color postitiveColor = new Color(0xFFEF0078);
  Color negetiveColor = new Color(0xFFFFFFFF);
  //double percentage = 30.0;
  double percentage = HomeState3.count_true/HomeState3.count_all;
  //percentage에 따라 게이지 바 차오르는게 다름 ==> 30.0 -> 직접 카운트한 친구로 만
  double initial = 0.0;
 

  @override
  Widget build(BuildContext context) {
      return CustomSlider(
        percentage: this.percentage,
        positiveColor: postitiveColor,
        negetiveColor: negetiveColor,
      );
  }
}


class CustomSlider extends StatelessWidget {
  double totalWidth = 300.0;
  //double percentage = 20.0;
  double percentage = HomeState3.count_true/HomeState3.count_all;
  Color positiveColor;
  Color negetiveColor;

  CustomSlider({this.percentage, this.positiveColor, this.negetiveColor});
 
  @override
  Widget build(BuildContext context) {
    print((percentage / 100) * totalWidth);
    print((1 - percentage / 100) * totalWidth);
    return Container(
      width: totalWidth + 4.0,
      height: 35.0,
      decoration: BoxDecoration(
          color: negetiveColor,
          border: Border.all(color: Colors.black, width: 2.0)),

      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            color: positiveColor,
            width: (percentage / 100) * totalWidth,
          ),
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
 
class _MyHomePageState extends State<MyHomePage> {
  Color postitiveColor = new Color(0xFFEF0078);
  Color negetiveColor = new Color(0xFFFFFFFF);
  //double percentage = 30.0;
  double percentage = (HomeState3.count_true/HomeState3.count_all);
  //일단 적용이 안되길래 바꿔봄

  double initial = 0.0;
 
  @override
  Widget build(BuildContext context) {

    return Scaffold(
    //return MaterialApp(
      backgroundColor: Colors.white,
      appBar: AppBar(
      
        backgroundColor: Colors.red[200],
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'CUSTOM SLIDER',
          style: TextStyle(color: postitiveColor),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              percentage.round().toString() + ' %', // 여기가 퍼센테이지 값을 출력하는 부분
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 70.0,
                color: postitiveColor,
              ),
            ),
            GestureDetector(
              onPanStart: (DragStartDetails details) {
                //initial = details.globalPosition.dx;
                initial = HomeState3.count_true/HomeState3.count_all;
              },
              onPanUpdate: (DragUpdateDetails details) {
                double distance = details.globalPosition.dx - initial;
                double percentageAddition = distance / 200;
 
                print('distance ' + distance.toString());
                setState(() {
                  print('percentage ' +
                      (percentage + percentageAddition)
                          .clamp(0.0, 100.0)
                          .toString());
                  percentage =
                      (percentage + percentageAddition).clamp(0.0, 100.0);
                });
              },
              onPanEnd: (DragEndDetails details) {
                initial = 0.0;
              },
              child: CustomSlider(
                percentage: this.percentage,
                positiveColor: postitiveColor,
                negetiveColor: negetiveColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
  //게이지바