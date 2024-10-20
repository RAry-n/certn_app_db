import 'package:certin/main_page.dart';
import 'package:certin/register.dart';
import 'package:certin/sign_in.dart';
import 'package:certin/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'get_started.dart';
import 'home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


// void main() async {
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MyApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure widgets are bound
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
    print("logged in $loggedIn");
  return GetMaterialApp(
    // home: Home(),
    initialRoute: loggedIn ? '/main_page' : '/get_started',
    //initialRoute: '/add_item_form',

    routes: {
      '/home' : (context) => HomePage(),
      '/get_started' : (context) => GetStarted(),
      '/sign_in' : (context) => SignIn(),
      '/sign_up' : (context) => SignUp(),
      '/register': (context) => Register(),
      '/main_page': (context) => MainPage(),

    },
    debugShowCheckedModeBanner: false,
  );
  }
}


