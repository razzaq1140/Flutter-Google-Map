import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolyLine extends StatefulWidget {
  const PolyLine({super.key});

  @override
  State<PolyLine> createState() => _PolyLineState();
}

class _PolyLineState extends State<PolyLine> {

  CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(29.3544, 71.6911),
    zoom: 14,
  );
  Completer<GoogleMapController> _controller = Completer();

  Set<Polyline> _polyLine = {};
  Set<Marker> _marker = {};
  List<LatLng> point = [
    LatLng(29.3544, 71.6911),
    LatLng(29.1459, 71.2518),
    LatLng(29.2367, 71.0676),
    LatLng(29.3817, 70.9131),
    LatLng(29.5069, 70.8536),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i = 0; i<point.length; i++){
      _marker.add(
        Marker(
            markerId: MarkerId(i.toString()),
          position: point[i],
          infoWindow: InfoWindow(
            title: "Really Cool Place",
            snippet: "5 Star Raiting"
          )
        )
      );
      _polyLine.add(
          Polyline(
            polylineId: PolylineId("1"),
            geodesic: true,
            points: point,
            color: Colors.deepOrange,
            width: 5,

          ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          Expanded(child: GoogleMap(
            initialCameraPosition: _cameraPosition,
            markers: _marker,
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
            },
            polylines: _polyLine,
          ))
        ],
      ),
    );
  }
}
