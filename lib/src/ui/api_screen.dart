import 'dart:convert';

import 'package:demo/src/ui/animation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;

import '../data/remote/repo/fetch_api.dart';

class ApiScreen extends StatefulWidget {
  const ApiScreen({Key? key}) : super(key: key);

  @override
  State<ApiScreen> createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {
  List<Users> userList = [];
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
    return Container(
        child: ListView.builder(
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
    ));
  }

  fetchData() async {
    final response = await http.get(Uri.parse("https://dummyjson.com/users"));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var userData = UserData.fromJson(jsonResponse);
      userList.addAll(userData.users ?? []);

      /*var ffd =  jsonResponse.map((data) =>  UserData.fromJson(data));
    return jsonResponse.map((data) =>  UserData.fromJson(data));*/
    } else {
      throw Exception("Failed to Load data");
    }
  }
}
