import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackhub/network/api.dart';
import 'dart:convert';
import 'package:trackhub/screen/home.dart';
import 'package:trackhub/screen/splashscreen.dart';
import 'package:trackhub/screen/ubahPassword.dart';
import 'package:trackhub/widget/maincolor.dart';

class Akun extends StatefulWidget {
  @override
  _AkunState createState() => _AkunState();
}

class _AkunState extends State<Akun> {

  String nama='';
  String alamat='';

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
        alamat = user['alamat'];
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            title: Center(
              child: Text(
                "Profil",
                style: TextStyle(color: Colors.black),
            ),
            ),
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
        ),
      body: Container(
        child:  Column(
          children: <Widget>[
          Padding(padding: EdgeInsets.symmetric(vertical: 25),
          child: Align(
            alignment: Alignment.center,
            child: Image.asset("assets/images/logo.png", width: 120),
            )
          ),

          Text("${nama}",
            style: TextStyle(
              fontSize: 35
            ),
          ),

          SizedBox(height: 10),
          Text("${alamat}",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey
            ),
          ),

          Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 25),
          child:  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: RaisedButton(
                          child: Text("Ubah Data Akun"),
                          onPressed: (){
                            
                          },
                          color: Maincolor.PrimaryColor,
                          textColor: Colors.white,
                          padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
                          splashColor: Colors.grey,
                        ),
                  ),

          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 25),
          child:  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: RaisedButton(
                          child: Text("Ubah Password"),
                          onPressed: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UbahPassword()
                                ),
                            );
                          },
                          color: Maincolor.PrimaryColor,
                          textColor: Colors.white,
                          padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
                          splashColor: Colors.grey,
                        ),
                  ),

          ),

          Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 25),
          child:  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: RaisedButton(
                          child: Text("Keluar"),
                          onPressed: (){
                            logout();
                          },
                          color: Colors.red,
                          textColor: Colors.white,
                          padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
                          splashColor: Colors.grey,
                        ),
                  ),

          )

          


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
          MaterialPageRoute(builder: (context)=>Home()));
          
    // }
  }


}