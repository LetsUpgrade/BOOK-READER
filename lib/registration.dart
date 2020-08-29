import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey=GlobalKey<FormState>();
  final namecontroller=TextEditingController();
  final emailcontroller=TextEditingController();
  final passcontroller=TextEditingController();
  
  final _auth=FirebaseAuth.instance;
  final _firestore=FirebaseFirestore.instance;
  String name;
  String email;
  String password;
  bool showSpinner=false;

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
                  controller: namecontroller,
                  validator: (value){
                    if(value.isEmpty){
                        return "Enter your name";
                    }
                    return null;
                    
                  },
                  
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    name=value;
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: "Enter Your Name",icon: const Padding(padding: const EdgeInsets.only(top:15.0),
                  child: const Icon(Icons.person),)),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  controller: emailcontroller,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value){
                    if(value.isEmpty){
                        return "Enter your EmailID";
                    }
                    return null;
                    
                  },
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email=value;
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText:"Enter your Email",icon: const Padding(padding: const EdgeInsets.only(top:15.0),
                  child:const Icon(Icons.mail))),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  controller: passcontroller,
                  validator: (val) => val.length < 6 ? 'Password too short.' : null,
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password=value;
                  },
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
                    color: Colors.blueAccent,
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
                            
                          } catch (e) {
                            
                            print(e.toString());
                          }
                          }
                     


                        },
                        minWidth: 200.0,
                        height: 42.0,
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
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