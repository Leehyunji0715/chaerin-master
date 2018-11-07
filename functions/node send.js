var admin = require("firebase-admin");

//var serviceAccount = require("path/to/serviceAccountKey.json");;
var serviceAccount = require("/Users/leehyunji0715/node_modules/codingtalkrc-firebase-adminsdk-c21xb-e9e8821cfb.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://codingtalkrc.firebaseio.com"
});

var notificationKey = "'WPX91bFxpiCMFe5p6JjypsOSgXn2lCVHMrX5Q1d-fjYqFoHMMc-DjE8S97GJiCs0lw0DPGnckSGe_AQhhOViV5MF67Rodb9bNlCPmYt2UUi2-vPmrwncYJs7NqdZE7DyuO3sZ0e_b98c'";

var payload = {
  notification: {
    title: "NASDAQ News",
    body: "The NASDAQ climbs for the second day. Closes up 0.60%."
  }
};

admin.messaging().sendToDeviceGroup(notificationKey, payload)
  .then(function(response) {
    console.log("Successfully sent message:", response);
  })
  .catch(function(error) {
    console.log("Error sending message:", error);
  });
