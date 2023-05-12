import 'package:flutter/material.dart';

//Colors
Color primaryColor = Colors.blue;
Color secondaryColor = Colors.white;
Color grey = Colors.grey;

//Fake data
List<Map<String, dynamic>> fakeProducts = [
  {
    "title": "Iphone 11 Pro",
    "img": "phones.jpg",
    "price": "1200000",
  },
  {
    "title": "Iphone 14 Pro",
    "img": "phones.jpg",
    "price": "15000000",
  },
  {
    "title": "Iphone X",
    "img": "phones.jpg",
    "price": "1000000",
  }
];

//Price prettier
String prettyPrice(int price) {
  String p = price.toString();
  String s = "";

  int k = 0;
  for (var i = p.length - 1; i >= 0; i--) {
    if (k == 3) {
      s = "${p[i]} " + s;
      k = 0;
    } else {
      s = p[i] + s;
    }
    k++;
  }
  return s;
}

int intParse(String str) {
  return int.parse(str.replaceAll(" ", ""));
}
