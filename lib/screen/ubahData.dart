import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackhub/network/api.dart';
import 'package:trackhub/widget/maincolor.dart';

class UbahData extends StatefulWidget {

  @override
  _UbahDataState createState() => _UbahDataState();
}

class _UbahDataState extends State<UbahData> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  var username, nama, alamat, nomor_telepon, id;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _secureText = true;

  final TextEditingController _namacontroller = TextEditingController();
  final TextEditingController _alamatcontroller = TextEditingController();
  final TextEditingController _usernamecontroller = TextEditingController();
  final TextEditingController _nomor_teleponcontroller = TextEditingController();

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
        id = user['id'];
        _namacontroller.text = user['nama'];
        _alamatcontroller.text = user['alamat'];
        _usernamecontroller.text = user['username'];
        _nomor_teleponcontroller.text = user['notelp'];
      });
    }
  }


  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
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
              "Ubah Akun",
                style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
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
                        TextFormField(
                          cursorColor: Colors.blue,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Username",
                          ),
                          controller: _usernamecontroller,
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
                            hintText: "Nama",
                          ),
                          controller: _namacontroller,
                          validator: (namaValue){
                            if(namaValue.isEmpty){
                              return 'Please enter your nama';
                            }
                            nama = namaValue;
                            return null;
                          }
                        ),
                        SizedBox(height: 12),
                        TextFormField(
                          cursorColor: Colors.blue,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "alamat",
                          ),
                          controller: _alamatcontroller,
                          validator: (alamatValue){
                            if(alamatValue.isEmpty){
                              return 'Please enter your alamat';
                            }
                            alamat = alamatValue;
                            return null;
                          }
                        ),
                        SizedBox(height: 12),
                        TextFormField(
                          cursorColor: Colors.blue,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "no_telepon",
                          ),
                          controller: _nomor_teleponcontroller,
                          validator: (no_teleponValue){
                            if(no_teleponValue.isEmpty){
                              return 'Please enter your no_telepon';
                            }
                            nomor_telepon = no_teleponValue.toString();
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
                              _isLoading? 'Proccessing..' : 'Simpan',
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
                              _login();
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

  void _login() async{
    setState(() {
      _isLoading = true;
    });

     var data = {
      'id' : id,
      'nama' : nama,
      'username' : username,
      'notelp' : nomor_telepon.toString(),
      'alamat' : alamat
    };

    var res = await Network().auth(data, '/ubah-akun');
    var body = json.decode(res.body);
    if(body['pesan'] == "sukses"){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('user', json.encode(body['user']));
       _showMsg(body['pesan']);
    }else{
      _showMsg(body['pesan']);
    }

    setState(() {
      _isLoading = false;
    });
 
   
  }
}
