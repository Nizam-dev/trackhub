import 'package:flutter/material.dart';
import 'package:trackhub/widget/maincolor.dart';

class Cardbox extends StatelessWidget {
  String tgl_input_penumpang;
  String nama;
  String tgl_lahir;
  String no_telp;
  String alamat;
  String asal_sekolah;
  String nama_supir;
  String nama_angkutan;
  Cardbox({this.nama,this.alamat,this.no_telp,this.tgl_lahir,this.asal_sekolah,this.tgl_input_penumpang,this.nama_angkutan,this.nama_supir});


  @override
  Widget build(BuildContext context){
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                // ListTile(
                //   tileColor: Maincolor.PrimaryColor,
                //   title: Text('${tgl_input_penumpang}',style: TextStyle(color: Colors.white)),
                // ),
                Container(
                  height: 40,
                  color: Maincolor.PrimaryColor,
                  child: Row(
                  children:[
                    Expanded(
                      flex:50,
                      child: Container(
                        padding: EdgeInsets.only(left: 8),
                        child: Text('${tgl_input_penumpang}',style: TextStyle(color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500
                        )),
                          ),
                        ),
                    Expanded(
                      flex:50,
                      child: Container(
                        padding: EdgeInsets.only(right: 8),
                        alignment: Alignment.centerRight,
                        child: Text('Scan Qr',style: TextStyle(color: Colors.white,
                        fontSize: 15
                        )),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  children:[
                    Expanded(
                      flex:50,
                      child: Container(
                        padding: EdgeInsets.only(left: 8),
                        child: Text('${nama}',style: TextStyle(color: Maincolor.PrimaryColor,
                        fontSize: 15
                        )),
                          ),
                        ),
                    Expanded(
                      flex:50,
                      child: Container(
                        padding: EdgeInsets.only(right: 8),
                        alignment: Alignment.centerRight,
                        child: Text('${tgl_lahir}',style: TextStyle(color: Maincolor.PrimaryColor,
                        fontSize: 15
                        )),
                          ),
                        ),
                    ],
                  ),
                SizedBox(height: 8),
                
                Row(
                  children:[
                    Expanded(
                      flex:50,
                      child: Container(
                        padding: EdgeInsets.only(left: 8),
                        child: Text('${alamat}',style: TextStyle(color: Maincolor.PrimaryColor,
                        fontSize: 15
                        )),
                          ),
                        ),
                    Expanded(
                      flex:50,
                      child: Container(
                        padding: EdgeInsets.only(right: 8),
                        alignment: Alignment.centerRight,
                        child: Text('${no_telp}',style: TextStyle(color: Maincolor.PrimaryColor,
                        fontSize: 15
                        )),
                          ),
                        ),
                    ],
                  ),
                
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.center,
                  child: Text('${asal_sekolah}',style: TextStyle(color: Maincolor.PrimaryColor,
                  fontSize: 15
                  )),
                ),
                SizedBox(height: 15),

                Container(margin: EdgeInsets.only(bottom: 5),height: 1.4,color: Maincolor.PrimaryColor),
                Text('${nama_angkutan}',style: TextStyle(color: Maincolor.PrimaryColor)),
                Text('${nama_supir}',style: TextStyle(color: Maincolor.PrimaryColor)),

                SizedBox(height: 10)

              ],
            ));
  }
}