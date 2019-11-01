import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:my_share_pal/screens/login_screen.dart';
import 'package:my_share_pal/styleguide/textstyles.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WelcomeScreenState();
  }
}

class WelcomeScreenState extends State<WelcomeScreen> {
  PageController pageController =
      PageController(initialPage: 1, viewportFraction: 0.8);
  int _currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 16.0, bottom: 48.0),
              child: Row(
                children: <Widget>[
                  Image(
                    image: AssetImage("images/menu.png"),
                    height: 24.0,
                    width: 24.0,
                  ),
                  Expanded(
                      child: Center(
                          child: Text(
                    "MySharePal",
                    style: title,
                  )))
                ],
              )),
          Expanded(
              child: PageView.builder(
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  controller: pageController,
                  itemCount: 5,
                  itemBuilder: (context, position) {
                    return screen(position);
                  })),
          InkWell(
              enableFeedback: false,
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Container(
                margin: EdgeInsets.only(
                    left: 32.0, right: 32.0, top: 24.0, bottom: 32.0),
                height: 48.0,
                width: double.infinity,
                alignment: Alignment.center,
                child: Text("Get Started", style: welcomeScreenButton),
                decoration: BoxDecoration(
                    color: Color(0XFF2E8ECC),
                    borderRadius: BorderRadius.circular(8.0)),
              )),
          Padding(
              padding: EdgeInsets.only(bottom: 32.0),
              child: DotsIndicator(
                  dotsCount: 5,
                  position: _currentPage,
                  decorator: DotsDecorator(
                    activeColor: Color(0XFFFFFFFF),
                    size: const Size.square(6.0),
                    spacing: EdgeInsets.only(left: 2.0, right: 2.0),
                  ))),
        ],
      )),
    );
  }

  Widget screen(int position) {
    double left = 8.0;
    double right = 8.0;

    if (position == 0) {
      left = 16.0;
    }

    if (position == 4) {
      right = 16.0;
    }
    return new Container(
        margin: EdgeInsets.only(left: left, right: right),
        decoration: BoxDecoration(
            color: Color(0XFF27292D).withOpacity(0.50),
            borderRadius: BorderRadius.circular(8.0)),
        child: Column(
          children: <Widget>[
            Expanded(
                child: Center(
              child: Container(
                child: Image(image: AssetImage("images/icon.png")),
                padding: EdgeInsets.all(32.0),
              ),
            )),
            Expanded(
                child: Center(
                    child: Container(
              padding: EdgeInsets.all(16.0),
              color: Color(0XFFFFFFFF),
              child: Column(
                children: <Widget>[
                  Text(
                    "WELCOME TO MYSHAREPAL",
                    style: welcomeScreenHeading,
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.",
                      style: welcomeScreenText,
                    ),
                    margin: EdgeInsets.only(top: 16.0),
                  ),
                ],
              ),
            )))
          ],
        ));
  }
}
