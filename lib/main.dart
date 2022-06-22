import 'package:flutter/material.dart';
import 'package:trackhub/layouts/layoututama.dart';
import 'package:trackhub/screen/splashscreen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      debugShowCheckedModeBanner: false,
      home: Home()
    );
  }
}

class Home extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body:  Center(
          child : Splashscreen()
      ),
      ),
    );
  }
}