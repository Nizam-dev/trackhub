import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackhub/layouts/layoututama.dart';
import 'package:trackhub/screen/home.dart';
import 'package:trackhub/screen/onboarding.dart';
import 'package:trackhub/screen/tracking.dart';

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  bool isAuth = false;

  @override
  void initState(){
    super.initState();
    _checkIfLoggedIn();
    startSplashScreen();
  }

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if(token != null){
      if(mounted){
        setState(() {
          isAuth = true;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset("assets/images/logo.png",width: 130,)
    );
  }

  startSplashScreen() async {
  var duration = const Duration(seconds: 3);
  return Timer(duration, () {
    if(isAuth){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LayoutUtama()));
    } else{
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Home()));
    }

    
  }
  );
}
}
