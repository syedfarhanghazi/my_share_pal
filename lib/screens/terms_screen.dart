import 'package:flutter/material.dart';
import 'package:my_share_pal/styleguide/colors.dart';
import 'package:my_share_pal/styleguide/textstyles.dart';
import 'package:my_share_pal/utils/utils.dart';

import 'home_screen.dart';

class TermsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new TermsScreenState();
  }
}

class TermsScreenState extends State<TermsScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: null,
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 16.0, bottom: 80.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                      onTap: () {
                        moveBack(context);
                      },
                      child: Image(
                        image: AssetImage("images/arrow.png"),
                        height: 16.0,
                      )),
                  Text(
                    "Terms of Service",
                    style: title,
                  ),
          InkWell(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                return HomeScreen();
              }));
            },
            child: Image(
                    image: AssetImage("images/cross.png"),
                    height: 24.0,
                  ))
                ],
              )),
          Expanded(
              child: Stack(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 32, left: 16, right: 16),
                  padding: EdgeInsets.only(left: 16.0, right: 16, bottom: 16.0),
                  decoration: BoxDecoration(
                      color: Color(0XFFFFFFFF),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: ListView(
                    children: <Widget>[
                      Container(
                        child: Text("Terms of Service",
                            style: privacyTitle, textAlign: TextAlign.center),
                        margin: EdgeInsets.only(top: 16.0, bottom: 8.0),
                      ),
                      Text(
                        "Last updated: Oct 24, 2019\n\nPlease read these Terms of Service (\"Terms of Service\") carefully before using the My Share Pal App.  \n\nYour access to and use of the Service is conditioned on your acceptance of and compliance with these Terms. These Terms apply to all visitors, users and others who access or use the Service.\n\nBy accessing or using the Service you agree to be bound by these Terms. If you disagree with any part of the terms then you may not access the Service.\n\nTermination\n\nWe may terminate or suspend access to our Service immediately, without prior notice or liability, for any reason whatsoever, including without limitation if you breach the Terms.\n\nAll provisions of the Terms which by their nature should survive termination shall survive termination, including, without limitation, ownership provisions, warranty disclaimers, indemnity and limitations of liability.\n\nLinks To Other Web Sites\n\nOur Service may contain links to third-party web sites or services that are not owned or controlled by My SharePal Inc.\n\nMy SharePal Inc. has no control over, and assumes no responsibility for, the content, privacy policies, or practices of any third party web sites or services. You further acknowledge and agree that MySharePal Inc. shall not be responsible or liable, directly or indirectly, for any damage or loss caused or alleged to be caused by or in connection with use of or reliance on any such content, goods or services available on or through any such web sites or services.\n",
                        style: privacyText,
                      ),
                      Container(
                        child: null,
                      )
                    ],
                  )),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(gradient: linearGradient),
                  ))
            ],
          ))
        ],
      )),
    );
  }
}
