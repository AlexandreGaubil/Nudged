const admin = require('firebase-admin');
const functions = require('firebase-functions');

admin.initializeApp(functions.config().firebase);

exports.addMessage = functions.https.onRequest(async (req, res) => {
   
    let db = admin.firestore();

    let data = {
        name: 'Los Angeles',
        state: 'CA',
        country: 'USA'
      };
      
      // Add a new document in collection "cities" with ID 'LA'
      let setDoc = db.collection('houses/Singapore/01').doc('00001-test').set(data);
/*
      db.collection('houses/Singapore/01').doc('00001-test').get()
      .then(doc => {
        if (!doc.exists) {
          console.log('No such document!');
        } else {
          console.log('Document data:', doc.data());
        }
      })
      .catch(err => {
        console.log('Error getting document', err);
      });*/
    // Redirect with 303 SEE OTHER to the URL of the pushed object in the Firebase console.
    //res.redirect(303, snapshot.ref.toString());
  });


  


// Take the text parameter passed to this HTTP endpoint and insert it into the
// Realtime Database under the path /messages/:pushId/original
//exports.addMessage = functions.https.onRequest(async (req, res) => {
    // Grab the text parameter.
 //   const original = req.query.text;
    // Push the new message into the Realtime Database using the Firebase Admin SDK.
   // const snapshot = await admin.database().ref('/messages').push({original: original});
    // Redirect with 303 SEE OTHER to the URL of the pushed object in the Firebase console.
    //res.redirect(303, snapshot.ref.toString());
  //});


// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });
