import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_share_pal/screens/contacts_screen.dart';
import 'package:my_share_pal/styleguide/textstyles.dart';
import 'package:my_share_pal/utils/utils.dart';

import 'home_screen.dart';

String _mobile, _name;
List<String> list = new List();

int _currentPage = 1;

class QuestionsScreen extends StatefulWidget {
  QuestionsScreen(String mobile, String name, int position) {
    _mobile = mobile;
    _name = name.trim();
    _currentPage = position;
    addAnswers();
  }

  void addAnswers() {
    list.add("Do you have any kind of spiritual beliefs?");
    list.add("To you, who is Jesus?");
    list.add("Do you think there is a heaven or hell?");
    list.add("If you died, where would you go? If heaven, why?");
    list.add(
        "If there was an easier way to know how to get to heaven, would you want to know?");
    list.add(
        "“For all have sinned and fallen short of the glory of God”\n– Romans 3:23 (NIV)\n\nWhat does this say to you?");
    list.add(
        "“For the wages of sin is death, but the gift of God is eternal life in Christ Jesus our Lord”\n– Romans 6:23 (NIV)\n\nWhat does this say to you?");
    list.add(
        "“Jesus answered, “I am the way and the truth and the life. No one comes to the Father except through me.”\n\n– John 14:6 (NIV)\n\nWhat does this say to you?");
    list.add(
        "“But god demonstrates His own love for us in this: While we were still sinners, Christ died for us.”\n\n– Romans 5:8 (NIV)\n\nWhat does this say to you?");
    list.add(
        "“If you declare with your mouth, “Jesus is Lord”, and believe in your heart that God raised him from the dead, you will be saved. For it is with your heart that you believe and are justified, and it is with your mouth that you profess your faith and are saved. As scripture says, “Anyone who believes in Him will never be put to shame.” For, “Everyone who calls on the name of the Lord will be saved.”\n\n– Romans 10:9-11,13 (NIV)\n\nWhat does this say to you?");
    list.add(
        "“For by grace you have been saved through faith. And this is not your own doing; it is the gift of God, not a result of works, so that no one may boast.”\n\n– Ephesians 2:8-9 (NIV)\n\nWhat does this say to you?");
    list.add(
        "“And He did for all, that those who live should no longer live for themselves but for Him who died for them and was raised again.”\n–	2 Corinthians 5:15 (NIV)\n\nWhat does this say to you?");
    list.add(
        "“Here I am! I stand at the door and knock. If anyone hears my voice and opens the door, I will come in and eat with that person, and they with me.”\n– Revelation 3:20 (NIV)\n\nWhat does this say to you?");
    list.add("Are you a sinner?");
    list.add("Do you want forgiveness for your sins?");
    list.add("Do you believe Jesus died on the cross for you and rose again?");
    list.add("Are you willing to surrender your life to Jesus Christ?");
    list.add(
        "Are you ready to invite Jesus into your life and into your heart?");
    list.add(
        "Heavenly Father, I have sinned against You. I want forgiveness of all my sins. I believe Jesus died on the cross for me and rose again.  Father, I give You my life to do with as You wish. I want Jesus Christ to come into my life and into my heart. I ask this in Jesus’ name. Amen.");

    list.add("");
  }

  @override
  State<StatefulWidget> createState() {
    return QuestionsScreenState();
  }
}

Color _nextColor, _previousColor, _previousIconColor, _nextIconColor;

class QuestionsScreenState extends State<QuestionsScreen> {
  @override
  Widget build(BuildContext context) {
    if (_currentPage == 1) {
      _previousColor = Color(0XFF2E8ECC).withOpacity(0.40);
      _previousIconColor = Colors.grey;
      _nextColor = Color(0XFF2E8ECC);
      _nextIconColor = Colors.white;
    } else if (_currentPage == 20) {
      _currentPage = 19;
      _previousColor = Color(0XFF2E8ECC);
      _previousIconColor = Colors.white;
      _nextColor = Color(0XFF2E8ECC).withOpacity(0.40);
      _nextIconColor = Colors.grey;
    } else {
      _previousColor = Color(0XFF2E8ECC);
      _previousIconColor = Colors.white;
      _nextColor = Color(0XFF2E8ECC);
      _nextIconColor = Colors.white;
    }

    return new WillPopScope(
      onWillPop: () {
        return Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (c) => ContactsScreen()));
      },
      child: Scaffold(
          body: SafeArea(
              child: Builder(
                  builder: (context) => Stack(
                        children: <Widget>[
                          Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(
                                  left: 16.0,
                                  right: 16.0,
                                  top: 16.0,
                                  bottom: 80.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(builder: (c) => ContactsScreen()));
                                      },
                                      child: Image(
                                        image: AssetImage("images/arrow.png"),
                                        height: 16.0,
                                      )),
                                  Text(
                                    "Share",
                                    style: title,
                                  ),
                                  InkWell(
                                      onTap: (){
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                                          return HomeScreen();
                                        }));
                                      },
                                      child:  Image(
                                        image: AssetImage("images/cross.png"),
                                        height: 24.0,
                                      ))
                                ],
                              )),
                          Positioned.fill(
                              left: -57.0,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: <Widget>[
                                    RotatedBox(
                                        quarterTurns: 1,
                                        child: ClipPath(
                                          clipper: CustomHalfCircleClipper(),
                                          child: Container(
                                            height: 112,
                                            child: Image(
                                                image: AssetImage(
                                                    "images/greencircle.png")),
                                          ),
                                        )),
                                    Flexible(
                                        child: Container(
                                      margin: EdgeInsets.only(
                                          left: 32.0, right: 16.0),
                                      child: Text(
                                        list[_currentPage - 1],
                                        style: questionText,
                                        textAlign: TextAlign.center,
                                      ),
                                    ))
                                  ],
                                ),
                              )),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (_currentPage != 1) {
                                              _currentPage = _currentPage - 1;
                                              updateInFirebase();
                                            }
                                          });
                                        },
                                        child: Container(
                                          child: Image(
                                            color: _previousIconColor,
                                            image:
                                                AssetImage("images/back.png"),
                                            height: 24.0,
                                            width: 24.0,
                                          ),
                                          height: 56.0,
                                          width: 56.0,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: _previousColor),
                                        )),
                                    Text(
                                      "$_currentPage/19",
                                      style: questionText,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          setState(() {


                                            if (_currentPage < 19) {
                                              if (_currentPage == 18) {
                                                _currentPage = _currentPage + 1;
                                              } else {
                                                _currentPage = _currentPage + 1;
                                                updateInFirebase();
                                              }
                                            } else if (_currentPage == 19) {
                                              _currentPage = _currentPage + 1;
                                              loadBottomSheet(context);
                                            }
                                          });
                                        },
                                        child: Container(
                                          child: Image(
                                            color: _nextIconColor,
                                            image:
                                                AssetImage("images/next.png"),
                                            height: 24.0,
                                            width: 24.0,
                                          ),
                                          height: 56.0,
                                          width: 56.0,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: _nextColor),
                                        ))
                                  ],
                                )),
                          )
                        ],
                      )))),
    );
  }
}

void loadBottomSheet(BuildContext context) {
  showBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext bc) {
        return Container(
          margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
          child: Wrap(
            children: <Widget>[
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.80),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "Did $_name accept Christ?",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        color: Colors.grey,
                        height: 1.0,
                      ),
                      InkWell(
                          onTap: () {
                            updateInStatus("accepted", context);
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              "YES",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600),
                            ),
                          )),
                      Container(
                        color: Colors.grey,
                        height: 1.0,
                      ),
                      InkWell(
                          onTap: () {
                            updateInStatus("not accepted", context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              "NO",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600),
                            ),
                          ))
                    ],
                  )),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) {
                      return ContactsScreen();
                    }));
                  },
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      });
}

Future<void> updateInFirebase() async {
  await Firestore.instance
      .collection("users")
      .document(_mobile)
      .updateData({"answers": _currentPage});
}

Future<void> updateInStatus(String decision, BuildContext context) async {
  showProgressDialog(context, "Updating the contact details...");

  await Firestore.instance
      .collection("users")
      .document(_mobile)
      .updateData({"decision": decision, "answers": 19}).then((value) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return ContactsScreen();
    }));
  });
}

class CustomHalfCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = new Path();
    path.lineTo(0.0, size.height / 2);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width, 0);
    /* path.lineTo(size.width/2, 0.0);
    path.lineTo(size.width/2, size.height);
    path.lineTo(size.width, size.height);*/
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
