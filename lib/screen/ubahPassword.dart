import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackhub/network/api.dart';
import 'package:trackhub/widget/maincolor.dart';

class UbahPassword extends StatefulWidget {

  @override
  _UbahPasswordState createState() => _UbahPasswordState();
}

class _UbahPasswordState extends State<UbahPassword> {
   bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  var confirmpassword, password;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _secureText = true;
  int iduser;

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
        iduser = user['id'];
      });
    }
  }

  


  showHide(){
    setState(() {
      _secureText = !_secureText;
    });
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
      appBar: AppBar(
          iconTheme: IconThemeData(
              color: Colors.black,
            ),
            title:Text(
                "Profil",
                style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,  
            automaticallyImplyLeading: true,
        ),
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 28, vertical: 30),
          child: Column(
            children: [
              Align(
              alignment: Alignment.center,
                child: Text(
              "Ubah Password",
                style: TextStyle(
                fontSize: 21,
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
                        Align(
                          alignment: Alignment.centerLeft,
                          child :Text("Password Baru"),
                        ),
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
                        SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerLeft,
                          child :Text("Konfirmasi Password Baru"),
                        ),
                        TextFormField(
                          cursorColor: Colors.blue,
                          keyboardType: TextInputType.text,
                          obscureText: _secureText,
                          decoration: InputDecoration(
                            hintText: "Konfirmasi Password",
                            suffixIcon: IconButton(
                              onPressed: showHide,
                              icon: Icon(_secureText
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          ),
                          validator: (confirmpasswordValue){
                            if(confirmpasswordValue.isEmpty){
                              return 'Please enter confirm password';
                            }
                            if(password != confirmpasswordValue){
                              return "Password tidak sama";
                            }
                            confirmpassword = confirmpasswordValue;
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
                              _ubahPassword();
                            }
                          },
                        ),
                        ),
                        SizedBox(height: 15,),
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: FlatButton(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                            child: Text('Batal',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                color: Maincolor.PrimaryColor,
                                fontSize: 18.0,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          color: Colors.black12,
                          disabledColor: Colors.grey,
                          shape: new RoundedRectangleBorder(
                              borderRadius:
                              new BorderRadius.circular(8.0)),
                          onPressed: () {
                           
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

  void _ubahPassword() async{
    setState(() {
      _isLoading = true;
    });
    var data = {
      'id' : iduser,
      'password' : password
    };

    var res = await Network().auth(data, '/ubah-password');
    var body = json.decode(res.body);
    _showMsg(body['pesan']);
    
    setState(() {
      _isLoading = false;
    });
  }
}
