import 'package:flutter/material.dart';
import 'package:trackhub/widget/maincolor.dart';
import 'package:trackhub/screen/akun.dart';
import 'package:trackhub/screen/pendataan.dart';
import 'package:trackhub/screen/tracking.dart';
import 'package:trackhub/screen/riwayat.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LayoutUtama extends StatefulWidget {
  int index;
  LayoutUtama({this.index});
  @override
  _LayoutUtamaState createState() => _LayoutUtamaState();
}

class _LayoutUtamaState extends State<LayoutUtama> {
  int _selectedNavbar = 0;

  var listpage = <Widget>[
    Tracking(),
    Pendataan(),
    Riwayat(),
    Akun(),
  ];
  String role = '';

  @override
  void initState() {
    _loadUserData();
    super.initState();
    if (widget.index != null) {
      setState(() {
        _selectedNavbar = widget.index;
      });
    }
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user'));
    if (user != null) {
      setState(() {
        role = user['profesi'];
        if (user['profesi'] != "supir") {
          listpage.removeAt(0);
        }
      });
    }

    // if(user != null) {
    //   if(user['profesi'] == "supir"){
    //     setState(() {
    //       role = user['profesi'];
    //       listpage = <Widget>[
    //           Tracking(),
    //           Pendataan(),
    //           Riwayat(),
    //           Akun(),
    //         ];
    //     });
    //   }else{
    //     setState(() {
    //       role = user['profesi'];
    //       listpage = <Widget>[
    //           Pendataan(),
    //           Riwayat(),
    //           Akun(),
    //         ];
    //     });
    //   }
    // }
  }

  void _changeSelectedNavBar(int index) {
    setState(() {
      _selectedNavbar = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedNavbar,
        children: listpage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          if (role == "supir") ...[
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              title: Text('Tracking'),
            ),
          ],
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            title: Text('Pendataan'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_rounded),
            title: Text('Riwayat'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Akun'),
          ),
        ],
        currentIndex: _selectedNavbar,
        selectedItemColor: Maincolor.PrimaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: _changeSelectedNavBar,
      ),
    );
  }
}
