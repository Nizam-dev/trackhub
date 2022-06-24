import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trackhub/network/api.dart';
import 'package:trackhub/widget/cardboxdata.dart';
import 'package:trackhub/widget/maincolor.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class PendataanData extends StatefulWidget {
  var data;
  String angkutan_id;
  PendataanData({this.data, this.angkutan_id});
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
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          "Pendataan Penumpang",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: 25, left: 15, right: 15),
          child: SingleChildScrollView(
              child: Column(children: <Widget>[
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
                    onPressed: () {
                      absenSiswa(penumpang["id"].toString(),
                          penumpang["nama"].toString());
                    },
                    color: Maincolor.PrimaryColor,
                    textColor: Colors.white,
                    padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
                    splashColor: Colors.grey,
                  ),
                ),
              ),
            ]
          ]))),
    );
  }

  void absenSiswa(String id, String nama) async {
    var data = {'angkutan_id': widget.angkutan_id, 'id': id};
    var res = await Network().auth(data, '/absen-penumpang');
    var body = json.decode(res.body);
    if (body['pesan'] == "sukses") {
      modalDialog();
    } else {
      _showMsg("Penumpang $nama Gagal Absen");
    }
  }

  void modalDialog() {
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
                        "Absen Penumpang Berhasil",
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
                              'Absen Penumpang Lain',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          color: Colors.orange,
                          disabledColor: Colors.grey,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15)),
                          onPressed: () {
                            Navigator.of(context).pop();
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
                              'Menu Pendataan',
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
                            Navigator.of(context).pop();
                            DataAngkutan();
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
                              'Data Angkutan',
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
                            Navigator.of(context).pop();
                            menuPendataan();
                          }),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void DataAngkutan() {
    int count = 0;
    Navigator.of(context).popUntil((_) => count++ >= 2);
  }

  void menuPendataan() {
    return Navigator.of(context).pop();
  }
}
