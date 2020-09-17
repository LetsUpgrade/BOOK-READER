import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:book_reader/Animation/FadeAnimation.dart';
import 'package:book_reader/login.dart';
import 'package:book_reader/signup.dart';
<<<<<<< HEAD
import 'package:gradient_text/gradient_text.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'home.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // jwt=prefs.getBool('verifyUser')??false;
  runApp(MyApp());

}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:Color(0x00000000)
    ));

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
      
      home: HomePage(),
      routes: <String,WidgetBuilder>{
        "login":(context)=>LoginPage(),
        "register":(context)=>SignupPage(),
        "home":(context)=>MainPage(),

      },  
      
    );
        }
        return Loading(indicator: BallPulseIndicator(),size: 100.0,color:Colors.blue); 

      }
       );
  }
=======


void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    )
  );
>>>>>>> fa96300360c16a737f001b7a592b920de0213c4d
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  FadeAnimation(1, Text("Welcome", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                  ),)),
                  SizedBox(height: 20,),
<<<<<<< HEAD
                  FadeAnimation(1.2, Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:<Widget>[
                      Text("Welcome to the ", 
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 20
                  ),),
                  grad(),
                  Text("app ", 
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 20
                  ),),

                    ]
                  )),
=======
                  FadeAnimation(1.2, Text("Welcome to the book reader app", 
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 15
                  ),)),
>>>>>>> fa96300360c16a737f001b7a592b920de0213c4d
                ],
              ),
              FadeAnimation(1.4, Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/illustration.png')
                  )
                ),
              )),
              Column(
                children: <Widget>[
                  FadeAnimation(1.5, MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.black
                      ),
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: Text("Login", style: TextStyle(
                      fontWeight: FontWeight.w600, 
                      fontSize: 18
                    ),),
                  )),
                  SizedBox(height: 20,),
                  FadeAnimation(1.6, Container(
                    padding: EdgeInsets.only(top: 3, left: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border(
                        bottom: BorderSide(color: Colors.black),
                        top: BorderSide(color: Colors.black),
                        left: BorderSide(color: Colors.black),
                        right: BorderSide(color: Colors.black),
                      )
                    ),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
                      },
                      color: Colors.yellow,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: Text("Sign up", style: TextStyle(
                        fontWeight: FontWeight.w600, 
                        fontSize: 18
                      ),),
                    ),
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
<<<<<<< HEAD
}


Widget grad(){
  return GradientText("Book Reader ",
    gradient: LinearGradient(
    colors: [Colors.deepPurple, Colors.deepOrange, Colors.yellow]),
    style: TextStyle(fontSize: 20),
  );
}


=======
}
>>>>>>> fa96300360c16a737f001b7a592b920de0213c4d
