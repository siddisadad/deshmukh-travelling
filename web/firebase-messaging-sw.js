importScripts("https://www.gstatic.com/firebasejs/10.13.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/10.13.0/firebase-messaging-compat.js");

firebase.initializeApp({
    apiKey: "AIzaSyDJFCn7KzidNf_F37TNj4ZUNrBrF_rbjnU",
    authDomain: "deshmukh-travelling-3yzjn6.firebaseapp.com",
    projectId: "deshmukh-travelling-3yzjn6",
    storageBucket: "deshmukh-travelling-3yzjn6.firebasestorage.app",
    messagingSenderId: "645684269827",
    appId: "1:645684269827:web:8aaeb7e165f52066b84f36"
});

const messaging = firebase.messaging();

// Optional: Handle background messages
messaging.onBackgroundMessage((payload) => {
  console.log('Received background message ', payload);
  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
    icon: '/favicon.png'
  };

  return self.registration.showNotification(notificationTitle, notificationOptions);
});
