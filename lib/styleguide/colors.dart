import 'package:flutter/material.dart';


Color secondColor = Color(0XFFFFFFFF);
Color backgroundColor = Color(0XFF2F3237);

RadialGradient radialGradient = RadialGradient(colors: [Color(0XFF3C3F46),Color(0XFF27292D)]);
LinearGradient linearGradient = LinearGradient(colors: [Color(0XFF27292D).withOpacity(0.0), Color(0XFF222222).withOpacity(0.22), ], stops: [0.0, 1.0],begin: FractionalOffset.topCenter,
  end: FractionalOffset.bottomCenter);

LinearGradient myCommunityGradient = LinearGradient(colors: [Color(0XFF3CA053),Color(0XFF46BC62)]);
LinearGradient meGradient = LinearGradient(colors: [Color(0XFF367ABF),Color(0XFF459DF5)]);

LinearGradient parentGradient = LinearGradient(colors: [Color(0XFF777BBC),Color(0XFFF541D5)]);