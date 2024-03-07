import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class First extends StatefulWidget {
  const First({super.key});

  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {
  static final CameraPosition _cameraPosition =
  CameraPosition(target: LatLng(21.4241, 39.8173), zoom: 14);

  static final Completer _contorller = Completer();

  List<Marker> _marker = [];
  List<Marker> _list = [
    Marker(
        markerId: MarkerId("1"),
        position: LatLng(21.4241, 39.8173),
        infoWindow: InfoWindow(
          title: "My current location",
        )),
    Marker(
        markerId: MarkerId("2"),
        position: LatLng(29.5069, 70.8536),
        infoWindow: InfoWindow(
          title: "My city",
        )
    ),
  ];

  @override
  void initState() {
    // super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: _cameraPosition,
              mapType: MapType.normal,
              onMapCreated: (GoogleMapController controller) {
                _contorller.complete(controller);
              },
              markers: Set<Marker>.of(_marker),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_on_outlined),
        onPressed: () async {
          GoogleMapController controller = await _contorller.future;
          controller.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(target: LatLng(29.5069, 70.8536),zoom: 14)
              ));
          setState(() {

          });
        },
      ),
    );
  }
}
