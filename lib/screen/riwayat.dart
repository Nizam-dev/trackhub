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
          padding: EdgeInsets.only(top: 25, left: 15, right: 15),
          child: ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, i) {
                return Cardbox(
                  alamat: data[i]["alamat"],
                  asal_sekolah: data[i]["asal_sekolah"],
                  nama: data[i]["nama"],
                  no_telp: data[i]["no_telp"],
                  tgl_lahir: data[i]["tgl_lahir"],
                  tgl_input_penumpang: data[i]["created_at"],
                  nama_angkutan: data[i]["nama_angkutan"],
                  nama_supir: data[i]["nama_supir"],
                  type_absen: data[i]["type_absen"],
                );
              }),
        ),

        // child: Container(
        //   width: MediaQuery.of(context).size.width,
        //   padding: EdgeInsets.only(top: 25, left: 15,right: 15),
        //   child: SingleChildScrollView(
        //     child: Column(
        //       children: <Widget>[
        //           if(data != null)...[
        //             for (var penumpang in data) ...[
        //             Cardbox(
        //               alamat: penumpang["alamat"],
        //               asal_sekolah: penumpang["asal_sekolah"],
        //               nama: penumpang["nama"],
        //               no_telp: penumpang["no_telp"],
        //               tgl_lahir: penumpang["tgl_lahir"],
        //               tgl_input_penumpang : penumpang["created_at"],
        //               nama_angkutan: penumpang["nama_angkutan"],
        //               nama_supir: penumpang["nama_supir"],
        //               type_absen: penumpang["type_absen"],
        //             ),
        //           ]
        //           ]else...[
        //             Text("Tidak Ada Data"),
        //             SizedBox(height: 190)
        //           ]
        //       ]
        //     )
        //   )
        //   ),
      ),
    );
  }

  Future getRiwayat() async {
    var res = await Network().getData("/list-riwayat-penumpang");
    var body = json.decode(res.body);
    setState(() {
      data = body["data"];
    });
  }
}
