import 'package:demo/src/ui/home_screen.dart';
import 'package:demo/src/ui/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  var email = localStorage.getString("email");
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: email == null
          ? LoginScreen()
          : HomePage(
              email: '${localStorage.get('email')}',
              pwd: '${localStorage.get('password')}',
            ),
    ),
  );
}

// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: LoginScreen(),
//     );
//   }
// }
