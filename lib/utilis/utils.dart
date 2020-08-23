import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

bool isEmpty(String s) {
  return (s == "") ? false : true;
}

void showSnack(BuildContext context, String msg) {
  Flushbar(
    //title: 'This action is prohibited',
    message: msg,
    icon: Icon(
      Icons.info_outline,
      size: 28,
      color: Colors.teal,
    ),
    leftBarIndicatorColor: Colors.teal,
    duration: Duration(seconds: 2),
  )..show(context);
}
