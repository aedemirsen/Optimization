import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDa1TmPeylyutd9PcN_ZjS7B1zIo55RYts", // Your apiKey
      appId: "1:1053463582684:web:9b5d78dfde469ec379e119", // Your appId
      messagingSenderId: "1053463582684", // Your messagingSenderId
      projectId: "optimization-496ff", // Your projectId
    ),
  );

  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    ),
  );
}
