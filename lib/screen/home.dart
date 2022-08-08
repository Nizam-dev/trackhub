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
              Image.asset("assets/images/logo.png",width: 130),
              SizedBox(height: 15),
              Align(
                alignment: Alignment.center,
                child: Text("Selamat Datang di",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
              Align(
                alignment: Alignment.center,
                child: Text("Dinas Perhubungan Kabupaten Banyuwangi",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 22,),textAlign: TextAlign.center),
              ),
             
              SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: FlatButton(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                    child: Text(
                      "Lanjut",
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
                    Navigator.push(
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
