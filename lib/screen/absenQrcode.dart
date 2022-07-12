import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:trackhub/network/api.dart';
import 'dart:convert';
import 'package:trackhub/widget/maincolor.dart';

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
      setState((){
        if(body['pesan'] == "sukses"){
          qrText =   "Data $codeQr Ditemukan";
          var dataPenumpang = body['data'][0];
          modalDialog(dataPenumpang["nama"].toString());
          // dataku = body["data"];
          // ditemukan = true;
        }else{
          qrText =   "Data $codeQr Tidak Ditemukan";
      controller.resumeCamera();

        }
      });
      
    });
  }

  void modalDialog(String NamaQr) {
    String NamaPenumpang = NamaQr;
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
                        "Absen Penumpang $NamaPenumpang Berhasil",
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
                              'Absen Lagi',
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
                          controller.resumeCamera();

                          }),
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
                              'Tutup',
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

  void menuPendataan() {
    return Navigator.of(context).pop();
  }


}