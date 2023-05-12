import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shopping/consts.dart';
import 'package:shopping/models/user.dart';
import 'package:shopping/pages/auth/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var box = GetStorage("auth");

  late User user;

  @override
  Widget build(BuildContext context) {
    user = User.fromMap(jsonDecode(box.read("user")));

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Icon(
                            Ionicons.log_out_outline,
                            color: Colors.red,
                            size: 75,
                          ),
                          content: Text(
                            "Tizimdan chiqishni hohlaysizmi?",
                            textAlign: TextAlign.center,
                          ),
                          actionsAlignment: MainAxisAlignment.spaceBetween,
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Yo'q",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                var log = GetStorage("auth");
                                var dat = GetStorage("products");
                                await dat.remove("products");
                                await log.remove("user");

                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()),
                                    (route) => false);
                              },
                              style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStatePropertyAll(secondaryColor),
                                  backgroundColor:
                                      MaterialStatePropertyAll(primaryColor),
                                  shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                  )),
                              child: Text("Ha"),
                            ),
                          ],
                        );
                      });
                },
                icon: Icon(Ionicons.log_out_outline),
              ),
            ],
          ),
          SizedBox(height: 20),
          CircleAvatar(
            maxRadius: 75,
            minRadius: 50,
            backgroundColor: Colors.grey.withOpacity(0.3),
            child: Icon(
              Ionicons.person_outline,
              size: 60,
            ),
          ),
          SizedBox(height: 20),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customTitle("Name"),
                  customValue("${user.name}"),
                ],
              ),
              Divider(height: 4, color: Colors.black),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customTitle("Username"),
                  customValue("${user.username}"),
                ],
              ),
              Divider(height: 4, color: Colors.black),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customTitle("Xaridlar soni"),
                  customValue("1"),
                ],
              ),
              Divider(height: 4, color: Colors.black),
            ],
          ),
        ],
      ),
    );
  }

  Widget customTitle(String data) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        "${data}",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget customValue(String data) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        "${data}",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
