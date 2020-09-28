
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/common/values/colors.dart';

Widget transparentAppBar({
  @required BuildContext context,
  Widget title,
  Widget leading,
  List<Widget> actions,
}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Center(
      child: title,
    ),
    leading: leading,
    actions: actions,
  );
}
