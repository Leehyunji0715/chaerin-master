import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'gloals.dart' as globals;

// void main()=>runApp(MyApp());

// class MyApp extends StatelessWidget{
//   Widget build(BuildContext context){
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData.dark(),
//       home: MyHomePage(),
//     );
//   }
// }

class MyHomePage4 extends StatelessWidget{
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:  Text('Cloud Firestore Example'),
        centerTitle: true,
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.add),
          //   onPressed: (){
          //     Firestore.instance
          //     .runTransaction((Transaction transaction) async{
          //       CollectionReference reference=
          //       Firestore.instance.collection('uido');


                
          //       await reference
          //             .add({"posting": "","editing":false,"uid":globals.userUID});
        
          //     });
          //   },
          // )

        ],
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('uide').document(globals.userUID).collection(globals.userUID).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData) return CircularProgressIndicator();
          return FirestoreListView(documents: snapshot.data.documents);
        },
      ),
  
    );
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
