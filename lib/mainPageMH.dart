
//import 'package:firebase_database/firebase_database.dart';
//
//import 'package:flutter/material.dart';
//import 'package:login5/Dialogs.dart';
//import 'package:login5/gauge.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:login5/menu.dart';
//import 'gloals.dart' as globals;
//import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'dart:async';
//import 'dart:math';
//import 'login_page.dart';
//
//class Home3 extends StatefulWidget{
//  HomeState3 createState() =>HomeState3();
//}
//
//
/////*현지가 선언한 파이어스토어 인스턴스...*/
//final Firestore store = Firestore.instance;
//
//class HomeState3 extends State<Home3> {
//  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
//  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//  new FlutterLocalNotificationsPlugin();
//
//  final Firestore store = Firestore.instance;
//  DatabaseReference itemRef;
//  static int count_true = 1; // 게이지바를 채우기 위한 카운트, complete = true만 담는다.
//  static int count_all = 10; // 게이지바를 채우기 위한 카운트, 모든 유저의 미션 개수를 담는다.
//  static int i = 0;
//  static int all_uid = 0;
//  static List<int> random;
//
//  String percentage;
//
//
//  String textValue = 'Hello World!';
//
//  @override
//  void initState() {
//    super.initState();
//    var android = new AndroidInitializationSettings('mipmap/ic_launcher');
//    var ios = new IOSInitializationSettings();
//    var platform = new InitializationSettings(android, ios);
//    flutterLocalNotificationsPlugin.initialize(platform);
//    firebaseMessaging.configure(
//      onMessage: (Map<String, dynamic> msg) {
//        showNotification(msg);
//        print(" onMessage called ${(msg)}");
//      },
//      onResume: (Map<String, dynamic> msg) {
//        print(" onResume called ${(msg)}");
//      },
//      onLaunch: (Map<String, dynamic> msg) {
//        print(" onLaunch called ${(msg)}");
//      },
//    );
//
//
//    firebaseMessaging.requestNotificationPermissions(
//        const IosNotificationSettings(sound: true, alert: true, badge: true));
//
//    firebaseMessaging.onIosSettingsRegistered
//        .listen((IosNotificationSettings) {
//      print('IOS Setting Registered');
//    });
//    firebaseMessaging.getToken().then((token) {
//      update(token);
//    });
//  }
//
//  showNotification(Map<String, dynamic> msg) async {
//    var android = new AndroidNotificationDetails(
//        'channel_id', "CHANNLE NAME", "channelDescription");
//    var iOS = new IOSNotificationDetails();
//    var platform = new NotificationDetails(android, iOS);
//    await flutterLocalNotificationsPlugin.show(
//        0, "This is title", "This is demo", platform);
//  }
//
//  update(String token) {
//    print(token);
//    DatabaseReference databaseReference = new FirebaseDatabase().reference();
//    databaseReference.child('fcm-token/${token}').set({"token": token});
//    textValue = token;
//    setState(() {});
//  }
//
//
//  void getUID_length() {
//    new StreamBuilder(
//      stream: Firestore.instance.collection('login').snapshots(),
//      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//        if (!snapshot.hasData) return CircularProgressIndicator();
//        return FirestoreListView(documents: snapshot.data.documents);
//      },
//    );
//  }
//
//
//  Dialogs dialogs = new Dialogs();
//
//
//  Widget build(BuildContext context) {
//    CustomSlider gauge = new CustomSlider(
//
//      percentage: (count_true / count_all) * 100, //여기가 slider의 게이지 차는모양(형태) 부분
//      positiveColor: Color(0xFFEF0078),
//      negetiveColor: Color(0xFFFFFFFF),
//    );
////      return Scaffold(
////        appBar: AppBar(
////          title: Text('Cloud Firestore Example'),
////          centerTitle: true,
////          actions: <Widget>[
////            IconButton(
////              icon: Icon(Icons.send),
////              onPressed: () {
////                Firestore.instance
////                    .runTransaction((Transaction transaction) async {
////                  CollectionReference reference =
////                  Firestore.instance.collection('login');
////
////
////                  await reference
////                      .add({
////                    "posting": "",
////                    "editing": false,
////                    "uid": globals.userUID
////                  });
////                });
////              },
////            )
////
////          ],
////        ),
//////        body: StreamBuilder(
//////          stream: Firestore.instance.collection('login').snapshots(),
//////          builder: (BuildContext context,
//////              AsyncSnapshot<QuerySnapshot> snapshot) {
//////            if (!snapshot.hasData) return CircularProgressIndicator();
//////            return FirestoreListView(documents: snapshot.data.documents);
//////          },
//////        ),
//
//     // );
//
//    return Scaffold(
//
//      appBar: AppBar(
//      backgroundColor: Colors.red[200],
//    ),
//      drawer:MenuPage(),
//      resizeToAvoidBottomPadding: false,
//
//      body:
//      Column(
//        children: <Widget>[
////          Flexible(
////            flex: 0,
////            child: Center(
////                child: Form(
////                  //key: formkey,
////                  child: Flex(
////                    direction: Axis.vertical,
////                    children: <Widget>[
////                      SizedBox(height: 25.0),
////                      gauge,
////                      //Text(percentage = ((count_true/count_all)*100).toInt().toString()+'%'),
////
////                      SizedBox(height: 40.0),
////                      new RaisedButton(
////                        color: Colors.amber[50],
////                        child: new Text('Success!',
////                          style: new TextStyle(fontSize: 20.0,
////                            fontWeight: FontWeight.w600,color: Colors.blue),
////                        ),
////                        onPressed: (){
////
////                          //handleSubmit_c();
////                          //setValue();
////                          setState(() {
////                            //gauge.percentage = (count_true/count_all)*100;
////                            percentage = ((count_true/count_all)*100).toString()+'%';
////                          });
////
////                          dialogs.information(context, 'Mission success! ', 'push the ok button');
////                        },
////                      ),
////
////                      new RaisedButton(
////
////                        color: Colors.amber[50],
////                        child: new Text('Deliver!', style: new TextStyle(fontSize: 20.0,
////                            fontWeight: FontWeight.w600,color: Colors.blue),
////                        ),
////
////                          onPressed: (){
//////                            new StreamBuilder(
//////
//////                              stream: Firestore.instance.collection('login').snapshots(),
//////                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
//////                                print("hihihihhi");
//////                                if(!snapshot.hasData) return CircularProgressIndicator();
//////                                return FirestoreListView(documents: snapshot.data.documents);
//////                              },
////                          //  );
//////                            getUID_length();
////                            //handleSubmit_d();
////                            setState(() {
////                            //setValue();
////
////                            count_all = count_all+3;
////                            gauge.percentage = (count_true/count_all)*100;
////                            percentage = ((count_true/count_all)*100).toString()+'%';
////
////                          });
////                          dialogs.information(context, 'Mission delivered! \n  The mission was delivered to three people.', 'push the ok button');
////                        },
////
////                      ),
////                      new RaisedButton(
////
////                        color: Colors.amber[50],
////                        child: new Text('logout', style: new TextStyle(fontSize: 20.0,
////                            fontWeight: FontWeight.w600,color: Colors.blue),
////                        ),
////
////                        onPressed: (){
////                          globals.i=1;
////                          Navigator.push(
////                              context,
////                              MaterialPageRoute(builder: (context) => LoginPage()));
////                        }
////
////                      ),
////                      new Text(textValue),
//
//
//                    ],
//                  ),
//
//                );
////            ),
////          ),
////
////
////        ],
////      ),
////    );
//
//
//  }
//}
//
//class FirestoreListView extends StatelessWidget{
//  final List<DocumentSnapshot> documents;
//
//  FirestoreListView({this.documents});
//
//  Widget build(BuildContext context){
//    return ListView.builder(
//      itemCount: documents.length,
//      itemExtent: 110.0,
//      itemBuilder: (BuildContext context, int index){
//        String title =documents[index].toString();
//        //int allUid2=documents.length;
//       // print("uallUid2);
//        //List<int> random2;
//
//
////        var rng = new Random(1);
////        for (var i = 0; i < 3; i++) {
////          random2.add(rng.nextInt(allUid2));
////          print("random"+random2[i].toString());
////        }
////        print("random"+random2.toString());
//
//        return ListTile(
//            title:Container(
//              decoration: BoxDecoration(
//                borderRadius: BorderRadius.circular(50.0),
//                border: Border.all(color:Colors.black),
//              ),
//              padding: EdgeInsets.all(5.0),
//              child: Row(
//                children: <Widget>[
//                  Expanded(
//                    child: !documents[index].data['name']
//                        ?Text(title)
//                        :TextFormField(
//                      initialValue: title,
//                      onFieldSubmitted: (String item){
//                        Firestore.instance
//                            .runTransaction((transaction)async{
//                          DocumentSnapshot snapshot=await transaction
//                              .get(documents[index].reference);
//
//                          await transaction.update(
//                              snapshot.reference, {'name':item});
//
//                          await transaction.update(snapshot.reference,
//                              {"name":!snapshot['name']});
//                        });
//                      },
//                    ),
//                  ),
//                  Column(
//                    children: <Widget>[
//                      IconButton(
//                        icon: Icon(Icons.delete),
//                        onPressed: (){
//                          Firestore.instance.runTransaction((transation)async{
//                            DocumentSnapshot snapshot=
//                            await transation.get(documents[index].reference);
//                            await transation.delete(snapshot.reference);
//                          });
//                        },
//                      )
//                    ],)
//                ],
//              ) ,
//            ),
//            onTap: ()=>Firestore.instance
//                .runTransaction((Transaction transaction) async{
//              DocumentSnapshot snapshot=
//              await transaction.get(documents[index].reference);//dpcuments의 값을 가지고옴.?
//
//              await transaction.update(
//                  snapshot.reference, {"name":!snapshot["name"]});
//            })
//        );
//      },
//    );
//  }
//}



import 'package:firebase_database/firebase_database.dart';

import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:login5/Dialogs.dart';
import 'gloals.dart' as globals;
import 'menu.dart';
import './gauge.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseApp app = FirebaseApp
  (
    options : FirebaseOptions(
      googleAppID: '1:297718011993:android:2b3685a1f6154871',
      apiKey: 'AIzaSyBzSY-SXuZ52uOOy59-tXESQOaTSNDMqQg',
      databaseURL: 'https://codingtalkrc.firebaseio.com',
    ), name: "[DEFAULT]");

class Home3 extends StatefulWidget{
  HomeState3 createState() =>HomeState3();
}


/*현지가 선언한 파이어스토어 인스턴스...*/
final Firestore store = Firestore.instance;

class HomeState3 extends State<Home3>{


  List<Item> success = List();
  Item item;
  DatabaseReference itemRef;
  static double count_true = 1.0; // 게이지바를 채우기 위한 카운트, complete = true만 담는다.
  static double count_all = 1.0; // 게이지바를 채우기 위한 카운트, 모든 유저의 미션 개수를 담는다.
  String percentage;

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void initState(){
    super.initState();
    item = Item("","");
    final FirebaseDatabase database = FirebaseDatabase(app: app);

    itemRef = database.reference().child('success');
    itemRef.onChildAdded.listen(_onEntryAdded);
    itemRef.onChildChanged.listen(_onEntryChanged);

  }

  _onEntryAdded(Event event){
    setState(() {
      success.add(Item.fromSnapshot(event.snapshot));
    });
  }

  _onEntryChanged(Event event){
    var old = success.singleWhere((entry){
      return entry.key == event.snapshot.key;
    }
    );

    setState(() {
      success[success.indexOf(old)] =Item.fromSnapshot(event.snapshot);

    });
  }





  void handleSubmit(){

    //count_true = count_true + 2;// ==> 여기서 값을 증가시키면 증가한다.
    //새로 추가한 부분... 여기서는 달성 버튼을 누르면  해당 uid의 complete 의 false가 true로 바뀐다!
    store.runTransaction((Transaction transaction)async{
      store.collection('uidc').document(globals.userUID).updateData({"complete" : true});
    }
    );
//      print("~~~");
    // 이 부분에서는 complement의 true의 개수를 읽어들여서 전체 게이지 개수를 정한다.
    StreamBuilder (
      stream: Firestore.instance.collection('uidc').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        print("~~~");
        for(int i = 0;i<1000000;i++){
          print(i.toString());
          if(!snapshot.hasData) return CircularProgressIndicator();
          if(snapshot.data.documents[i]['mission']==true){
            count_all = count_all + 1.0;
            print('count_all : ' + count_all.toString());
          }
          if(snapshot.data.documents[i]['complete'] == true){
            count_true = count_true + 1.0;
            print('count_true : ' + count_true.toString());
          }
        }
      },
    );
  }


  Dialogs dialogs = new Dialogs();



  Widget build(BuildContext context){

    int count=0;

    CustomSlider gauge = new CustomSlider(

      percentage: (count_true/count_all)*100,//여기가 slider의 게이지 차는모양(형태) 부분
      positiveColor: Color(0xFFEF0078),
      negetiveColor: Color(0xFFFFFFFF),
    );



    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.red[200],
      ),
      drawer:MenuPage(),
      resizeToAvoidBottomPadding: false,

      body: Column(
        children: <Widget>[
          Flexible(
            flex: 0,
            child: Center(
                child: Form(
                  key: formkey,
                  child: Flex(
                    direction: Axis.vertical,
                    children: <Widget>[
                      SizedBox(height: 25.0),
                      gauge,
                      Text(percentage = ((count_true/count_all)*100).toString()+'%'),

                      SizedBox(height: 40.0),
                      new RaisedButton(
                        color: Colors.amber[50],
                        child: new Text('Success!', style: new TextStyle(fontSize: 20.0,
                            fontWeight: FontWeight.w600,color: Colors.blue),
                        ),
                        onPressed: (){
                          item.title=globals.userName;

                          handleSubmit();

                          setState(() {
                            gauge.percentage = (count_true/count_all)*100;
                            percentage = ((count_true/count_all)*100).toString()+'%';
                          });

                          dialogs.information(context, 'Mission success! \n The mission was delivered to three people.', 'push the ok button');
                        },
                      ),
                    ],
                  ),

                )
            ),
          ),
          SizedBox(height: 15.0),
          new Align(
            alignment: Alignment.bottomLeft,
            child: new Text('    Today \'s people of achievement', style: new TextStyle(fontSize: 17.0,
                fontWeight: FontWeight.w600,color: Colors.black),
            ),),

          Flexible(

            child: FirebaseAnimatedList(

                query: itemRef,

                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index){
                  print(index);
                  globals.ourCount=(index+1)*10;
                  globals.ourCount2 = (index+1.0)*10.0;
                  count=1;

                  return new ListTile(

                    leading: Icon(Icons.favorite, color: Colors.red,),
                    title: success[index].title==null?'empty':Text(success[index].title),
                    subtitle: success[index].body==null?'empty':Text(success[index].body),
                  );

                }
            ),
          ),


        ],
      ),

    );
  }
}



class Item{
  //String userName=globals.userName;
  String key;
  //String uid;
  String title;
  String body;

  Item(this.title, this.body);

  Item.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        title = snapshot.value["title"],
        body = snapshot.value["body"];

  toJson(){
    return {
      //"uid": uid,
      "title": title,
      "body" : body

    };
  }
}

class FirestoreListView extends StatelessWidget{
  final List<DocumentSnapshot> documents;

  FirestoreListView({this.documents});

  Widget build(BuildContext context){
    return ListView.builder(
      itemCount: documents.length,
      itemExtent: 110.0,
      itemBuilder: (BuildContext context, int index){
        String title =documents[index].data['posting'].toString();

        return ListTile(
            title:Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                border: Border.all(color:Colors.black),
              ),
              padding: EdgeInsets.all(5.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: !documents[index].data['editing']
                        ?Text(title)
                        :TextFormField(
                      initialValue: title,
                      onFieldSubmitted: (String item){
                        Firestore.instance
                            .runTransaction((transaction)async{
                          DocumentSnapshot snapshot=await transaction
                              .get(documents[index].reference);

                          await transaction.update(
                              snapshot.reference, {'posting':item});

                          await transaction.update(snapshot.reference,
                              {"editing":!snapshot['editing']});
                        });
                      },
                    ),
                  ),

                  Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: (){
                          Firestore.instance.runTransaction((transation)async{
                            DocumentSnapshot snapshot=
                            await transation.get(documents[index].reference);
                            await transation.delete(snapshot.reference);
                          });
                        },
                      )
                    ],)
                ],
              ) ,
            ),
            onTap: ()=>Firestore.instance
                .runTransaction((Transaction transaction) async{
              DocumentSnapshot snapshot=
              await transaction.get(documents[index].reference);//dpcuments의 값을 가지고옴.?

              await transaction.update(
                  snapshot.reference, {"editing":!snapshot["editing"]});
            })
        );
      },
    );
  }
}