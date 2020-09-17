import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'Animation/FadeAnimation.dart';
import 'package:email_validator/email_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';



final _auth=FirebaseAuth.instance;
final _firestore=FirebaseFirestore.instance;
final GoogleSignIn googleSignIn=GoogleSignIn();

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey=GlobalKey<FormState>();
  String email,pass;
  bool showSpinner=false;
 final myController1=TextEditingController();
 final myController2=TextEditingController();
 final _scaffoldKey=GlobalKey();

   bool _secureText=true;
  void toggle(){
    setState(() {
      _secureText=!_secureText;
    });
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
          key: _scaffoldKey,
          body: FadeAnimation(2.0,
                       Stack(
              children: [
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height / 3,
                                    width: MediaQuery.of(context).size.width,
                                    child: Image.asset('assets/background.png'),
                                    
                                
                    
                  ),
                ),
                ModalProgressHUD(
                  inAsyncCall:showSpinner ,
                            child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
        child: Form(
                    key: _formKey,
                    child:ListView(
                    shrinkWrap: true,
                    children: [
                       Container(
                          child: Column(
                              children: <Widget>[
                                Text("Sign In", style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold
                                ),),
                                SizedBox(height: 20),
                                Text("Sign In to explore the world of Books", style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey[700]
                                ),)               
                              ],
                            ),
                        ),
                        SizedBox(height: 20),


                     TextFormField(
                                      enableSuggestions: true,
                                      controller: myController1,
                                      keyboardType: TextInputType.emailAddress,
                                      keyboardAppearance: Brightness.dark,
                                      validator: (value){
                                              if(value.isEmpty){
                                                return "Enter your Email ID";
                                              }
                                              else if(!EmailValidator.validate(value)){
                                                return "Enter a Valid Email ID";

                                              }
                                              return null;
                                      },
                                      onChanged: (value){
                                        email=value;
                                      },

                                      decoration: InputDecoration(
                                                labelText: "Email ID",
                                                border: const OutlineInputBorder(),
                                                icon: const Padding(
                                                      padding: const EdgeInsets.only(top: 15.0),
                                                      child: const Icon(Icons.email)),
                                              ) ,


                                    ),

                                    
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    TextFormField(
                                             controller: myController2,
                                             decoration: InputDecoration(
                                            labelText: "Password",
                                             suffixIcon: FlatButton(onPressed: (){
                                               setState(() {
                                                 toggle();
                                               });
                                             }, child: Icon(Icons.remove_red_eye)),
                                              border: const OutlineInputBorder(),
                                          icon: const Padding(
                                          padding: const EdgeInsets.only(top: 15.0),
                                          child: const Icon(Icons.live_help)),
                                    
                                               ) ,
                                             validator: (value) => value.length < 6 ? 'Password too short.' : null,
                                             onChanged: (value){
                                               pass=value;
                                             },
                                  
                                             obscureText: _secureText,
                                             ),


                                             SizedBox(
                                      height: 20.0,
                                    ),

                                    Center(
                                      child: RaisedButton(                        
                                                                     
                                            onPressed: () async{
                                              bool isUser;
                                              UserCredential userCredential;
                                              if(_formKey.currentState.validate()){
                                                setState(() {
                                                  showSpinner=true;
                                                });
                                                try {
                                                 final user=await _auth.signInWithEmailAndPassword(email: email, password: pass);
                                                 print(user);
                                                 if(user!=null){
                                                   Navigator.pushNamed(context,"home");
                                                 }
                                                 

                                                  
                                                }on FirebaseAuthException catch(e){
                                                if(e.code=='user-not-found'){
                                                 isUser=false;
                                                }
                                                print('${e.code}');
                                                } 
                                                catch (e) {
                                                  print(e.toString());
                                                  Navigator.pushNamed(context, "register");

                                                }finally{
                                                  
                                                  setState(() {
                                                    showSpinner=false;
                                                  });
                                                  if(!isUser){
                                                    Navigator.pushNamed(context,"register");
                                                  }
                                                }
                                                
                                                

                                                

                                              }

                                            },
                                            color: Colors.lightGreenAccent,
                                            splashColor: Colors.cyan,
                                            elevation: 10.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(50)
                                            ),
                                            child: Text("Sign In", style: TextStyle(
                                              fontWeight: FontWeight.w600, 
                                              fontSize: 20.0
                                            ),),
                                        ),
                                    ),

                                     getSeparateDivider(),
                                  SizedBox(
                                    height: 20.0,
                                  ),

                                  _signInGoogle(context),

                                   SizedBox(
                                    height: 40.0,
                                  ),

                                
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Don't have an account ? "),
                                    Material(
                                              color: Colors.white.withOpacity(0.0),
                                              child: InkWell(
                                                splashColor: Colors.orange,
                                                child:Text(" Sign Up", style: TextStyle(
                                                 fontWeight: FontWeight.w600, fontSize: 18
                                                       ),), 
                                                onTap: (){
                                                 Navigator.pushNamed(context,"register");
                                                },
                                              ),
                                      )
                                                              
                                    
                                  ],
                                ),

                    ],
        )),

      ),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}





Future<User> _signInWithGoogle() async{
  bool isSignedIn=await googleSignIn.isSignedIn();
  if(isSignedIn){
    final user= _auth.currentUser;
    return user;
  }else{
  final GoogleSignInAccount googleSignInAccount=await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication=await googleSignInAccount.authentication;

  final AuthCredential credential=GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken
  );

  final result =await _auth.signInWithCredential(credential);
  final User user=result.user;
  
  assert(!user.isAnonymous);
  assert(await user.getIdToken() !=null);

  final currentUser =_auth.currentUser;
  assert(currentUser.uid==user.uid);
  
  _firestore.collection("users").add({
    "name":currentUser.displayName,
    "email":currentUser.email
  });
  print(currentUser.email);
  
  return user;

  }

  

}

Widget _signInGoogle(BuildContext context) {
    return RaisedButton(
      elevation: 10.0,
      splashColor: Colors.lightBlueAccent,
      onPressed: () async{
        try {
          final user= await _signInWithGoogle();
          if(user!=null){
            Navigator.pushNamed(context, "home");
          }
          
          
        }on FirebaseAuthException catch(e){
          print('${e.code}');
        }
         catch (e) {
          print(e.toString());
        }

      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset("assets/google_logo.png",height: 20.0),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'Sign In',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
          ),
          
        ],
=======
import 'package:book_reader/Animation/FadeAnimation.dart';
import 'package:book_reader/signup.dart';
import 'package:book_reader/home.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      FadeAnimation(
                          1,
                          Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      FadeAnimation(
                          1.2,
                          Text(
                            "Login to your account",
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[700]),
                          )),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        FadeAnimation(1.2, makeInput(label: "Email")),
                        FadeAnimation(1.3,
                            makeInput(label: "Password", obscureText: true)),
                      ],
                    ),
                  ),
                  FadeAnimation(
                      1.4,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          padding: EdgeInsets.only(top: 3, left: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border(
                                bottom: BorderSide(color: Colors.black),
                                top: BorderSide(color: Colors.black),
                                left: BorderSide(color: Colors.black),
                                right: BorderSide(color: Colors.black),
                              )),
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 60,
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
                            },
                            color: Colors.greenAccent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                          ),
                        ),
                      )),
                  FadeAnimation(
                      1.5,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Don't have an account?"),
                          FlatButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
                            },
                            child: Text(
                            "Sign up",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
            FadeAnimation(
                1.2,
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/background.png'),
                          fit: BoxFit.cover)),
                ))
          ],
        ),
>>>>>>> fa96300360c16a737f001b7a592b920de0213c4d
      ),
    );
  }

<<<<<<< HEAD





//Horizontal Divider

class Drawhorizontalline extends CustomPainter {
      Paint _paint;
      bool reverse;

   Drawhorizontalline(this.reverse) {
     _paint = Paint()
          ..color = Colors.black
          ..strokeWidth = 1
          ..strokeCap = StrokeCap.round;
   }

  @override
  void paint(Canvas canvas, Size size) {
      if (reverse) {
         canvas.drawLine(Offset(-250.0, 0.0), Offset(-10.0, 0.0), _paint);
      } else {
         canvas.drawLine(Offset(10.0, 0.0), Offset(250.0, 0.0), _paint);
      }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
     return false;
  }
}


Widget getSeparateDivider() {
return Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
    CustomPaint(painter: Drawhorizontalline(true)),
    Text(
      "OR",
      style: TextStyle(
          color: Colors.black38,
          fontWeight: FontWeight.bold,
          fontSize: 10.0),
    ),
    CustomPaint(painter: Drawhorizontalline(false))
  ],
 );
}


=======
  Widget makeInput({label, obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])),
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
>>>>>>> fa96300360c16a737f001b7a592b920de0213c4d
