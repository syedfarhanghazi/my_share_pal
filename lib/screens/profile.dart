import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_share_pal/styleguide/textstyles.dart';
import 'package:my_share_pal/utils/session_manager.dart';
import 'package:my_share_pal/utils/utils.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  SessionManager _sessionManager = SessionManager();

  String fi = "", la = "", mi = "";

  var f = TextEditingController();
  var l = TextEditingController();
  var m = TextEditingController();

  bool isEnabled = false;
  bool isLoaded = false;
  File _image;

  ImageProvider img;

  String newImage;

  Future getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoaded) {
      _sessionManager.load();
      loadData();
    }

    if (_image != null) {
      img = Image.file(_image).image;
    } else if (newImage != null && newImage != "") {
      img = NetworkImage(newImage);
    } else {
      img = AssetImage("images/circle.png");
    }

    return new Scaffold(
      body: Builder(builder: (context) => SafeArea(child: data(context))),
    );
  }

  Widget data(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 16.0, bottom: 80.0),
                child: Row(
                  children: <Widget>[
                    InkWell(
                        onTap: () {
                          moveBack(context);
                        },
                        child: Image(
                          image: AssetImage("images/arrow.png"),
                          height: 16.0,
                        )),
                    Expanded(
                        child: Center(
                            child: Text(
                      "Profile",
                      style: title,
                    )))
                  ],
                )),
            Container(
              width: 116.0,
              alignment: Alignment.center,
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 116.0,
                    width: 116.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: img, fit: BoxFit.cover),
                        border: Border.all(width: 1.0, color: Colors.white)),
                  ),
                  Positioned(
                      child: InkWell(
                          onTap: () {
                            getImage();
                          },
                          child: Container(
                              height: 48.0,
                              width: 48.0,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0.0, 2),
                                      blurRadius: 2,
                                    )
                                  ],
                                  shape: BoxShape.circle,
                                  color: Color(0XFF30D158)),
                              child:
                                  Image(image: AssetImage("images/add.png")))),
                      top: 68)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 48.0),
              child: TextField(
                controller: f,
                style: loginTextFieldHint,
                decoration: InputDecoration(
                    hintText: "First Name:",
                    contentPadding: null,
                    prefixIcon: Image(image: AssetImage("images/user.png"))),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
              child: TextField(
                controller: l,
                style: loginTextFieldHint,
                decoration: InputDecoration(
                    hintText: "Last Name:",
                    contentPadding: null,
                    prefixIcon: Image(image: AssetImage("images/user.png"))),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
              child: TextField(
                controller: m,
                enabled: isEnabled,
                style: loginTextFieldHint,
                decoration: InputDecoration(
                    hintText: "Ministry Code:",
                    contentPadding: null,
                    prefixIcon: Image(image: AssetImage("images/user.png"))),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 32.0, left: 16.0, right: 16.0),
                alignment: Alignment.bottomCenter,
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: InkWell(
                        onTap: () {
                          updateData(context);
                        },
                        child: Container(
                          height: 48.0,
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Text("Update", style: welcomeScreenButton),
                          decoration: BoxDecoration(
                              color: Color(0XFF2E8ECC),
                              borderRadius: BorderRadius.circular(8.0)),
                        ))))
          ],
        ),
      ],
    );
  }

  Future<void> loadData() async {
    await _sessionManager.load();

    Firestore.instance
        .collection("users")
        .document(_sessionManager.phone)
        .get()
        .then((snapshot) {
      f.text = snapshot.data['firstName'];
      l.text = snapshot.data['lastName'];
      m.text = snapshot.data['ministryCode'];
      newImage = snapshot.data['img'];

      if (snapshot['ministryCode'] == "" || snapshot['temporary'] == true) {
        isEnabled = true;
      } else {
        isEnabled = false;
      }

      setState(() {
        isLoaded = true;
      });
    });
  }

  String imageURL = "";
  String firstName, lastName, ministryCode;

  void updateData(BuildContext context) async {
    firstName = f.text;
    lastName = l.text;
    ministryCode = m.text;

    if (firstName.isEmpty) {
      showMessage("Enter your first name", context);
    } else if (lastName.isEmpty) {
      showMessage("Enter your last name", context);
    } else {
      if (isEnabled && ministryCode.length > 0) {
        showProgressDialog(context, "Validating ministry code");
        await Firestore.instance
            .collection("ministries")
            .document(ministryCode)
            .get()
            .then((snapshot) {
          Navigator.pop(context);
          if (snapshot.exists) {
            if (snapshot.data['status'] != 'active') {
              showMessage("Ministry code is currently inactive", context);
            } else {
              uploadImage(context);
            }
          } else {
            showMessage("Invalid ministry code...", context);
          }
        });
      } else {
        uploadImage(context);
      }
    }
  }

  void uploadImage(BuildContext context) async {
    if (_image != null) {
      showProgressDialog(context, "Uploading your photo...");
      StorageReference storageReference =
          FirebaseStorage().ref().child("images/" + _sessionManager.phone);
      StorageUploadTask uploadTask = storageReference.putFile(_image);
      await (await uploadTask.onComplete).ref.getDownloadURL().then((value) {
        imageURL = value.toString();
        Navigator.of(context).pop();
        update(context);
      });
    } else {
      update(context);
    }
  }

  void update(BuildContext context) {
    if (imageURL == "") {
      imageURL = _sessionManager.img;
    }
    showProgressDialog(context, "Updating your information...");
    Firestore.instance
        .collection("users")
        .document(_sessionManager.phone)
        .updateData({
      'firstName': firstName,
      'lastName': lastName,
      'temporary': false,
      'ministryCode': ministryCode,
      'img': imageURL
    }).then((value) {
      Navigator.of(context).pop();
      showMessage("Updated Successfully....", context);
      _sessionManager.createSession(
          _sessionManager.id,
          firstName + " " + lastName,
          imageURL,
          _sessionManager.phone,
          ministryCode);

      if(ministryCode!=""){
        isEnabled = false;

        setState(() {

        });
      }
    });
  }
}
