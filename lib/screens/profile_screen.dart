// after anjela course
import 'dart:io';

import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/image_picker_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileScreen extends StatefulWidget {

  static const String id = 'profile_screen';


  final String networkImage;

  const ProfileScreen({Key key, this.networkImage}) : super(key: key);
  NetworkImage getImageUrl({String url}) {
    //url='https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Mnx8cGhvdG98ZW58MHx8MHw%3D&ixlib=rb-1.2.1&w=1000&q=80';
    url = networkImage;
    return NetworkImage(url);

  }

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {




  // File _userImageFile;
  // void pickedImage(File pickedImage){
  //   _userImageFile = pickedImage;
  // }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: null,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () {}),
          ],
          title: Text('⚡️  Me'),
          backgroundColor: Colors.lightBlueAccent,
        ),
        body: Center(
          child: Column(
            children: [

              // UserImagePicker(pickedImage),
              Text('User Name',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 50.0
              ),),
              CircleAvatar(
                radius: 50,
                backgroundImage: widget.getImageUrl(url: widget.networkImage),

                // backgroundImage: _userImageFile != null ? FileImage(_userImageFile) : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SecondProfileScreen extends StatefulWidget {
  @override
  _SecondProfileScreenState createState() => _SecondProfileScreenState();
}

class _SecondProfileScreenState extends State<SecondProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(

        ),
      ],
    );
  }
}




