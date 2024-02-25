const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.resetUserFieldsDaily = functions.pubsub.schedule('0 0 * * *')
  .timeZone('Europe/Berlin')
  .onRun(async (context) => {
    const db = admin.firestore();
    const usersRef = db.collection('users');

    try {
      const snapshot = await usersRef.get();
      const updates = [];
      snapshot.forEach(doc => {

        updates.push(doc.ref.update({
          canChangeSubscription: true,
          dailyUploads: 0
        }));
      });

      await Promise.all(updates);
      console.log('Successfully reset user fields');
    } catch (error) {
      console.error('Error resetting user fields', error);
    }
  });



const logAction = (change, context, collectionName) => {
  let eventType = '';
  if (!change.before.exists && change.after.exists) {
    eventType = 'create';
  } else if (change.before.exists && change.after.exists) {
    eventType = 'update';
  } else if (change.before.exists && !change.after.exists) {
    eventType = 'delete';
  }

  const logEntry = {
    timestamp: admin.firestore.FieldValue.serverTimestamp(),
    userId: context.auth?.uid || 'anonymous',
    eventType: eventType,
    collection: collectionName,
    documentId: context.params.docId,
    beforeData: change.before.exists ? change.before.data() : null,
    afterData: change.after.exists ? change.after.data() : null,
  };

  return admin.firestore().collection('logs').add(logEntry);
};


exports.logPostsActions = functions.firestore
  .document('posts/{docId}')
  .onWrite((change, context) => logAction(change, context, 'posts'));


exports.logUsersActions = functions.firestore
  .document('users/{docId}')
  .onWrite((change, context) => logAction(change, context, 'users'));


