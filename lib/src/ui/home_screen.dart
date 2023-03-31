import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';

class HomePage extends StatefulWidget {
  String email, pwd;
  HomePage({Key? key, required this.email, required this.pwd})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferences? localStorage;

  @override
  void initState() {
    initialistSharedParf();
    super.initState();
  }

  initialistSharedParf() async {
    localStorage = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("home screen"),
      ),
      body: Row(
        children: [
          Column(
            children: [
              // Text("email id : ${localStorage!.getString("email")}"),
              //    Text(email),
              //  Text(pwd),
              Text("email id : ${localStorage!.getString("email")}"),
              Text("password id : ${localStorage!.getString("password")}"),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              localStorage!.remove("email");
              localStorage!.remove("password");
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) {
                return LoginScreen();
              }));
            },
            child: Text("Logout"),
          ),
        ],
      ),
    );
  }

  Future<String?> getEmail() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    return localStorage.getString("email");
  }
}
