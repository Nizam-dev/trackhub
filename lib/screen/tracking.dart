import 'dart:async';
import 'dart:convert';

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
  String user_id, angkutan_id;
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
        user_id = user['id'].toString();
        angkutan_id = user['angkutan_id'].toString();
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
      print("Jarak e : " + distanceInMeters.toString());
      _updatetracking(
          la_akhir: l.latitude.toString(), lo_akhir: l.longitude.toString());

      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 18)),
      );
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
        width: 160,
        height: 100,
        padding: EdgeInsets.symmetric(vertical: 20),
        child: FlatButton(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
            child: Row(
              children: [
                Switch(
            value: trackingActive,
            onChanged: (value) {
              setState(() {
                trackingActive = value;
                if(trackingActive == false){
                  
                }
              });
            },
            activeTrackColor: Colors.lightGreenAccent,
            activeColor: Colors.green,
          ),
                Text('dada',
              textDirection: TextDirection.ltr,
              style: TextStyle(
                color: Colors.black,
                fontSize: 10.0,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal,
              ),
            ),
              ],
            )
          ),
          color: Colors.purple,
          disabledColor: Colors.grey,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10)),
        ),
      ),
    );
  }

  Widget mapOffline() {
    return Container(
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
    );
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
