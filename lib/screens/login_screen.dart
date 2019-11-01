import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_share_pal/styleguide/textstyles.dart';
import 'package:my_share_pal/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Builder(
      builder: (context) => SafeArea(
          child: Column(
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
            child: Center(
              child: Image(
                image: AssetImage("images/icon.png"),
                height: 116.0,
              ),
            ),
          ),
          Container(
            height: 48.0,
            margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 48.0),
            child: TextField(
              controller: phone,
              decoration: InputDecoration(hintText: "10-Digit Phone Number"),
            ),
          ),
          Container(
              margin: EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 24.0, bottom: 32.0),
              child: InkWell(
                  onTap: () {
                    _login(context);
                  },
                  child: Container(
                    height: 48.0,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text("Login", style: welcomeScreenButton),
                    decoration: BoxDecoration(
                        color: Color(0XFF2E8ECC),
                        borderRadius: BorderRadius.circular(8.0)),
                  )))
        ],
      )),
    ));
  }

  String mobile;

  void _login(BuildContext context) {
    mobile = phone.text;

    if (mobile.length != 10) {
      showMessage("Enter 10 digit mobile number", context);
    } else {
      showProgressDialog(context, "Getting Account Details");
      _login(context);
    }
  }

  void _loginHandle() async {
    await Firestore.instance
        .collection("users")
        .document(mobile)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        String mob = snapshot.data['mobile'];
      } else {}
    });
  }
}
