const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.scheduleMedicineReminders = functions.pubsub
  .schedule('every 1 minutes')
  .timeZone('Africa/Cairo')
  .onRun(async (context) => {
    const now = new Date();
    const oneMinuteLater = new Date(now.getTime() + 60 * 1000);

    try {
      const medicinesSnap = await admin.firestore()
        .collection('user_medicines')
        .get();

      for (const doc of medicinesSnap.docs) {
        const data = doc.data();
        const userId = data.user_id;

        if (!userId) continue;

        const statuses = data.reminder_times_status || [];

        for (let i = 0; i < statuses.length; i++) {
          const item = statuses[i];
          if (!item.reminder || item.status !== 'waiting') continue;

          const reminderTime = item.reminder.toDate();

          if (reminderTime >= now && reminderTime <= oneMinuteLater) {
            const userDoc = await admin.firestore()
              .collection('users')
              .doc(userId)
              .get();

            const token = userDoc.data()?.fcm_token;

            if (token) {
              const payload = {
                notification: {
                  title: "حان وقت الدواء!",
                  body: `تناول ${data.medicine_name} - ${data.dosage || ''}`,
                },
                data: {
                  type: "medicine_reminder",
                  medicine_id: doc.id,
                  reminder_index: i.toString(),
                }
              };

              await admin.messaging().sendToDevice(token, payload);
              console.log(`إشعار أُرسل: ${data.medicine_name}`);
            }
          }
        }
      }
    } catch (error) {
      console.error("خطأ:", error);
    }

    return null;
  });