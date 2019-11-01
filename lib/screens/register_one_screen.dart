import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_share_pal/screens/register_screen_two.dart';
import 'package:my_share_pal/styleguide/textstyles.dart';
import 'package:my_share_pal/utils/utils.dart';

String _mobile, _firstName, _lastName;

class RegisterOneScreen extends StatefulWidget {
  RegisterOneScreen(mobile) {
    _mobile = mobile;
  }

  @override
  State<StatefulWidget> createState() {
    return new RegisterOneScreenState();
  }
}

class RegisterOneScreenState extends State<RegisterOneScreen> {
  File _image;

  ImageProvider img;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  TextEditingController f = TextEditingController();
  TextEditingController l = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                      controller: f,
                      style: loginTextFieldHint,
                      decoration: InputDecoration(
                          hintText: "First Name:",
                          contentPadding: null,
                          prefixIcon:
                              Image(image: AssetImage("images/user.png"))),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                    child: TextField(
                      controller: l,
                      style: loginTextFieldHint,
                      decoration: InputDecoration(
                          hintText: "Last Name:",
                          contentPadding: null,
                          prefixIcon:
                              Image(image: AssetImage("images/user.png"))),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Container(
                                  height: 1.0, color: Color(0XFF707070))),
                          Container(
                              margin: EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Text(
                                "SELECT AN OPTION",
                                style: registerOr,
                              )),
                          Expanded(
                              child: Container(
                                  height: 1.0, color: Color(0XFF707070)))
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.only(
                          left: 16.0, right: 16.0, bottom: 32.0),
                      child: InkWell(
                          onTap: () {
                            _proceed(context);
                          },
                          child: Container(
                            height: 48.0,
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Text("Enter a Ministry Code",
                                style: welcomeScreenButton),
                            decoration: BoxDecoration(
                                color: Color(0XFFCE57D0),
                                borderRadius: BorderRadius.circular(8.0)),
                          ))),
                ],
              ))),
    );
  }

  void _proceed(BuildContext context) {
    _firstName = f.text;
    _lastName = l.text;

    if (_firstName.isEmpty) {
      showMessage("Enter your first name", context);
    } else if (_lastName.isEmpty) {
      showMessage("Enter your last name", context);
    } else {
      onDoneLoading();
    }
  }

  void onDoneLoading() async {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            RegisterScreenTwo(_mobile, _firstName, _lastName, _image)));
  }
}
