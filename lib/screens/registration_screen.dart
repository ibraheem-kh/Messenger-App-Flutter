import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flash_chat/screens/image_picker_screen.dart';
import 'package:flash_chat/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';



class RegistrationScreen extends StatefulWidget {

  static const String id = 'registration_screen';


  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  ProfileScreen profileScreen = ProfileScreen();

  final _auth = FirebaseAuth.instance;

  String email;
  String password;


  bool showSpinner = false;

// what I changed ::::::::::::: mix imagePickerScreen with registerScreen::::::::::::::::::::
  // after anjela file/void
  File _userImageFile;
  void pickedImage(File pickedImage){
    _userImageFile = pickedImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.only(left: 24.0, right: 24.0,),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                // after anjela
                child: UserImagePicker(pickedImage),
                /*child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),*/
              ),
              // SizedBox(
              //   height: 48.0,
              // ),

              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email=value;
                },
                decoration: KTextFieldDecoration.copyWith(hintText: 'Enter your Email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password=value;
                },
                decoration: KTextFieldDecoration.copyWith(hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),

              RoundedButton(
                title: 'Register',
                colour: Colors.blueAccent,
                onPressed: () async{
                  setState(() {
                    showSpinner = true;
                  });

                  try{
                    final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);

                    //          add firebase Storage +++ ref after anjela course +++ url           ///////////////
                    final ref = FirebaseStorage.instance.ref().child('user_image').child(newUser.user.uid+'.jpg');
                    await ref.putFile(_userImageFile);
                    final url = await ref.getDownloadURL();
                    // profileScreen.getImageUrl(url : url);


                    if (newUser != null) {

                      // change from ChatScreen.id to UserImagePicker.id
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  }

                  catch (e) {
                    print(e);
                  }
                },

              ),

            ],
          ),
        ),
      ),
    );
  }
}
