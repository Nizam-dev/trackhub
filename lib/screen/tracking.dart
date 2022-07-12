import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackhub/network/api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:trackhub/widget/maincolor.dart';

class Tracking extends StatefulWidget {
  @override
  _TrackingState createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> {
  String user_id,
      angkutan_id,
      nama,
      nama_angkutan,
      lokasi_berangkat,
      lokasi_tiba;
  double la_awal, lo_awal;
  bool mulai = true;
  bool trackingActive = false;
  double distanceInMeters;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user'));

    if (user != null) {
      setState(() {
        nama = user['nama'].toString();
        user_id = user['id'].toString();
        angkutan_id = user['angkutan_id'].toString();
        nama_angkutan = user['nama_angkutan'].toString();
        lokasi_berangkat = user['lokasi_berangkat'].toString();
        lokasi_tiba = user['lokasi_tiba'].toString();
      });
    }
  }

  GoogleMapController mapController;
  Location location = new Location();
  LatLng _initialPosition = LatLng(-8.4844281, 114.3280922);
  void _onMapCreated(GoogleMapController _cntrl) async {
    mapController = await _cntrl;
    location.onLocationChanged.listen((l) {
      if (mulai) {
        la_awal = l.latitude;
        lo_awal = l.longitude;
        mulai = false;
      }
      distanceInMeters = _geolocatorPlatform.distanceBetween(
          la_awal, lo_awal, l.latitude, l.longitude);

      if (trackingActive) {
        print("Jarak e : " + distanceInMeters.toString());

        _updatetracking(
            la_akhir: l.latitude.toString(), lo_akhir: l.longitude.toString());
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(CameraPosition(
              target: LatLng(l.latitude, l.longitude), zoom: 18)),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          if (trackingActive) ...[mapOnline()] else ...[mapOffline()]
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: Container(
        width: 200,
        height: 117,
        padding: EdgeInsets.symmetric(vertical: 20),
        child: FlatButton(
          child: Padding(
              padding: EdgeInsets.only(left: 5, right: 5, top: 3),
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        flex: 70,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "$nama_angkutan",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 30,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.location_on,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 60,
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              children: [
                                Text(
                                  "$lokasi_berangkat",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ),
                                Text("$lokasi_tiba",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white)),
                              ],
                            )),
                      ),
                      Flexible(
                        flex: 40,
                        child: Switch(
                          value: trackingActive,
                          onChanged: (value) {
                            setState(() {
                              trackingActive = value;
                              if (trackingActive == false) {}
                            });
                          },
                          activeTrackColor: Colors.lightGreenAccent,
                          activeColor: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              )),
          color: Colors.purple,
          disabledColor: Color.fromARGB(200, 67, 29, 102),
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10)),
        ),
      ),
    );
  }

  Widget mapOffline() {
    return Stack(children: <Widget>[
      new Positioned(
          left: 0,
          top: 90.0,
          child: new Container(
            width: 150.0,
            height: 50.0,
            decoration: new BoxDecoration(
              color: Colors.white,
              boxShadow: [new BoxShadow(blurRadius: 1.0,offset: Offset(1.0, 1),)],
              borderRadius: new BorderRadius.only(
                topRight: const Radius.circular(30.0),
                bottomRight: const Radius.circular(30.0),
              ),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Selamat Datang",
                    style: TextStyle(color: Maincolor.PrimaryColor,fontSize: 14),
                  ),
                ), Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "$nama",
                    style: TextStyle(color: Maincolor.PrimaryColor,fontSize: 16,fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          )),
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 155),
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset("assets/images/angkutan.png", width: 290),
                )),
            Text(
              "Hidupkan GPS untuk memulai tracking lokasi perjalanan trayek!",
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      )
    ]);
  }

  Widget mapOnline() {
    return GoogleMap(
      initialCameraPosition: CameraPosition(target: _initialPosition, zoom: 10),
      mapType: MapType.normal,
      onMapCreated: _onMapCreated,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      zoomControlsEnabled: false,
    );
  }

  void _updatetracking({String la_akhir, String lo_akhir}) async {
    var data = {
      'angkutan_id': angkutan_id,
      'user_id': user_id,
      'latitude_tracking_awal': la_awal,
      'latitude_tracking_akhir': la_akhir,
      'longitude_tracking_awal': lo_awal,
      'longitude_tracking_akhir': lo_akhir
    };

    var res = await Network().auth(data, '/tracking');
    var body = json.decode(res.body);
    if (body['pesan'] == "sukses") {
    } else {}
  }
}
