


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'gloals.dart' as globals;

class lala extends StatefulWidget{
  static String tag ='register-page';
  lalaState createState() => new lalaState();

}


class lalaState extends State<lala> {
  final Firestore storage = Firestore.instance;

  String _name;
  String _email;

  final formKey= new GlobalKey<FormState>();

   bool validateAndSave()
  {
    final form = formKey.currentState;

    if(form.validate()){
      form.save();//onSave에 해당하는 거 실행.

      form.reset();//입력 칸 비우기.
      //print('Form is valid. id:$_id, password:$_password');
      return true;
    }
    return false;
  }



  Widget build(BuildContext context){


    return new Scaffold(
        backgroundColor: Colors.white,
         appBar:AppBar(
          title: Text('Find PassWord'),
          backgroundColor: Colors.red[200],) ,
        body: Center(
            child: new Form(
              key: formKey,
              child: new ListView(
                shrinkWrap: true,//Scrollable
                padding: EdgeInsets.only(left: 24.0, right: 24.0),
                children: buildInputs()
              ),
            )
        )
    );
  }

   List<Widget> buildInputs(){

    return[

      new TextFormField(
    //   style: new TextStyle(
    //   fontSize: 2.0,
    //   height: 10.0,

    //   color: Colors.black
    // ),
    maxLines: 5,
    keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        hintText: 'CONTEXT',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0)
        ),
      ),
    validator:(value){
      if(value.isEmpty)
      {
        print('Name can\'t be enpty');
      }
      else{
        storage.runTransaction((Transaction transaction)async{
          storage.collection('Button').document().setData({"complete":true});//.setData({"complete" : false,"mission" : true});
        }

//            storage.runTransaction((Transaction transaction)async{
//      storage.collection('uide').document(globals.userUID).collection(globals.userUID).document().setData({"posting": value,"editing":false,"uid":globals.userUID,"user":globals.userName});//.setData({"complete" : false,"mission" : true});
//    }
    );



                  var now=new DateTime.now();
              Firestore.instance
              .runTransaction((Transaction transaction) async{
                CollectionReference reference=
                Firestore.instance.collection('uido');



                await reference
                      .add({"posting": value,"editing":false,"uid":globals.userUID,"date":now,"user":globals.userName});

              });

      }
    },
    // validator: (value) =>value.isEmpty ? 'Name can\'t be enpty':,
     onSaved: (value) =>_name =value,
     ),

     SizedBox(height: 10.0),

     new Padding(
       padding: EdgeInsets.symmetric(vertical: 16.0),
       child: Material(
         borderRadius: BorderRadius.circular(30.0),
         shadowColor: Colors.redAccent.shade100,
         elevation: 5.0,
         child: MaterialButton(
           minWidth: 200.0,
           height: 46.0,
           onPressed:  validateAndSave,
           color: Colors.red[200],
           child: Text('POSTING',style: TextStyle(color: Colors.white)),
              ),
       ),
      )


    ];
   }


}