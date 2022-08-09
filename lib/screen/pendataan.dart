import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:trackhub/layouts/layoututama.dart';
import 'package:trackhub/screen/absenQrcode.dart';
import 'package:trackhub/screen/pendataanFilter.dart';
import 'package:trackhub/screen/riwayat.dart';
import 'package:trackhub/widget/maincolor.dart';
import 'package:trackhub/network/api.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Pendataan extends StatefulWidget {
  Pendataan({Key key}) : super(key: key);

  @override
  _PendataanState createState() => _PendataanState();
}

class _PendataanState extends State<Pendataan> {
  String _chosenValueTrayek;
  String _chosenValueSopir;
  var id = <String>[];
  var idSupir,role;
  var pilihantrayek = <String>[];
  var sopir = <String>[];
  var no_polisi = <String>[];
  var pilihansopir = <String>[];
  var pilihannopolisi = <String>[];
  int _pilihan;
  final TextEditingController _nopolcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var username;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List data;
  void initState() {
    super.initState();
    _loadUserData();
    this.getData();
  }

    _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user'));

    if (user != null) {
      setState(() {
        idSupir= user['id'];
        role = user['profesi'];
      });
    }
  }

  Future<String> getData() async {
    var res = await Network().getData('/list-angkutan');
    setState(() {
      var content = json.decode(res.body);
      if (content["pesan"] == "sukses") {
        data = content['angkutan'];
        for (var item in data) {
          pilihantrayek.add(item["nama_angkutan"]);
          sopir.add(item["nama"]);
          no_polisi.add(item["no_polisi"]);
          id.add(item["id_angkutan"].toString());
        }
      }
    });
    return 'success!';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "Pendataan Penumpang",
              style: TextStyle(color: Colors.black),
            ),
          ),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          padding: EdgeInsets.only(top: 25, left: 15, right: 15),
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: role == "supir"? supirWidget() : petugasWidget(),
          ),
        ));
  }

   Widget supirWidget(){
      return SizedBox(
              height: 300,
              child: Center(
                  child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Text("Pilih Menu Pendataan"),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        child: Text("Absen Penumpang"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PendataanFilter(idSupir.toString())));
                        },
                        color: Maincolor.PrimaryColor,
                        textColor: Colors.white,
                        padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
                        splashColor: Colors.grey,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15)),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        child: Text("Scan QR Code"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AbsenQrcode(idSupir.toString())));
                        },
                        color: Maincolor.PrimaryColor,
                        textColor: Colors.white,
                        padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
                        splashColor: Colors.grey,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15)),
                      ),
                    ),
                  ],
                ),
              )));
   }

  Widget petugasWidget(){
    return Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Data Angkutan",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Masukan data angkutan terlebih dahulu.",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Pastikan data yang dimasukkan sudah benar.",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Trayek Angkutan",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: InputDecorator(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 1.0, horizontal: 5)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _chosenValueTrayek,
                            //elevation: 5,
                            style: TextStyle(color: Colors.black),
                            items: pilihantrayek
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            hint: Text(
                              "Pilih Trayek",
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            onChanged: (String value) {
                              setState(() {
                                _pilihan = pilihantrayek.indexOf(value);
                                _chosenValueTrayek = value;
                                // pilihansopir = <String>[sopir[_pilihan]];
                                // _chosenValueSopir = sopir[_pilihan];
                                pilihannopolisi = <String>[no_polisi[_pilihan]];
                                _chosenValueSopir = no_polisi[_pilihan];
                                _nopolcontroller.text = _chosenValueSopir;
                              });
                            },
                          ),
                        ))),
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: Text(
                //     "Nama Sopir",
                //     style: TextStyle(fontSize: 15),
                //   ),
                // ),
                // Container(
                //     margin: EdgeInsets.symmetric(vertical: 10),
                //     child: InputDecorator(
                //         decoration: const InputDecoration(
                //             border: OutlineInputBorder(),
                //             contentPadding: const EdgeInsets.symmetric(
                //                 vertical: 1.0, horizontal: 5)),
                //         child: DropdownButtonHideUnderline(
                //           child: DropdownButton<String>(
                //             value: _chosenValueSopir,
                //             //elevation: 5,
                //             style: TextStyle(color: Colors.black),
                //             items: pilihannopolisi
                //                 .map<DropdownMenuItem<String>>((String value) {
                //               return DropdownMenuItem<String>(
                //                 value: value,
                //                 child: Text(value),
                //               );
                //             }).toList(),
                //             hint: Text(
                //               "No Polisi",
                //               style: TextStyle(
                //                   color: Colors.black38,
                //                   fontSize: 16,
                //                   fontWeight: FontWeight.w600),
                //             ),
                //             onChanged: (String value) {
                //               setState(() {
                //                 _chosenValueSopir = value;
                //               });
                //             },
                //           ),
                //         ))),
                Container(
                  margin: EdgeInsets.only(top: 0),
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 18),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "No. Polisi",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          TextFormField(
                              enabled: false,
                              cursorColor: Colors.blue,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: "",
                                border: OutlineInputBorder(),

                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 1.0, horizontal: 5),
                              ),
                              controller: _nopolcontroller,
                              validator: (nopolisi) {

                                return null;
                              }),
                          SizedBox(height: 12),

                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: FlatButton(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                        child: Text(
                          'Lanjutkan',
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
                        _chosenValueTrayek == null
                            ? Fluttertoast.showToast(
                                msg: "Harap pilih Trayek!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0)
                            : pilihMenuPendataan();
                      }),
                ),
              ],
            );
  }

  pilihMenuPendataan() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          // <-- SEE HERE
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (context) {
          return SizedBox(
              height: 300,
              child: Center(
                  child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Text("Pilih Menu Pendataan"),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        child: Text("Absen Penumpang"),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PendataanFilter(id[_pilihan])));
                        },
                        color: Maincolor.PrimaryColor,
                        textColor: Colors.white,
                        padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
                        splashColor: Colors.grey,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15)),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        child: Text("Scan QR Code"),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AbsenQrcode(id[_pilihan])));
                        },
                        color: Maincolor.PrimaryColor,
                        textColor: Colors.white,
                        padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
                        splashColor: Colors.grey,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15)),
                      ),
                    ),
                  ],
                ),
              )));
        });
  }
}
