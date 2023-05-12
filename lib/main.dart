import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopping/pages/auth/login_page.dart';
import 'package:shopping/pages/main_app.dart';

void main() async {
  await GetStorage.init("auth");
  await GetStorage.init("products");

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var box = GetStorage("auth");
  var data;

  @override
  void initState() {
    box.erase();
    data = box.read("user");
    box.listenKey("user", (value) {
      if (value != null) {
        setState(() {
          data = value;
        });
      } else {
        setState(() {
          data = null;
        });
      }
    });
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
        fontFamily: "Poppins",
      ),
      home: data != null ? MainApp() : LoginPage(),
    );
  }
}
