import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackhub/network/api.dart';
import 'dart:convert';
import 'package:trackhub/screen/masuk.dart';
import 'package:trackhub/screen/splashscreen.dart';

class Akun extends StatefulWidget {
  @override
  _AkunState createState() => _AkunState();
}

class _AkunState extends State<Akun> {

  String nama='';

  @override
  void initState(){
    super.initState();
    _loadUserData();
  }

  _loadUserData() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user'));

    if(user != null) {
      setState(() {
        nama = user['nama'];
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            title: Center(
              child: Text(
                "Akun",
                style: TextStyle(color: Colors.black),
            ),
            ),
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
        ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child:  Column(
          children: <Widget>[
            Text("Hello ${nama}"),
            SizedBox(height: 40),
            SizedBox(
                width: double.infinity,
                child: RaisedButton(
                      child: Text("Keluar"),
                      onPressed: (){
                        logout();
                      },
                      color: Colors.redAccent,
                      textColor: Colors.white,
                      padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
                      splashColor: Colors.grey,
                    ),
              ),

          ],
        ),
      ),
    );
  }

void logout() async{
    // var res = await Network().getData('/logout');
    // var body = json.decode(res.body);
    // if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context)=>Masuk()));
          
    // }
  }


}