import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'get_started.dart';
import 'home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool loggedIn = FirebaseAuth.instance.currentUser!=null;
  return MaterialApp(
    // home: Home(),
    initialRoute: loggedIn ? '/home' : '/get_started',
    //initialRoute: '/add_item_form',

    routes: {
      '/home' : (context) => HomePage(),
      '/get_started' : (context) => GetStarted(),

    },
    debugShowCheckedModeBanner: false,
  );
  }
}

