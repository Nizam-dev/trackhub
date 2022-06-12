
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trackhub/network/api.dart';
import 'package:trackhub/widget/cardboxdata.dart';
import 'package:trackhub/widget/maincolor.dart';

class PendataanData extends StatefulWidget {
  var data;
  String angkutan_id;
  PendataanData({
    this.data,
    this.angkutan_id
  });
  @override
  _PendataanDataState createState() => _PendataanDataState();
}

class _PendataanDataState extends State<PendataanData> {
  var data;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    data = widget.data;
    super.initState();
  }

_showMsg(msg) {
    final snackBar = SnackBar(
      backgroundColor: Colors.green,
      content: Text(msg),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
            title:  Text(
                "Pendataan Penumpang",
                style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
        ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top: 25, left: 15,right: 15),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              for (var penumpang in data) ...[
                  CardboxData(
                  nama: penumpang["nama"],
                  alamat: penumpang["alamat"],
                  no_telp: penumpang["no_telp"],
                  tgl_lahir: penumpang["tgl_lahir"],
                  asal_sekolah: penumpang["asal_sekolah"],
                  kode: penumpang["qrcode"],
                  tombol: SizedBox(
                    width: 100,
                    height: 35,
                    child: RaisedButton(
                          child: Text("Absen"),
                          onPressed: (){
                            absenSiswa(penumpang["id"].toString(),penumpang["nama"].toString());
                          },
                          color: Maincolor.PrimaryColor,
                          textColor: Colors.white,
                          padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
                          splashColor: Colors.grey,
                        ),
                  ),
                  ),
              ]
            ]
          )
        )
      ),
    );
  }

  void absenSiswa(String id, String nama) async{
    var data = {
      'angkutan_id' : widget.angkutan_id,
      'id' : id
    };
    var res = await Network().auth(data, '/absen-penumpang');
    var body = json.decode(res.body);
    if(body['pesan'] == "sukses"){
      print("sukses");
      _showMsg("Penumpang $nama Berhasil Absen");
    }else{
      _showMsg("Penumpang $nama Gagal Absen");
    }
  }


}