import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_share_pal/screens/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  SharedPreferences sharedPreferences;

  String _name = "NAME";
  String _image = "IMAGE";
  String _phone = "PHONE";
  String _id = "ID";
  String _ministryID = "MINISTRY_ID";
  String _login = "IS_LOGIN";

  Future<bool> load() async {

    if(sharedPreferences==null){
    sharedPreferences = await SharedPreferences.getInstance();

    if(sharedPreferences!=null){
      return true;
    } else {
      return false;
    }} else {
      return true;
    }
  }

  createSession(String id, String name, String img, String phone, String ministryID) {
    sharedPreferences.setString(_id, id);
    sharedPreferences.setString(_name, name);
    sharedPreferences.setString(_image, img);
    sharedPreferences.setString(_phone, phone);
    sharedPreferences.setString(_ministryID, ministryID);
    sharedPreferences.setBool(_login, true);
  }


  logout(BuildContext ctx){
    sharedPreferences.clear();
    Navigator.of(ctx).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        RegisterScreen()), (Route<dynamic> route) => false);
  }

  bool get isLogin => sharedPreferences.getBool(_login);

  String get id => sharedPreferences.getString(_id);

  String get name => sharedPreferences.getString(_name);

  String get email => sharedPreferences.getString(_phone);

  String get img => sharedPreferences.getString(_image);

  String get ministryID => sharedPreferences.getString(_ministryID);

  String get phone => sharedPreferences.getString(_phone);

  String get image => sharedPreferences.getString(_image);



}
