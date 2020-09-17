import 'package:flutter/material.dart';
import 'package:book_reader/Animation/FadeAnimation.dart';
<<<<<<< HEAD
import 'package:email_validator/email_validator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final _auth=FirebaseAuth.instance;
final _firestore=FirebaseFirestore.instance;
final GoogleSignIn googleSignIn=GoogleSignIn();

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final _formKey=GlobalKey<FormState>();
  final myController1=TextEditingController();
  final myController2=TextEditingController();
  final myController3=TextEditingController();
  bool showSpinner=false;
  String name,email,pass;
 
  


  bool _secureText=true;
  void toggle(){
    setState(() {
      _secureText=!_secureText;
    });
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                   inAsyncCall: showSpinner,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(
                        child: Form(
                          key: _formKey,
                          child:ListView(
                            shrinkWrap: true,                        
                            children: <Widget>[
                              Container(
                          child: Column(
                              children: <Widget>[
                                Text("Sign up", style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold
                                ),),
                                SizedBox(height: 20),
                                Text("Create an account, It's free", style: TextStyle(
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
                                      keyboardType: TextInputType.name,
                                      keyboardAppearance: Brightness.dark,
                                      validator: (value){
                                        if(value.isEmpty){
                                          return "Enter Your Name";
                                        }
                                        return null;
                                      },
                                      onChanged: (value){
                                        name=value;

                                      },
                                      
                                      decoration: InputDecoration(
                                        labelText:"Name",
                                      
                                      
                                       alignLabelWithHint:true,
                                        hintText:"Enter your Name ...",
                                        border: const OutlineInputBorder(),
                                        icon: const Padding(
                                              padding: const EdgeInsets.only(top: 10.0),
                                              child: const Icon(Icons.person_pin)), 
                                      ),
                              ),

                              SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              enableSuggestions: true,
                              controller: myController2,
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
                                     controller: myController3,
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
                                      UserCredential userCredential ;
                                      if(_formKey.currentState.validate()){
                                        setState(() {
                                          showSpinner=true;
                                        });

                                        try {
                                           userCredential = await _auth.createUserWithEmailAndPassword(
                                              email: email, password: pass);
                                              if(userCredential!=null){
                                                _firestore.collection("users").add({
                                                  "name":name,
                                                  "email":email
                                                });
                                              }
                                              

                                          } on FirebaseAuthException catch (e) {
                                            if (e.code == 'weak-password') {
                                              print("${e.code}");
                                              

                                            } else if (e.code == 'email-already-in-use') {
                                              print("${e.code}");
                                              isUser=true;
                                            }
                                          } catch (e) {
                                            print(e.toString());
                                          }finally{
                                            
                                            setState(() {
                                             showSpinner=false;
                                            });
                                            if(isUser){
                                              Navigator.pushNamed(context,"login");
                                            }
                                          }

                                          if(userCredential!=null){
                                            Navigator.pushNamed(context,"home");
                                          }
                                                                          
                                      

                                      }

                                    },
                                    color: Colors.lightGreenAccent,
                                    padding: EdgeInsets.all(10.0),
                                    splashColor: Colors.cyan,
                                    elevation: 10.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)
                                    ),
                                    child: Text("Sign Up", style: TextStyle(
                                      fontWeight: FontWeight.w600, 
                                      fontSize: 20.0
                                    ),),
                                ),
                            ),

                            getSeparateDivider(),
                          SizedBox(
                            height: 20.0,
                          ),

                          _signUpGoogle(context),

                           SizedBox(
                            height: 40.0,
                          ),

                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Already have an account?"),
                            Material(
                                      color: Colors.white.withOpacity(0.0),
                                      child: InkWell(
                                        splashColor: Colors.orange,
                                        child:Text(" Login", style: TextStyle(
                                         fontWeight: FontWeight.w600, fontSize: 18
                                               ),), 
                                        onTap: (){
                                         Navigator.pushNamed(context,"login");
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



Future<User> _signUpWithGoogle() async{
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

Widget _signUpGoogle(BuildContext context) {
    return RaisedButton(
      splashColor: Colors.lightBlueAccent,
      elevation: 10.0,
      onPressed: () async{
        try {
          final user= await _signUpWithGoogle();
          
          
        }on FirebaseAuthException catch(e){
          print('${e.code}');
          
          
        } 
        catch (e) {
          print(e.toString());
        }
           
            Navigator.pushNamed(context, "home");
          

      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      padding: EdgeInsets.only(top:10.0,bottom:10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset("assets/google_logo.png",height: 20.0),
          Padding(
            padding: const EdgeInsets.only(left:5.0),
            child: Text(
              'Sign up with Google',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          
        ],
      ),
    );
  }






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
import 'package:book_reader/login.dart';
import 'package:book_reader/home.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  FadeAnimation(1, Text("Sign up", style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),)),
                  SizedBox(height: 20,),
                  FadeAnimation(1.2, Text("Create an account, It's free", style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[700]
                  ),)),
                ],
              ),
              Column(
                children: <Widget>[
                  FadeAnimation(1.2, makeInput(label: "Email")),
                  FadeAnimation(1.3, makeInput(label: "Password", obscureText: true)),
                  FadeAnimation(1.4, makeInput(label: "Confirm Password", obscureText: true)),
                ],
              ),
              FadeAnimation(1.5, Container(
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
                  },
                  color: Colors.greenAccent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Text("Sign up", style: TextStyle(
                    fontWeight: FontWeight.w600, 
                    fontSize: 18
                  ),),
                ),
              )),
              FadeAnimation(1.6, Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Already have an account?"),
                  FlatButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                            },
                            child: Text(" Login", style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 18
                  ),),
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeInput({label, obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.black87
        ),),
        SizedBox(height: 5,),
        TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400])
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400])
            ),
          ),
        ),
        SizedBox(height: 30,),
      ],
    );
  }
}
>>>>>>> fa96300360c16a737f001b7a592b920de0213c4d
