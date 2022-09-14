import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gps_ya/screens/landing.dart';

//void main() => runApp(const MaxFitApp());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaxFitApp());
}

class MaxFitApp extends StatelessWidget{
  const MaxFitApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'MaxFitness',
      theme: ThemeData(
       primaryColor: const Color.fromRGBO(50, 65, 85, 1),
       textTheme: const TextTheme(titleMedium: TextStyle(color: Colors.white))
      ),
      home: const LandingPage()
    );
  }
}

