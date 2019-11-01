import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_share_pal/screens/otp_screen.dart';
import 'package:my_share_pal/styleguide/textstyles.dart';
import 'package:my_share_pal/utils/utils.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterScreenState();
  }
}

class RegisterScreenState extends State<RegisterScreen> {
  String buttonText = "Login";

  @override
  Widget build(BuildContext context) {
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
                    child: Center(
                      child: Image(
                        image: AssetImage("images/icon.png"),
                        height: 116.0,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 16.0, right: 16.0, top: 48.0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: phone,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                      ],
                      onChanged: (value) {
                        setState(() {
                          if (value.length == 0) {
                            buttonText = "Login";
                          } else {
                            buttonText = "Next";
                          }
                        });
                      },
                      style: loginTextFieldHint,
                      showCursor: false,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          hintText: "10-Digit Phone Number:",
                          contentPadding: null),
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
                            child: Text(buttonText, style: welcomeScreenButton),
                            decoration: BoxDecoration(
                                color: Color(0XFF2E8ECC),
                                borderRadius: BorderRadius.circular(8.0)),
                          )))
                ],
              ))),
    );
  }

  TextEditingController phone = TextEditingController();
  String mobile;

  void _login(BuildContext context) {
    mobile = phone.text;

    if (mobile.length != 10) {
      showMessage("Enter 10 digit mobile number", context);
    } else {
      onDoneLoading(mobile);
    }
  }

  onDoneLoading(String mobile) async {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => OTPScreen(mobile)));
  }
}
