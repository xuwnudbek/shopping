import 'package:flutter/material.dart';
import 'package:shopping/consts.dart';

SnackBar customSnackbar({required String msg}) {
  return SnackBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    duration: Duration(seconds: 2),
    content: Container(
      padding: EdgeInsets.all(10),
      // margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: secondaryColor,
        boxShadow: [
          BoxShadow(
            color: grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            "${msg}",
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    ),
  );
}
