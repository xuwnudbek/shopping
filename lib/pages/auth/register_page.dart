import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shopping/consts.dart';
import 'package:shopping/models/user.dart';
import 'package:shopping/pages/auth/login_page.dart';
import 'package:shopping/pages/components/form_field.dart';
import 'package:shopping/pages/main_app.dart';

import '../components/snackbar.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _confirmPassController = TextEditingController();

  GetStorage box = GetStorage("auth");

  bool isLoading = false;

  Future<bool> signUp() async {
    setState(() => isLoading = true);
    if (_nameController.text.isNotEmpty &&
        _usernameController.text.isNotEmpty &&
        _passController.text.isNotEmpty &&
        _confirmPassController.text.isNotEmpty) {
      if (_passController.text.isNotEmpty &&
          _confirmPassController.text.isNotEmpty &&
          _passController.text == _confirmPassController.text) {
        List users = jsonDecode(box.read("users") ?? "[]");
        print("11111 ${box.read("users")}");

        if (users.length > 0) {
          for (var i = 0; i < users.length; i++) {
            User user = User.fromMap(users[i]);
            if (user.username == _usernameController.text) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();

              ScaffoldMessenger.of(context).showSnackBar(
                customSnackbar(msg: "This username already used"),
              );
              setState(() => isLoading = false);

              return false;
            }
          }
          await box.write(
              "user",
              jsonEncode({
                "name": _nameController.text,
                "username": _usernameController.text,
                "pass": _passController.text
              }));

          users.add({
            "name": _nameController.text,
            "username": _usernameController.text,
            "pass": _passController.text
          });

          await box.write("users", jsonEncode(users));
          print("11111 ${box.read("users")}");
          print("00000 ${box.read("user")}");

          setState(() => isLoading = false);

          return true;
        } else {
          await box.write(
              "user",
              jsonEncode({
                "name": _nameController.text,
                "username": _usernameController.text,
                "pass": _passController.text
              }));

          users.add({
            "name": _nameController.text,
            "username": _usernameController.text,
            "pass": _passController.text
          });

          await box.write("users", jsonEncode(users));
          print("11111 ${box.read("users")}");
          print("00000 ${box.read("user")}");

          setState(() => isLoading = false);

          return true;
        }

        return false;
      } else {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).removeCurrentSnackBar();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Password is not confirmed")),
        );
        return false;
      }
    } else {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).removeCurrentSnackBar();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please, fill all Fields")),
      );
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          child: Column(
            // direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: CircleAvatar(
                  backgroundColor: Colors.grey.withOpacity(0.3),
                  child: Icon(
                    Ionicons.person_outline,
                    size: 50,
                  ),
                  maxRadius: 75,
                  minRadius: 50,
                ),
              ),
              Flexible(
                flex: 4,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomFormField(
                          controller: _nameController, hintText: "Name"),
                      CustomFormField(
                          controller: _usernameController,
                          hintText: "Username"),
                      CustomFormField(
                          controller: _passController, hintText: "Password"),
                      CustomFormField(
                          controller: _confirmPassController,
                          hintText: "Confirm password"),
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
                          if (await signUp()) {
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
                                      "Sign Up",
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
                                builder: (context) => LoginPage()),
                            (route) => false,
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Sign In",
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
