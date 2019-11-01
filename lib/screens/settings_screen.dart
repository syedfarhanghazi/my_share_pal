import 'package:flutter/material.dart';
import 'package:my_share_pal/screens/privacy_screen.dart';
import 'package:my_share_pal/screens/terms_screen.dart';
import 'package:my_share_pal/styleguide/textstyles.dart';
import 'package:my_share_pal/utils/utils.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SettingsScreenState();
  }
}

class SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SafeArea(
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
                    "Settings",
                    style: title,
                  )))
                ],
              )),
          Container(
              margin: EdgeInsets.only(left: 16.0, right: 16.0),
              child: InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return PrivacyScreen();
                    }));
                  },
                  child: Row(
                    children: <Widget>[
                      Image(image: AssetImage("images/privacy.png")),
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.only(left: 16.0),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Privacy",
                              style: settingsLabel,
                            )
                          ],
                        ),
                      )),
                      Image(image: AssetImage("images/next.png"))
                    ],
                  ))),
          Container(
            color: Color(0XFF707070),
            height: 1,
            margin: EdgeInsets.only(
                left: 56.0, right: 16.0, top: 16.0, bottom: 16.0),
          ),
          Container(
              margin: EdgeInsets.only(left: 16.0, right: 16.0),
              child: InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return TermsScreen();
                    }));
                  },
                  child: Row(
                    children: <Widget>[
                      Image(image: AssetImage("images/terms.png")),
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.only(left: 16.0),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Terms of Service",
                              style: settingsLabel,
                            )
                          ],
                        ),
                      )),
                      Image(image: AssetImage("images/next.png"))
                    ],
                  )))
        ],
      )),
    );
  }
}
