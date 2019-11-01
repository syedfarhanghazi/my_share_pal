import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


void showProgressDialog(BuildContext context, String progressText){
  showDialog(barrierDismissible:false,
      context: context, builder: (BuildContext context){
        return AlertDialog(
          titlePadding: EdgeInsets.only(top: 16.0, left: 16.0),
          contentPadding: EdgeInsets.all(16.0),
          title: Text("Please wait...", style: TextStyle(fontSize: 20.0, color: Colors.black),),
          content: Row(
            children: <Widget>[
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ), Container(margin:EdgeInsets.only(left: 16.0),child: Text(progressText, style: TextStyle(fontSize:14.0,color: Color(0XFF737373)),))
            ],
          ),
        );
      });
}

void showMessage(String text, BuildContext context) {
  SnackBar snackBar = SnackBar(content: Text(text), backgroundColor: Color(0XFF2E8ECC),);
  Scaffold.of(context).showSnackBar(snackBar);
}

void moveBack(BuildContext context){
  Navigator.pop(context);
}




