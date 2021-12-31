import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inventory/Admin/HomeAdmin.dart';
import 'package:inventory/Pages/Bottomnavy.dart';
import 'package:inventory/Pages/Home.dart';
import 'package:inventory/Pages/SignUp.dart';
import 'package:inventory/Pages/signin.dart';
import 'package:inventory/Pages/upload.dart';
import 'package:inventory/service.dart/Auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
          future: AuthMethods().getCurrentUser(),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return BottomNavy();
            } else {
              return SignIn();
            }
          },
        ));
  }
}
