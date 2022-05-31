import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:trackhub/widget/maincolor.dart';

class Pendataan extends StatefulWidget {
  @override
  _PendataanState createState() => _PendataanState();
}

class _PendataanState extends State<Pendataan> {
  String _chosenValueTrayek;
  String _chosenValueSopir;
  var pilihantrayek = <String>[
                    'Angkutan Umum',
                    'Angkutan Sekolah',
                  ];
   var pilihansopir = <String>[
                    'Anam',
                    'Soper',
                  ];

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            title: Center(
              child: Text(
                "Pendataan Penumpang",
                style: TextStyle(color: Colors.black),
            ),
            ),
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
        ),
      body: Container(
        padding: EdgeInsets.only(top: 25, left: 15,right: 15),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Data Angkutan",
                  style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),
                  ),
              ),
              SizedBox(height: 8),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Masukan data angkutan terlebih dahulu.",
                  style: TextStyle(fontSize: 15),
                  ),
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Pastikan data yang dimasukkan sudah benar.",
                  style: TextStyle(fontSize: 15),
                  ),
              ),

              SizedBox(height: 20),

              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Trayek Angkutan",
                  style: TextStyle(fontSize: 15),
                  ),
              ),

              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child : InputDecorator(
                decoration: const InputDecoration(border: OutlineInputBorder(),contentPadding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 5)),
                child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _chosenValueTrayek,
                  //elevation: 5,
                  style: TextStyle(color: Colors.black),
                  items: pilihantrayek.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  hint: Text(
                    "Pilih Trayek",
                    style: TextStyle(
                        color: Colors.black38,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  onChanged: (String value) {
                    setState(() {
                      _chosenValueTrayek = value;
                    });
                  },
                ),
                ))
              ),
              
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Nama Sopir",
                  style: TextStyle(fontSize: 15),
                  ),
              ),

              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child : InputDecorator(
                decoration: const InputDecoration(border: OutlineInputBorder(),contentPadding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 5)),
                child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _chosenValueSopir,
                  //elevation: 5,
                  style: TextStyle(color: Colors.black),
                  items: pilihansopir.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  hint: Text(
                    "Pilih Sopir",
                    style: TextStyle(
                        color: Colors.black38,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  onChanged: (String value) {
                    setState(() {
                      _chosenValueSopir = value;
                    });
                  },
                ),
                ))
              ),
              
              SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                      child: Text("Lanjutkan"),
                      onPressed: (){},
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