import 'package:flutter/cupertino.dart';

Widget getImage(String name, {String imgName = "images/top_image.png"}) {
  return Image.asset(
    imgName,
    scale: 2,
  );
}
