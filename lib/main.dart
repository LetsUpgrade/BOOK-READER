import 'package:book_reader_app/book_reader_main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'login.dart';
import 'registration.dart';
import 'welcome_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder:(context,snapshot){
        if(snapshot.hasError){
          print("Something Wrong to Initialize FLutter Firebase");
          return null;
        }
        else if(snapshot.connectionState ==ConnectionState.done){
          return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      home: WelcomeScreen(),
      routes: <String,WidgetBuilder>{
        "login":(context)=>LoginScreen(),
        "register":(context)=>RegistrationScreen(),
        "book-reader":(context)=>BookReader(),

      },  
      
    );
        }
        return Loading(indicator: BallPulseIndicator(),size: 100.0,color:Colors.blue); 

      }
       );
  }
}

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());

}