import 'package:flutter/material.dart';
import 'package:trackhub/widget/maincolor.dart';
import 'package:trackhub/screen/login.dart';

class Masuk extends StatefulWidget {
  @override
  _MasukState createState() => _MasukState();
}

class _MasukState extends State<Masuk> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: 
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/angkot.png"),
                  Align(
                  alignment: Alignment.centerLeft,
                  child : Text("Selamat Datang Di TrackHub",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22)),
                  ),
                  Text("Masuk untuk mulai bekerja dan lanjutkan perjalanan!",style: TextStyle(fontSize: 16)),
                  SizedBox(height: 50),

                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: RaisedButton(
                          child: Text("Masuk"),
                          onPressed: (){
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()
                                ),
                            );
                          },
                          color: Maincolor.PrimaryColor,
                          textColor: Colors.white,
                          padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
                          splashColor: Colors.grey,
                        ),
                  ),

                
                ],
              ),
         
        ),
      ),
    );
  }
}