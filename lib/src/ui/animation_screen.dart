import 'package:flutter/material.dart';

class AnimationScreen extends StatelessWidget {
  final img;
  final name;
  final email;
  const AnimationScreen({Key? key, this.img, this.name, this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Animated Screen"),
        ),
        body: Hero(
          tag: "1",
          child: Center(
            child: Column(
              children: [
                Image.network(img),
                Text(name),
                Text(email),
              ],
            ),
          ),
        ));
  }
}
