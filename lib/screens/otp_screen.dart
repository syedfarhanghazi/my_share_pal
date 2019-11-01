import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_share_pal/screens/home_screen.dart';
import 'package:my_share_pal/screens/register_one_screen.dart';
import 'package:my_share_pal/styleguide/textstyles.dart';
import 'package:my_share_pal/utils/session_manager.dart';
import 'package:my_share_pal/utils/utils.dart';

String _mobile, _mobile1;

class OTPScreen extends StatefulWidget {
  OTPScreen(String mobile) {
    _mobile = mobile;
    _mobile1 = "+1" + mobile;
  }

  @override
  State<StatefulWidget> createState() {
    return new OTPScreenState();
  }
}

InputDecoration def = InputDecoration(
    contentPadding:
        EdgeInsets.only(left: 18.0, right: 16.0, top: 18.0, bottom: 18.0));

class OTPScreenState extends State<OTPScreen> {
  InputDecoration t1 = def;
  InputDecoration t2 = def;
  InputDecoration t3 = def;
  InputDecoration t4 = def;
  InputDecoration t5 = def;
  InputDecoration t6 = def;

  var c1 = TextEditingController();
  var c2 = TextEditingController();
  var c3 = TextEditingController();
  var c4 = TextEditingController();
  var c5 = TextEditingController();
  var c6 = TextEditingController();

  var f1 = new FocusNode();
  var f2 = new FocusNode();
  var f3 = new FocusNode();
  var f4 = new FocusNode();
  var f5 = new FocusNode();
  var f6 = new FocusNode();

  String s1, s2, s3, s4, s5, s6;

  @override
  void initState() {
    //showProgressDialog(context, "Processing the request...");
    _sendCodeToPhoneNumber();
    super.initState();
  }

  SessionManager _sessionManager = SessionManager();

  @override
  Widget build(BuildContext context) {
    _sessionManager.load();

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
                    margin: EdgeInsets.only(bottom: 48.0),
                    child: Center(
                      child: Image(
                        image: AssetImage("images/icon.png"),
                        height: 116.0,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                          width: 48.0,
                          child: TextField(
                            focusNode: f1,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                            ],
                            controller: c1,
                            decoration: t1,
                            keyboardType: TextInputType.number,
                            style: OTPText,
                            onChanged: (value) {
                              setState(() {
                                update(value, 1);
                              });
                            },
                          )),
                      Container(
                          width: 48.0,
                          child: TextField(
                            focusNode: f2,
                            controller: c2,
                            decoration: t2,
                            style: OTPText,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                            ],
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                update(value, 2);
                              });
                            },
                          )),
                      Container(
                          width: 48.0,
                          child: TextField(
                            focusNode: f3,
                            decoration: t3,
                            controller: c3,
                            style: OTPText,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                            ],
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                update(value, 3);
                              });
                            },
                          )),
                      Container(
                          width: 48.0,
                          child: TextField(
                            decoration: t4,
                            focusNode: f4,
                            controller: c4,
                            style: OTPText,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                            ],
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                update(value, 4);
                              });
                            },
                          )),
                      Container(
                          width: 48.0,
                          child: TextField(
                            decoration: t5,
                            focusNode: f5,
                            controller: c5,
                            style: OTPText,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                            ],
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                update(value, 5);
                              });
                            },
                          )),
                      Container(
                          width: 48.0,
                          child: TextField(
                            decoration: t6,
                            focusNode: f6,
                            controller: c6,
                            style: OTPText,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                            ],
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                update(value, 6);
                              });
                            },
                          )),
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 24.0, bottom: 32.0),
                      child: InkWell(
                          onTap: () {
                            verifyFields(context);
                          },
                          child: Container(
                            height: 48.0,
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Text("Verify", style: welcomeScreenButton),
                            decoration: BoxDecoration(
                                color: Color(0XFF2E8ECC),
                                borderRadius: BorderRadius.circular(8.0)),
                          )))
                ],
              ))),
    );
  }

  void update(String value, int position) {
    InputDecoration temp;
    if (value.length == 1) {
      temp = InputDecoration(
          fillColor: Color(0XFF2E8ECC),
          contentPadding: EdgeInsets.only(
              left: 18.0, right: 16.0, top: 18.0, bottom: 18.0));
    } else {
      temp = def;
    }

    switch (position) {
      case 1:
        t1 = temp;
        if (value.length != 0) {
          f2.requestFocus();
        }
        break;
      case 2:
        t2 = temp;
        if (value.length == 0) {
          f1.requestFocus();
        } else {
          f3.requestFocus();
        }
        break;
      case 3:
        t3 = temp;
        if (value.length == 0) {
          f2.requestFocus();
        } else {
          f4.requestFocus();
        }
        break;
      case 4:
        t4 = temp;
        if (value.length == 0) {
          f3.requestFocus();
        } else {
          f5.requestFocus();
        }
        break;
      case 5:
        t5 = temp;
        if (value.length == 0) {
          f4.requestFocus();
        } else {
          f6.requestFocus();
        }
        break;
      case 6:
        t6 = temp;
        if (value.length == 0) {
          f5.requestFocus();
        } else {
          FocusScope.of(context).requestFocus(new FocusNode());
        }
        break;
    }

    setState(() {});
  }

  void verifyFields(BuildContext context) {
    s1 = c1.text;
    s2 = c2.text;
    s3 = c3.text;
    s4 = c4.text;
    s5 = c5.text;
    s6 = c6.text;

    if (s1.isNotEmpty &&
        s2.isNotEmpty &&
        s3.isNotEmpty &&
        s4.isNotEmpty &&
        s5.isNotEmpty &&
        s6.isNotEmpty) {
      _verifyOTP(context);
    } else {
      showMessage("Enter 6 digits code to verify...", context);
    }
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _verifyOTP(BuildContext context) async {

    showProgressDialog(context,"Validating OTP...");

    String newCode = s1 + s2 + s3 + s4 + s5 + s6;
    AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: newCode,
    );

    AuthResult authResult = await _auth.signInWithCredential(credential).then((value){
      Navigator.of(context).pop();
      _verifyHandle(context);
    }).catchError((error){
      Navigator.of(context).pop();
      showMessage("Invalid Verification Code", context);
    });



    FirebaseUser user = authResult.user;

    if (user != null) {
      print("OTPVerification: Code is right...");
    }

    // _verifyHandle(context);
  }

  void _verifyHandle(BuildContext context) async {
    showProgressDialog(context, "Getting account details");
    await Firestore.instance
        .collection("users")
        .document(_mobile)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        _sessionManager.createSession(
            snapshot['id'],
            snapshot['firstName'] + " " + snapshot['lastName'],
            snapshot['img'],
            snapshot['mobile'],
            snapshot['ministryCode']);

        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return HomeScreen();
        }));
      } else {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return RegisterOneScreen(_mobile);
        }));
      }
    });
  }

  String verificationId;

  /// Sends the code to the specified phone number.
  Future<void> _sendCodeToPhoneNumber() async {
    final PhoneVerificationCompleted verificationCompleted = (authCredentials) {
      print(authCredentials.toString());
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      print("FirebasePrinting: Code Not Sent $_mobile1 error: " +
          authException.message);
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      this.verificationId = verificationId;
      print("FirebasePrinting: Code Sent at $_mobile1");
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      this.verificationId = verificationId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: _mobile1,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }
}
