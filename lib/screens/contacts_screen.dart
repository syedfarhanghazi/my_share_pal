import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_share_pal/models/invite_model.dart';
import 'package:my_share_pal/screens/home_screen.dart';
import 'package:my_share_pal/screens/invite_screen.dart';
import 'package:my_share_pal/screens/questions_screen.dart';
import 'package:my_share_pal/styleguide/colors.dart';
import 'package:my_share_pal/styleguide/textstyles.dart';
import 'package:my_share_pal/utils/session_manager.dart';
import 'package:url_launcher/url_launcher.dart';

bool isStateRefresh = false;

bool isSorted = false;

class ContactsScreen extends StatefulWidget {
  ContactsScreen() {
    isStateRefresh = true;
    isLoaded = false;
  }

  @override
  State<StatefulWidget> createState() {
    return ContactsScreenState();
  }
}

bool isLoaded = false;

class ContactsScreenState extends State<ContactsScreen> {
  int listSize = 0;

  List<InviteModel> list = List();

  @override
  Widget build(BuildContext context) {
    if (isStateRefresh) {
      setState(() {
        isStateRefresh = false;
      });
    }

    if (!isLoaded) {
      loadInvites();
    }
    listSize = list.length;

    return Scaffold(
      body: Builder(
          builder: (context) => SafeArea(
                  child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
                          child: Row(
                            children: <Widget>[
                              InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(builder: ((context) {
                                      return HomeScreen();
                                    })));
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
                        margin: EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "$listSize Contacts",
                              style: contactsTitle,
                            ),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    if (isSorted) {
                                      list.sort((a, b) {
                                        return b.firstName
                                            .toLowerCase()
                                            .compareTo(
                                                a.firstName.toLowerCase());
                                      });
                                      isSorted = false;
                                    } else {
                                      isSorted = true;
                                      list.sort((a, b) {
                                        return a.firstName
                                            .toLowerCase()
                                            .compareTo(
                                                b.firstName.toLowerCase());
                                      });
                                    }
                                  });
                                },
                                child:
                                    Image(image: AssetImage("images/sort.png")))
                          ],
                        ),
                      ),
                      Expanded(
                          child: ListView.builder(
                              itemCount: list.length,
                              itemBuilder: (context, position) {
                                return listItem(position);
                              }))
                    ],
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          margin: EdgeInsets.all(16.0),
                          child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => InviteScreen(_sessionManager.ministryID)));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0XFF2E8ECC)),
                                height: 56.0,
                                width: 56.0,
                                child:
                                    Image(image: AssetImage("images/send.png")),
                              ))))
                ],
              ))),
    );
  }

  Widget listItem(position) {
    ImageProvider img;

    InviteModel model = list[position];

    String name = model.firstName + " " + model.lastName;
    String mob = model.mobile;

    String m1 = mob.substring(0, 3);
    String m2 = mob.substring(3, 6);
    String m3 = mob.substring(6, 10);

    String newMobile = "$m1.$m2.$m3";

    Color dotColor;

    if (model.img != "") {
      img = NetworkImage(model.img);
    } else {
      img = AssetImage("images/circle.png");
    }

    if (model.decision == "incomplete") {
      dotColor = Colors.yellow;
    } else if (model.decision == "not accepted") {
      dotColor = Colors.red;
    } else {
      dotColor = Colors.green;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: InkWell(
          onTap: () {
            if (model.decision == "incomplete") {
              print("MyAnswers: " + model.answers.toString());
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => QuestionsScreen(model.mobile,
                      model.firstName + " " + model.lastName, model.answers)));
            }
          },
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover, image: img),
                              shape: BoxShape.circle),
                          height: 40.0,
                          width: 40.0),
                      Positioned(
                          top: 30.0,
                          left: 30.0,
                          child: Container(
                              decoration: BoxDecoration(
                                  color: dotColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: backgroundColor, width: 1.0)),
                              height: 8.0,
                              width: 8.0))
                    ],
                  ),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          name,
                          style: contactsName,
                        ),
                        Text(
                          model.decision,
                          style: contactsStatus,
                        ),
                        Text(
                          newMobile,
                          style: contactsStatus,
                        )
                      ],
                    ),
                  )),
                  InkWell(
                      onTap: () {
                        sendMessage("+1" + model.mobile);
                      },
                      child: Container(
                          child: Image(
                              image: AssetImage("images/chat.png"),
                              height: 24.0,
                              width: 24.0)))
                ],
              ),
              Container(
                height: 1,
                margin: EdgeInsets.only(left: 56.0, top: 8.0),
                color: Color(0XFF707070),
              )
            ],
          )),
    );
  }

  SessionManager _sessionManager = SessionManager();

  void loadInvites() async {
    list.clear();
    await _sessionManager.load();

    Firestore.instance
        .collection("users")
        .where("invitedBy", isEqualTo: _sessionManager.id)
        .getDocuments()
        .then((snapshots) {
      print("MyTestingPhase: InThen " + snapshots.documents.length.toString());
      snapshots.documents.forEach((f) {
        print("MyTestingPhase: inForeach " +
            snapshots.documents.length.toString());
        InviteModel inviteModel = InviteModel(
            f.data['firstName'],
            f.data['lastName'],
            f.data['mobile'],
            f.data['img'],
            f.data['decision'],
            f.data['invitedBy'],
            f.data['ministryCode'],
            f.data['answers']);
        list.add(inviteModel);
      });

      setState(() {
        isLoaded = true;
      });
    });
  }

  String url;

  sendMessage(String mobileNumber) async {
    if (Platform.isAndroid) {
      url =
          'sms:$mobileNumber?body=Download MySharePal Today!\n\nhttps://mysharepal.com';
      await launch(url);
    } else if (Platform.isIOS) {
      url =
          'sms:$mobileNumber&body=Download MySharePal Today!\h\nttps://mysharepal.com';
      await launch(url);
    }
  }
}
