import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_share_pal/screens/home_screen.dart';
import 'package:my_share_pal/styleguide/textstyles.dart';
import 'package:my_share_pal/utils/session_manager.dart';
import 'package:my_share_pal/utils/utils.dart';
import 'package:random_string/random_string.dart';

String _mobile, _firstName, _lastName, _email, _zip, _ministryCode;

class RegisterScreenTwo extends StatefulWidget {
  RegisterScreenTwo(
      String mobile, String firstName, String lastName, File image) {
    _image = image;
    _firstName = firstName;
    _lastName = lastName;
    _mobile = mobile;
  }

  @override
  State<StatefulWidget> createState() {
    return RegisterScreenTwoState();
  }
}

File _image;

TextEditingController e = TextEditingController();
TextEditingController z = TextEditingController();
TextEditingController m = TextEditingController();

class RegisterScreenTwoState extends State<RegisterScreenTwo> {
  ImageProvider img;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  SessionManager _sessionManager = SessionManager();

  @override
  Widget build(BuildContext context) {
    _sessionManager.load();

    if (_image != null) {
      img = Image.file(_image).image;
    } else {
      img = AssetImage("images/circle.png");
    }

    return Scaffold(
      body: Builder(
          builder: (context) => SafeArea(
                  child: ListView(
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
                            "MySharePal",
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
                              image: DecorationImage(
                                  image: img, fit: BoxFit.cover),
                              border:
                                  Border.all(width: 1.0, color: Colors.white)),
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
                                    child: Image(
                                        image: AssetImage("images/add.png")))),
                            top: 68)
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 16.0, right: 16.0, top: 48.0),
                    child: TextField(
                      controller: m,
                      style: loginTextFieldHint,
                      decoration: InputDecoration(
                          hintText: "Ministry Code:",
                          contentPadding: null,
                          prefixIcon:
                              Image(image: AssetImage("images/lock.png"))),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(
                          top: 16.0, bottom: 16.0, left: 64.0, right: 64.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Container(
                                  height: 1.0, color: Color(0XFF707070))),
                          Container(
                              margin: EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Text(
                                "OPTIONAL",
                                style: registerOr,
                              )),
                          Expanded(
                              child: Container(
                                  height: 1.0, color: Color(0XFF707070)))
                        ],
                      )),
                  Container(
                    padding:
                        EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                    child: TextField(
                      style: loginTextFieldHint,
                      decoration: InputDecoration(
                          hintText: "Email Address:",
                          contentPadding: null,
                          prefixIcon:
                              Image(image: AssetImage("images/email.png"))),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                    child: TextField(
                      style: loginTextFieldHint,
                      decoration: InputDecoration(
                          hintText: "Zip Code:",
                          contentPadding: null,
                          prefixIcon:
                              Image(image: AssetImage("images/location.png"))),
                    ),
                  ),
                  Container(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.only(
                          left: 16.0, right: 16.0, bottom: 32.0, top: 88),
                      child: InkWell(
                          onTap: () {
                            _proceed(context);
                          },
                          child: Container(
                            height: 48.0,
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Text("Continue", style: welcomeScreenButton),
                            decoration: BoxDecoration(
                                color: Color(0XFF2E8ECC),
                                borderRadius: BorderRadius.circular(8.0)),
                          )))
                ],
              ))),
    );
  }

  String imageURL = "";

  void _proceed(BuildContext context) async {
    _email = e.text;
    _zip = z.text;
    _ministryCode = m.text;

    if (_ministryCode == "") {
      uploadImage(context);
    } else {
      showProgressDialog(context, "Validating ministry code");
      await Firestore.instance
          .collection("ministries")
          .document(_ministryCode)
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
    }
  }

  void uploadImage(BuildContext context) async {
    if (_image != null) {
      showProgressDialog(context, "Uploading your photo...");
      StorageReference storageReference =
          FirebaseStorage().ref().child("images/$_mobile");
      StorageUploadTask uploadTask = storageReference.putFile(_image);

      await (await uploadTask.onComplete).ref.getDownloadURL().then((value) {
        imageURL = value.toString();
        Navigator.of(context).pop();
        register(context);
      });
    } else {
      register(context);
    }
  }

  void register(BuildContext context) async {
    showProgressDialog(context, "Preparing account for you...");

    String uniqueID = randomAlphaNumeric(5);

    await Firestore.instance.collection("users").document(_mobile).setData({
      "id": uniqueID,
      "firstName": _firstName,
      "lastName": _lastName,
      "mobile": _mobile,
      "email": _email,
      "zip": _zip,
      "img": imageURL,
      "ministryCode": _ministryCode,
      "status": "active",
      "temporary": false
    }).then((onValue) {
      _sessionManager.createSession(
          uniqueID, "$_firstName $_lastName", imageURL, _mobile, _ministryCode);
      onDoneLoading();
    });
  }

  void onDoneLoading() async {
    Navigator.of(context)
        .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeScreen()), ModalRoute.withName("/Home"));
  }
}
