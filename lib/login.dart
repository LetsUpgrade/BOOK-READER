import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey=GlobalKey<FormState>();
    
  final _auth=FirebaseAuth.instance;
  final emailcontroller=TextEditingController();
  final passcontroller=TextEditingController();
  String email;
  String password;
  bool showSpinner=false;

   @override
 void initState(){
   super.initState();

 }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
           inAsyncCall: showSpinner,
              child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
                      key: _formKey,
                      child: Center(
                        child: ListView(
                          shrinkWrap: true,
              children: <Widget>[
                SizedBox(
                  height: 48.0,
                ),
                TextFormField(
                  controller: emailcontroller,
                  onChanged: (value) {
                    email=value;
                    
                  },
                  validator:(value){
                        if(value.isEmpty){
                          return "Enter your E-Mail";
                        }
                        return null;
                    },

                  decoration: kTextFieldDecoration.copyWith(hintText:"Enter your Email",icon: const Padding(padding: const EdgeInsets.only(top:15.0),
                  child:const Icon(Icons.mail))),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  controller: passcontroller,
                  obscureText: true,
                  onChanged: (value) {
                    password=value;
                    
                  },
                  validator: (val) => val.length < 6 ? 'Password too short.' : null,
                  decoration: kTextFieldDecoration.copyWith(hintText:"Enter your Password",icon: const Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: const Icon(Icons.lock))),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    elevation: 5.0,
                    child: MaterialButton(
                        onPressed: () async{
                          
                          if(_formKey.currentState.validate()){
                            setState(() {
                              
                              showSpinner=true;
                            });
                            try {
                                  
                                  Navigator.pushNamed(context,"book-reader");
                                  setState(() {
                                    showSpinner=false;
                                  });
                                  

                                }catch (e) {
                                  print(e.toString());
                                  
                                }

                                

                            
                          }
                         
                          
                          
                        },
                        minWidth: 200.0,
                        height: 42.0,
                        child: Text(
                          'Log In',
                        ),
                    ),
                  ),
                ),
              ],
            ),
                      ),
          ),
        ),
      ),
    );
  }
}