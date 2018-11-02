
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'gloals.dart' as globals;
import 'menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'ourPosing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseApp app = FirebaseApp
  (  
    options : FirebaseOptions(
    googleAppID: '1:297718011993:android:2b3685a1f6154871',
    apiKey: 'AIzaSyBzSY-SXuZ52uOOy59-tXESQOaTSNDMqQg',
    databaseURL: 'https://codingtalkrc.firebaseio.com',
),  name:"[DEFAULT]"
);

/*내가 선언한 파이어스토어 인스턴스...*/
final Firestore store = Firestore.instance;

class Home extends StatefulWidget{
  HomeState createState() =>HomeState();
}

class HomeState extends State<Home>{


  List<Item> items = List();
  Item item;
  DatabaseReference itemRef;

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void initState(){
    super.initState();
    item = Item("","","");
    final FirebaseDatabase database = FirebaseDatabase(app: app);

    itemRef = database.reference().child('myPosting').child(globals.userUID);
    itemRef.onChildAdded.listen(_onEntryAdded);
    itemRef.onChildChanged.listen(_onEntryChanged);

   }

   int countTrue() {
     int count = 0;

     Firestore.instance.collection('uidc').snapshots();
     (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
       count++;
       if (!snapshot.hasData) return count;
     };
   }



   _onEntryAdded(Event event){
     setState(() {
            items.add(Item.fromSnapshot(event.snapshot));
          });
   }

   _onEntryChanged(Event event){
     var old = items.singleWhere((entry){
       return entry.key == event.snapshot.key;
     }
   );

    setState(() {
          items[items.indexOf(old)] =Item.fromSnapshot(event.snapshot);
        });
   }





   void handleSubmit(){

    final FormState form = formkey.currentState;
    if (form.validate()) {
       form.save();
       form.reset();
       itemRef.push().set(item.toJson());
     }

     // 이 버튼을 누를 시에는 uidc라는 콜렉션 필드에 complete : false를 생성한다. (document아름은 uid로..)

//     store.runTransaction((Transaction transaction)async{
//       store.collection('uidc').document(globals.userUID).setData({"complete" : false});
//     }
//     );






   }






  Widget build(BuildContext context){

    var user= FirebaseAuth.instance.currentUser();
    var name, email, uid;

    String currentUID;
    return Scaffold(
      
     appBar: AppBar(
        backgroundColor: Colors.red[200],
       // title: Text(widget.title),
       title: Text("Posting"),
       actions: <Widget>[
         IconButton(
           icon: Icon(Icons.person),
           onPressed: (){
             Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()));
            
           }
         ),
         IconButton(
           icon: Icon(Icons.people),
           onPressed: (){
             Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home2()));
             
           }
         )
       ],
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
                   ListTile(
                     leading: Icon(Icons.date_range,color: Colors.red,),
                     title: TextFormField(
                       decoration: InputDecoration(
                                  hintText: 'DATE',
                       contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                       border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(32.0)
                      ),
                  ),
                       
                       
                       initialValue: "",
                      onSaved: (val){
                        item.title = val;
                        item.name=globals.userName;
                      },
                       validator: (val) => val == " "?val: null,
                     ),
                   ),
                   ListTile(
                     
                     leading: Icon(Icons.attach_file,color: Colors.red,),
                     title: TextFormField(
                         maxLines: 5,
                         keyboardType: TextInputType.multiline,
                       decoration: InputDecoration(
                                  hintText: 'Contents',
                       contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                       border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(32.0)
                      ),
                  ),
                       
                       initialValue: '',
                       onSaved: (val) => item.body = val,
                       validator: (val) => val == " "?val: null,
                     ),
                     ),

                     IconButton(
                       icon: Icon(Icons.send),
                       onPressed: (){





                         handleSubmit();







                       },
                       ),
                    
                 ],
               ),
             ),
           ),),
      new FutureBuilder<FirebaseUser>(
      future: FirebaseAuth.instance.currentUser(),
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
          currentUID=snapshot.data.uid;
          return new Text("");
      },
    ),

       Flexible(
         child: FirebaseAnimatedList(
            query: itemRef,
           itemBuilder: (BuildContext context, DataSnapshot snapshot,
           Animation<double> animation, int index){
              print("my");
             return new ListTile(
               leading: Icon(Icons.favorite, color: Colors.red,),
               
               title: items[index].title==null?'empty':Text(items[index].title),
               subtitle: items[index].body==null?'empty':Text(items[index].body),              

             );//}
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
  String name;
  Item(this.name,this.title, this.body);

  Item.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
       // uid=snapshot.value["uid"],
        title = snapshot.value["title"],
        body = snapshot.value["body"],
        name=snapshot.value["name"];

  toJson(){
    return {
      "name" : name,
      "title": title,
      "body" : body,
      

    };
  }
}


class addUIDc extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    Firestore.instance.collection('uidc').document(globals.userUID).setData({'complete': false});



  }
}


