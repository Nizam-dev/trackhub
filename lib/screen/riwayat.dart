import 'package:flutter/material.dart';
import 'package:trackhub/widget/cardbox.dart';

class Riwayat extends StatefulWidget {
  @override
  _RiwayatState createState() => _RiwayatState();
}

class _RiwayatState extends State<Riwayat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            title: Center(
              child: Text(
                "Riwayat",
                style: TextStyle(color: Colors.black),
            ),
            ),
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
        ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top: 25, left: 15,right: 15),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Cardbox()
            ]
          )
        )
      ),
    );
  }
}