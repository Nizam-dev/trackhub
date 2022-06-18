import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trackhub/widget/maincolor.dart';
import 'package:url_launcher/url_launcher.dart';

class ButuhBantuan extends StatefulWidget {

  @override
  _ButuhBantuanState createState() => _ButuhBantuanState();
}

class _ButuhBantuanState extends State<ButuhBantuan> {
  final _formKey = GlobalKey<FormState>();
  var username, nama, keluhan,password;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _secureText = true;
  var pilihankeluhan = <String>[
    "Lupa Password?",
    "Lupa Username?",
    "Lupa Username dan Password?",
  ];
  int _pilihan = 0;
  
  void initState(){
    keluhan = pilihankeluhan[_pilihan];
    super.initState();
  }

   showHide(){
    setState(() {
      _secureText = !_secureText;
    });
  }



  @override
  Widget build(BuildContext context){
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 28, vertical: 60),
          child: Column(
            children: [
              Align(
              alignment: Alignment.centerLeft,
                child: Text(
              "Bantuan",
                style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                ),
                ),
              ),

              Align(
              alignment: Alignment.centerLeft,
                child: Text(
              "Isi formulir dibawah ini lalu hubungi admin untuk mengetahui akses akun anda!",
                style: TextStyle(
                fontSize: 16,
                ),
                ),
              ),


              Container(
                margin: EdgeInsets.only(top: 20),
               
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 18),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child : InputDecorator(
                          decoration: const InputDecoration(border: OutlineInputBorder(),contentPadding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 5)),
                          child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: keluhan,
                            //elevation: 5,
                            style: TextStyle(color: Colors.black),
                            items: pilihankeluhan.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            hint: Text(
                              "Pilih Bantuan",
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            onChanged: (String value) {
                              setState(() {
                                keluhan = value;
                              });
                            },
                          ),
                          ))
                        ),
                        TextFormField(
                          cursorColor: Colors.blue,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Username",
                          ),
                          validator: (usernameValue){
                            if(usernameValue.isEmpty){
                              return 'Please enter your username';
                            }
                            username = usernameValue;
                            return null;
                          }
                        ),
                        SizedBox(height: 12),
                        TextFormField(
                          cursorColor: Colors.blue,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Nama Lengkap",
                          ),
                          validator: (namaValue){
                            if(namaValue.isEmpty){
                              return 'Please enter your nama';
                            }
                            nama = namaValue;
                            return null;
                          }
                        ),
                        SizedBox(height: 42),
                        TextFormField(
                          cursorColor: Colors.blue,
                          keyboardType: TextInputType.text,
                          obscureText: _secureText,
                          decoration: InputDecoration(
                            hintText: "Password",
                            suffixIcon: IconButton(
                              onPressed: showHide,
                              icon: Icon(_secureText
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          ),
                          validator: (passwordValue){
                            if(passwordValue.isEmpty){
                              return 'Please enter your password';
                            }
                            password = passwordValue;
                            return null;
                          }
                        ),
                        SizedBox(height: 42),
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: FlatButton(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                            child: Text(
                              'Hubungi Admin',
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
                              borderRadius:
                              new BorderRadius.circular(8.0)),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              butuhBantuan();
                            }
                          },
                        ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              
            ],
          ),
        ),
      ),
    );
  }

  void butuhBantuan() async {
    String phone = "6282257661154";
    String pesan = "Hallo Admin saya butuh bantuan \n" + 
    keluhan +"\n"+
    "Username : " + username +"\n"+
    "Nama Lengkap : " +nama +"\n"+
    "Password : " + password
    ; 
    String url() {
      if (Platform.isAndroid) {
        // add the [https]
        return "https://wa.me/$phone/?text=" + pesan; 
      } else {
        // add the [https]
        return "https://api.whatsapp.com/send?phone=$phone=" +
            pesan; 
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

}
