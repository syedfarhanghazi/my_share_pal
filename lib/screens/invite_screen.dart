import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_share_pal/screens/questions_screen.dart';
import 'package:my_share_pal/styleguide/textstyles.dart';
import 'package:my_share_pal/utils/session_manager.dart';
import 'package:my_share_pal/utils/utils.dart';
import 'package:random_string/random_string.dart';


String _ministryCode;
class InviteScreen extends StatefulWidget {

  InviteScreen(String ministryCode){
    _ministryCode = ministryCode;
  }
  @override
  State<StatefulWidget> createState() {
    return new InviteScreenState();
  }
}

SessionManager _sessionManager = SessionManager();

class InviteScreenState extends State<InviteScreen> {


  TextEditingController f = TextEditingController();
  TextEditingController m = TextEditingController();
  TextEditingController l = TextEditingController();
  ImageProvider img;
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    _sessionManager.load();

    if (_image != null) {
      img = Image.file(_image).image;
    } else {
      img = AssetImage("images/circle.png");
    }

    return new Scaffold(
      body: Builder(
          builder: (context) => SafeArea(
                  child: Stack(
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
                                "Invite a Contact",
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
                                  border: Border.all(
                                      width: 1.0, color: Colors.white)),
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
                                            image:
                                                AssetImage("images/add.png")))),
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
                          textInputAction: TextInputAction.next,
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
                          controller: m,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          style: loginTextFieldHint,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                          ],
                          decoration: InputDecoration(
                              hintText: "10-Digit Phone Number",
                              contentPadding: null,
                              prefixIcon:
                                  Image(image: AssetImage("images/call.png"))),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(
                              top: 16.0, left: 64.0, right: 64.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: Container(
                                      height: 1.0, color: Color(0XFF707070))),
                              Container(
                                  margin:
                                      EdgeInsets.only(left: 8.0, right: 8.0),
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
                          controller: l,
                          style: loginTextFieldHint,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                              hintText: "Last Name:",
                              contentPadding: null,
                              prefixIcon:
                                  Image(image: AssetImage("images/user.png"))),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(
                              top: 32.0, left: 16.0, right: 16.0, bottom: 32.0),
                          alignment: Alignment.bottomCenter,
                          child: Align(
                              alignment: FractionalOffset.bottomCenter,
                              child: InkWell(
                                  onTap: () {
                                    manageInputs(context);
                                  },
                                  child: Container(
                                    height: 48.0,
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    child: Text("Send",
                                        style: welcomeScreenButton),
                                    decoration: BoxDecoration(
                                        color: Color(0XFF2E8ECC),
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                  ))))
                    ],
                  )
                ],
              ))),
    );
  }

  String _firstName, _lastName, _mobile;

  void manageInputs(BuildContext context) {
    _firstName = f.text;
    _lastName = l.text;
    _mobile = m.text;

    if (_firstName.isEmpty) {
      showMessage("Enter the first name", context);
    } else if (_mobile.length != 10) {
      showMessage("Enter 10-digits mobile number...", context);
    } else {
      uploadImage(context);
    }
  }

  String imageURL = "";

  void uploadImage(BuildContext context) async {
    if (_image != null) {
      showProgressDialog(context, "Uploading your photo...");
      StorageReference storageReference =
          FirebaseStorage().ref().child("images/$_mobile");
      StorageUploadTask uploadTask = storageReference.putFile(_image);

      await (await uploadTask.onComplete).ref.getDownloadURL().then((value) {
        imageURL = value.toString();
        Navigator.of(context).pop();
        handleTheInvite(context);
      });
    } else {
      handleTheInvite(context);
    }
  }

  Future<void> handleTheInvite(BuildContext context) async {
    showProgressDialog(context, "Loading the content...");

    String uniqueID = randomAlphaNumeric(5);

    await Firestore.instance
        .collection("users")
        .document(_mobile)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        showMessage("Contact already invited or joined...", context);
        Navigator.of(context).pop();
      } else {
        Firestore.instance
          ..collection("users").document(_mobile).setData({
            "id": uniqueID,
            "firstName": _firstName,
            "lastName": _lastName,
            "answers": 1,
            "decision": "incomplete",
            "mobile": _mobile,
            "email": "",
            "zip": "",
            "img": imageURL,
            "invitedBy": _sessionManager.id,
            "temporary": true,
            "ministryCode": _ministryCode,
            "status": "inactive"
          }).then((value) {
            Navigator.of(context).pop();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => QuestionsScreen(
                        _mobile, _firstName + " " + _lastName, 1)));
          });
      }
    });
  }
}
