import 'package:flutter/material.dart';
import 'package:news_app/global.dart';
import 'package:news_app/pages/welcome/welcome.dart';
import 'package:news_app/routes.dart';


void main()=>Global.init().then((e) => runApp(MyApp()));


class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //去掉右上角的DEBUG
      debugShowCheckedModeBanner: false,
     home: WelcomePage(),
      routes: staticRoutes,
    );
  }
}

