import 'package:flutter/material.dart';
import 'package:flutter_number_2/utils/colors.dart' as app_color;
import 'package:flutter_number_2/utils/images.dart' as app_img;

PreferredSizeWidget? customAppBar(
  BuildContext context,
  bool isPurple,
  String title,
) {
  return AppBar(
    centerTitle: true,
    title: Text(title),
    leading: Icon(
      Icons.arrow_back,
      color: Colors.white.withOpacity(0),
    ),
    backgroundColor: app_color.primary,
    elevation: 0,
  );
}
