import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shopping/consts.dart';
import 'package:shopping/models/user.dart';
import 'package:shopping/pages/auth/register_page.dart';
import 'package:shopping/pages/components/form_field.dart';
import 'package:shopping/pages/main_app.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  GetStorage box = GetStorage("auth");

  bool isLoading = false;

  Future<bool> signIn() async {
    setState(() => isLoading = true);

    String username = _usernameController.text;
    String pass = _passController.text;

    if (username.isNotEmpty && pass.isNotEmpty) {
      List users = jsonDecode(box.read("users") ?? "[]");
      print(users);
      if (users.isNotEmpty) {
        for (var i = 0; i < users.length; i++) {
          User user = User.fromMap(users[i]);
          if (user.username == _usernameController.text && user.pass == pass) {
            await box.write("user", {
              "name": user.name,
              "username": user.username,
              "pass": user.pass,
            });

            return true;
          }
        }

        setState(() => isLoading = false);

        return true;
      } else {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).removeCurrentSnackBar();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("No data"),
          ),
        );
        return false;
      }
    } else {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).removeCurrentSnackBar();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please, enter all fields!"),
        ),
      );
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 60.0),
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: CircleAvatar(
                  backgroundColor: Colors.grey.withOpacity(0.3),
                  child: Icon(
                    Ionicons.person_outline,
                    size: 75,
                    grade: 0.5,
                    opticalSize: 0.5,
                  ),
                  maxRadius: 75,
                  minRadius: 50,
                ),
              ),
              Flexible(
                flex: 2,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomFormField(
                        controller: _usernameController,
                        hintText: "Username",
                      ),
                      CustomFormField(
                        controller: _passController,
                        hintText: "Password",
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(primaryColor),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          if (await signIn()) {
                            await Future.delayed(Duration(seconds: 1))
                                .then((value) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainApp()),
                                (route) => false,
                              );
                            });
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              isLoading
                                  ? SizedBox.square(
                                      dimension: 25,
                                      child: CircularProgressIndicator(),
                                    )
                                  : Text(
                                      "Sign In",
                                      style: TextStyle(color: secondaryColor),
                                    ),
                            ],
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.red),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()),
                            (route) => false,
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Sign Up",
                              style: TextStyle(color: secondaryColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
