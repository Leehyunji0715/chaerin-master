import * as admin from "firebase-admin";
const functions = require('firebase-functions');
var request = require('request');
var admin = require("firebase-admin");
var first=[];
var second=[];
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });


//var serviceAccount = require("path/to/serviceAccountKey.json");

// admin.initializeApp({
//   credential: admin.credential.cert(serviceAccount),
//   databaseURL: "https://codingtalkrc.firebaseio.com"
// });


var serviceAccount = require("Users/leehyunji0715/node_modules/codingtalkrc-firebase-adminsdk-c21xb-e9e8821cfb.json");
///Users/leehyunji0715/node_modules/codingtalkrc-firebase-adminsdk-c21xb-e9e8821cfb.json
//"C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Node.js\codingtalkrc-firebase-adminsdk-c21xb-0fdf056f44"


var db = admin.firestore();
//만약 버튼이 눌러져서 document와 field가 추가되면, 리스트에 token을 저장한다.
exports.createUser = functions.firestore
    .document('Button/{key}')
    .onCreate((snap, context) => {

      // Get an object representing the document
      // e.g. {'name': 'Marie', 'age': 66}
      const newValue = snap.data();

      // access a particular field as you would any JS property
      const complete = newValue.complete;
      if(complete==true){
        db.collection('login').get()
        .then((snapshot) => {
          snapshot.forEach((doc) => {
           first.push(doc.data().token)
          });

        })
        .catch((err) => {
          console.log('Error getting documents', err);
        });
      }

      // perform desired operations ...
    });

    for(var i = 0; i < 1;i++){
        var returnValue=Math.floor(Math.random() * (first.length - 0)) + 0;

        second.push(first[returnValue])
    }

    var token1 = second[0];
    //print("sdf"+second[0]);
//    var token2 = second[1];
                             //    var token3 = second[2];

    var headers = {
        'Authorization': 'key=AAAARVFgWFk:APA91bH7yVXmwSM5QsVSSNiJhyaHnCnBhOaespDmlwTAVistTci6ILwPszSMGEfZEM8s8luDoZcjxvu8VkadUDt6t-1VLvXyzb6fjhmEqANXsF-OoqX7s9W3WRbjLffMKNg0K2hgt7_XXReyKlaRVr5ZoBqIvWM_ag',
        'project_id': '297718011993',
        'Content-Type':     'application/json'
            }

   var options = {
        url: 'https://android.googleapis.com/gcm/notification',
        method: 'POST',
        headers: headers,
        json: {'operation': 'create',
                   'notification_key_name': 'you@example.com',
                   'registration_ids': [token1]}
   }

   request(options, function (error, response, body) {
                     console.log(body)
   })