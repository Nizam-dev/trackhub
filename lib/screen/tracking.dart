import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Tracking extends StatefulWidget {
  @override
  _TrackingState createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> {

  GoogleMapController mapController;
  Location location = new Location();
  LatLng _initialPosition = LatLng(37.42796133588664, -122.885740655967);
  void _onMapCreated(GoogleMapController _cntrl) async {
  mapController = await _cntrl;
  location.onLocationChanged.listen((l)  {
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(l.latitude, l.longitude),zoom: 18)),
  );}); }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
      children: <Widget>[
      GoogleMap(
        initialCameraPosition: CameraPosition(target: _initialPosition, zoom: 10),
        mapType: MapType.normal,
        onMapCreated: _onMapCreated,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: false,
        )
      ],
    ),
    );
  }

  
}