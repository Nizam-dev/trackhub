import 'package:flutter/material.dart';
import 'package:trackhub/widget/maincolor.dart';
import 'package:trackhub/screen/login.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/angkot.png"),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Selamat Datang Di TrackHub",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
              ),
              Text("Masuk untuk mulai bekerja dan lanjutkan perjalanan!",
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: FlatButton(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                    child: Text(
                      "Masuk",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  color: Maincolor.PrimaryColor,
                  disabledColor: Colors.grey,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15)),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
