
import 'package:flutter/material.dart';
import 'package:trackhub/widget/cardboxdata.dart';

class PendataanData extends StatefulWidget {
  var data;
  PendataanData(data){
    this.data = data;
  }
  @override
  _PendataanDataState createState() => _PendataanDataState();
}

class _PendataanDataState extends State<PendataanData> {
  var data;
  @override
  void initState() {
    data = widget.data;
    print(data);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  ),
              ]
            ]
          )
        )
      ),
    );
  }
}