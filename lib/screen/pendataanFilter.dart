import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trackhub/network/api.dart';
import 'package:trackhub/screen/pendataanData.dart';
import 'package:trackhub/widget/maincolor.dart';
import 'package:intl/intl.dart';

class PendataanFilter extends StatefulWidget {
  String id;
  PendataanFilter(this.id);
  @override
  _PendataanFilterState createState() => _PendataanFilterState();
}

class _PendataanFilterState extends State<PendataanFilter> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  var nama, tgllahir;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _secureText = true;
  TextEditingController dateinput = TextEditingController();

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  _showMsg(msg) {
    final snackBar = SnackBar(
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 28, vertical: 30),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Absen Penumpang",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Pastikan data yang anda masukkan sudak benar!",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 18),
                        TextFormField(
                            cursorColor: Colors.blue,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 1.0, horizontal: 5),
                              hintText: "Nama",
                            ),
                            validator: (namaValue) {
                              if (namaValue.isEmpty) {
                                return 'Please enter your Nama';
                              }
                              nama = namaValue;
                              return null;
                            }),
                        SizedBox(height: 12),
                        TextFormField(
                          controller: dateinput,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 1.0, horizontal: 5),
                              icon: Icon(Icons.calendar_today),
                              labelText: "Tanggal Lahir"),
                          readOnly: true,
                          validator: (tgllahirValue) {
                            if (tgllahirValue.isEmpty) {
                              return 'Please enter your tgllahir';
                            }
                            tgllahir = tgllahirValue;
                            return null;
                          },
                          onTap: () async {
                            DateTime pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1990),
                                lastDate: DateTime(2025));
                            if (pickedDate != null) {
                              String formattedDate =
                                  // DateFormat('dd-MM-yyyy').format(pickedDate);
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                              setState(() {
                                dateinput.text = formattedDate;
                                tgllahir = formattedDate;
                              });
                            }
                          },
                        ),
                        SizedBox(height: 42),
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: FlatButton(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 10),
                              child: Text(
                                _isLoading ? 'Mencari Data..' : 'Lanjut',
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
                                borderRadius: new BorderRadius.circular(8.0)),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _filterdata();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _filterdata() async {
    setState(() {
      _isLoading = true;
    });
     var inputFormat = DateFormat('dd-MM-yyyy');
var inputDate = inputFormat.parse(tgllahir); // <-- dd/MM 24H format

var outputFormat = DateFormat('yyyy-MM-dd');
var tgl_lahir = outputFormat.format(inputDate);
    var data = {'nama': nama, 'tgl_lahir': tgl_lahir};
    print(tgl_lahir);

    var res = await Network().auth(data, '/daftar-penumpang');
    var body = json.decode(res.body);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                PendataanData(data: body["data"], angkutan_id: widget.id)));

    setState(() {
      _isLoading = false;
    });
  }
}
