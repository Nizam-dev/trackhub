import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trackhub/network/api.dart';
import 'package:trackhub/widget/cardbox.dart';

class Riwayat extends StatefulWidget {
  @override
  _RiwayatState createState() => _RiwayatState();
}

class _RiwayatState extends State<Riwayat> {
  var data;
   @override
  void initState() {
    super.initState();
    this.getRiwayat();
  }
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
      body: RefreshIndicator(
      onRefresh: getRiwayat,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top: 25, left: 15,right: 15),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
                if(data != null)...[
                  for (var penumpang in data) ...[
                  Cardbox(
                    alamat: penumpang["alamat"],
                    asal_sekolah: penumpang["asal_sekolah"],
                    nama: penumpang["nama"],
                    no_telp: penumpang["no_telp"],
                    tgl_lahir: penumpang["tgl_lahir"],
                    tgl_input_penumpang : penumpang["tgl_input_penumpang"],
                    nama_angkutan: penumpang["nama_angkutan"],
                    nama_supir: penumpang["nama_supir"],
                    type_absen: penumpang["type_absen"],
                  ),
                ]
                ]
            ]
          )
        )
      ),
      ),
    );
  }

  Future getRiwayat() async{
    var res = await Network().getData("/list-riwayat-penumpang");
    var body = json.decode(res.body);
    setState(() {
      data = body["data"];
    });
  }

}