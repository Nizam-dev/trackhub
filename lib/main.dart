import 'package:flutter/material.dart';
import 'package:trackhub/layouts/layoututama.dart';
import 'package:trackhub/screen/splashscreen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp( //use MaterialApp() widget like this
      home: Home() //create new widget class for this 'home' to 
                   // escape 'No MediaQuery widget found' error
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