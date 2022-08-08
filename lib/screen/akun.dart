import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackhub/network/api.dart';
import 'dart:convert';
import 'package:trackhub/screen/home.dart';
import 'package:trackhub/screen/splashscreen.dart';
import 'package:trackhub/screen/tentang.dart';
import 'package:trackhub/screen/ubahData.dart';
import 'package:trackhub/screen/ubahPassword.dart';
import 'package:trackhub/widget/maincolor.dart';


class Akun extends StatefulWidget {
  @override
  _AkunState createState() => _AkunState();
}

class _AkunState extends State<Akun> {
  String nama = '';
  String nama_angkutan = '';
  String alamat = '';
  String noTelp = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user'));

    if (user != null) {
      setState(() {
        nama = user['nama'];
        nama_angkutan = user['profesi'] == "supir" ? user['nama_angkutan']:'Petugas Terminal';
        alamat = user['alamat'];
        noTelp = user['notelp'];
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
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(vertical: 25),
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset("assets/images/logo.png", width: 90),
                )),
            Text(
              "${nama}",
              style: TextStyle(fontSize: 32),
            ),
            SizedBox(height: 2),
             Text(
              "${nama_angkutan}",
              style: TextStyle(fontSize: 21),
            ),
            SizedBox(height: 10),
            Text(
              "${alamat}",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            Text(
              "${noTelp}",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),

            SizedBox(height: 15),


            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: FlatButton(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                    child: Text(
                      ' Ubah Data Akun',
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
                      MaterialPageRoute(builder: (context) => UbahData()),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: FlatButton(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                    child: Text(
                      ' Ubah Password',
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
                      MaterialPageRoute(builder: (context) => UbahPassword()),
                    );
                  },
                ),
              ),
            ),

Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: FlatButton(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                    child: Text(
                      'Tentang Aplikasi',
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
                      MaterialPageRoute(builder: (context) => Tentang()),
                    );
                  },
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: FlatButton(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                    child: Text(
                      'Keluar',
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  color: Colors.red,
                  disabledColor: Colors.grey,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15)),
                  onPressed: () {
                    confirm_logout();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void confirm_logout(){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      child: Text(
                        "Apakah Anda Akan Keluar?",
                        style: TextStyle(
                            color: Maincolor.PrimaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: FlatButton(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 18, vertical: 5),
                            child: Text(
                              'Keluar',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          color: Colors.red,
                          disabledColor: Colors.grey,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15)),
                          onPressed: () {
                            Navigator.of(context).pop();
                            logout();
                          }),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: FlatButton(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 18, vertical: 5),
                            child: Text(
                              'Batal',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          color: Colors.grey,
                          disabledColor: Colors.grey,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ),
                    
                   
                  ],
                ),
              ),
            ),
          );
        });
  }

  void logout() async {
    // var res = await Network().getData('/logout');
    // var body = json.decode(res.body);
    // if(body['success']){
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('user');
    localStorage.remove('token');
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home()));

    // }
  }
}




