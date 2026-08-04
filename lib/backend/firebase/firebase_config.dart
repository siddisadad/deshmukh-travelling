import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDJFCn7KzidNf_F37TNj4ZUNrBrF_rbjnU",
            authDomain: "deshmukh-travelling-3yzjn6.firebaseapp.com",
            projectId: "deshmukh-travelling-3yzjn6",
            storageBucket: "deshmukh-travelling-3yzjn6.firebasestorage.app",
            messagingSenderId: "645684269827",
            appId: "1:645684269827:web:8aaeb7e165f52066b84f36"));
  } else {
    await Firebase.initializeApp();
  }
}
