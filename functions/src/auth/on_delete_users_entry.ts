import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

export async function deleteUsers(snapshot : functions.firestore.DocumentSnapshot, context : functions.EventContext) {

    ///////////////////////////////////////////////////////////////////////
    // Remove all users. 
    // 
    // Relevant references: 
    //  - https://firebase.google.com/docs/reference/admin/node 
    //  - https://googleapis.dev/nodejs/storage/latest/File.html#delete 
    //
    //  When using promises and await, errors need to be caught. Error responses are described here: 
    //  - https://cloud.google.com/storage/docs/json_api/v1/status-codes 
    //  
    ///////////////////////////////////////////////////////////////////////

    try {
        // Delete all users.
        const listUsersResult = await admin.auth().listUsers(1000);
        await admin.auth().deleteUsers(listUsersResult.users.map((record) => record.uid));

        // Delete all documents in a batch.
        const db = admin.firestore();
        const batch = db.batch();
        const usersCollection = await db.collection('users').get();
        usersCollection.docs.forEach((doc) => {
            batch.delete(doc.ref);
        });
        const tokensCollection = await db.collection('tokens').get();
        tokensCollection.docs.forEach((doc) => {
            batch.delete(doc.ref);
        });
        await batch.commit();
  
    }
    catch(error) {
        console.error('Uncaught exception: '+error);
    }
}