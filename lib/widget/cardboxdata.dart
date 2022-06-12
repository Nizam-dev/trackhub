import 'package:flutter/material.dart';
import 'package:trackhub/widget/maincolor.dart';

class CardboxData extends StatelessWidget {
  String kode;
  String nama;
  String tgl_lahir;
  String no_telp;
  String alamat;
  String asal_sekolah;
  Widget tombol;
  CardboxData({this.tombol,this.kode,this.nama,this.alamat,this.no_telp,this.tgl_lahir,this.asal_sekolah});
  
  @override
  Widget build(BuildContext context){
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  tileColor: Maincolor.PrimaryColor,
                  title: Text('${kode}',style: TextStyle(color: Colors.white)),
                ),
                SizedBox(height: 15),
                Row(
                  children:[
                    Expanded(
                      flex:50,
                      child: Container(
                        padding: EdgeInsets.only(left: 5),
                        child: Text('${nama}',style: TextStyle(color: Maincolor.PrimaryColor,
                        fontSize: 15
                        )),
                          ),
                        ),
                    Expanded(
                      flex:50,
                      child: Container(
                        padding: EdgeInsets.only(right: 5),
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
                        padding: EdgeInsets.only(left: 5),
                        child: Text('${alamat}',style: TextStyle(color: Maincolor.PrimaryColor,
                        fontSize: 15
                        )),
                          ),
                        ),
                    Expanded(
                      flex:50,
                      child: Container(
                        padding: EdgeInsets.only(right: 5),
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
                SizedBox(height: 10),
                tombol,
                SizedBox(height: 10)

              ],
            ));
  }
}