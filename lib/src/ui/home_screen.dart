import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../data/remote/repo/fetch_api.dart';
import 'animation_screen.dart';
import 'login_screen.dart';

class HomePage extends StatefulWidget {
  String email, pwd;
  HomePage({Key? key, required this.email, required this.pwd})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  List<Users> userList = [];
  bool isOnline = true;
  SharedPreferences? localStorage;

  get developer => null;
  @override
  void initState() {
    fetchData();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    initialistSharedParf();
    super.initState();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
      if (result == ConnectivityResult.none) {
        setState(() {
          isOnline = false;
        });
      } else {
        setState(() {
          isOnline = true;
        });
        fetchData();
      }
    });
  }

  checkConnection() {}

  initialistSharedParf() async {
    localStorage = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("home screen"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
// Text("email id : ${localStorage!.getString("email")}"),
//    Text(email),
//  Text(pwd),
                    Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                            "email id : ${localStorage?.getString("email")}")),
                    Text(
                        "password id : ${localStorage?.getString("password")}"),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      localStorage?.remove("email");
                      localStorage?.remove("password");
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) {
                        return LoginScreen();
                      }));
                    },
                    child: Text("Logout"),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: isOnline == false
                  ? const Text(" Internet not connected")
                  : ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Hero(
                          tag: "krishna" + index.toString(),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AnimationScreen(
                                            name:
                                                "${userList[index].firstName} ${userList[index].lastName}",
                                            email: "${userList[index].email}",
                                            img: "${userList[index].image}",
                                          )));
                            },
// title: snapshot.data[index].users[index].firstName,
                            title: Text(
                                "${userList[index].firstName ?? ""} ${userList[index].lastName ?? ""}"),
                            subtitle: Text(userList[index].email ?? ""),
                            leading: Image.network("${userList[index].image}"),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String?> getEmail() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    return localStorage.getString("email");
  }

  fetchData() async {
    final response = await http.get(Uri.parse("https://dummyjson.com/users"));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var userData = UserData.fromJson(jsonResponse);
      setState(() {
        userList.addAll(userData.users ?? []);
      });

      /*var ffd =  jsonResponse.map((data) =>  UserData.fromJson(data));
    return jsonResponse.map((data) =>  UserData.fromJson(data));*/
    } else {
      throw Exception("Failed to Load data");
    }
  }
}
