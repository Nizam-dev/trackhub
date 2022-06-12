import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:trackhub/network/api.dart';
import 'dart:convert';

import 'package:trackhub/widget/cardbox.dart';


class AbsenQrcode extends StatefulWidget {
  String id;
  AbsenQrcode(this.id);
  @override
  _AbsenQrcodeState createState() => _AbsenQrcodeState();
}

class _AbsenQrcodeState extends State<AbsenQrcode> {
   final GlobalKey qrKey= GlobalKey();
  QRViewController controller;
  String qrText='Scanning.....';
  bool ditemukan = false;
  var dataku;

  // @override
//  void initState(){
//    super.initState();
//    //FlutterMobileVision.start().then((x) => setState((){}));
//  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
         appBar: AppBar(
          iconTheme: IconThemeData(
              color: Colors.black,
            ),
            title:Text(
                "Absen Qr",
                style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,  
            automaticallyImplyLeading: true,
        ),
        body: Column(
          children: <Widget>[
            if(!ditemukan)...[
              Expanded(
              flex: 5,
              child: QRView(key: qrKey,
                  overlay: QrScannerOverlayShape(
                    borderRadius: 10,
                    borderColor: Colors.red,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: 300,
                  ) ,
                  onQRViewCreated: _onQRViewCreated,),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text('$qrText'
               ),
              ),
            ),
            ]else...[
              Align(
                alignment: Alignment.center,
                child : Column(
                  children: <Widget>[
                    if(dataku != null)...[
                      for (var penumpang in dataku) ...[
                      Cardbox(
                        alamat: penumpang["alamat"],
                        asal_sekolah: penumpang["asal_sekolah"],
                        nama: penumpang["nama"],
                        no_telp: penumpang["no_telp"],
                        tgl_lahir: penumpang["tgl_lahir"],
                        tgl_input_penumpang : penumpang["tgl_input_penumpang"],
                        nama_angkutan: "",
                        nama_supir: "",
                      ),
                    ]
                    ]
                  ],
                )
              )
            ],
            
          ],
        ),
    );
  }
  @override

  void dispose(){
    controller?.dispose();
    super.dispose();
  }
  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller=controller;
    });
    
    controller.scannedDataStream.listen((Barcode scanData) async {
      controller.pauseCamera();
      String codeQr = scanData.code;
      var data = {
      'angkutan_id' : widget.id,
      'qrcode_penumpang' : codeQr
    };
    var res = await Network().auth(data, '/scan-penumpang');
    var body = json.decode(res.body);
    print(body);
      setState((){
        if(body['pesan'] == "sukses"){
          qrText =   "Data $codeQr Ditemukan";
          dataku = body["data"];
          ditemukan = true;
        }else{
          qrText =   "Data $codeQr Tidak Ditemukan";
        }
      });
      controller.resumeCamera();
      
    });
  }

}