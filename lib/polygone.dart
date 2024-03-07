import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class Polygone extends StatefulWidget {
  const Polygone({super.key});

  @override
  State<Polygone> createState() => _PolygoneState();
}

class _PolygoneState extends State<Polygone> {

  CameraPosition _cameraPosition = CameraPosition(
      target: LatLng(29.3544, 71.6911),
    zoom: 14,
  );
  Completer<GoogleMapController> _controller = Completer();

  Set<Polygon> _polygone = HashSet<Polygon>();

  List<LatLng> _position = [
    LatLng(29.3544, 71.6911),
    LatLng(29.1459, 71.2518),
    LatLng(29.2367, 71.0676),
    LatLng(29.3817, 70.9131),
    LatLng(29.5069, 70.8536),
    LatLng(29.3544, 71.6911),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _polygone.add(
        Polygon(
          polygonId: PolygonId("1"),
          points: _position,
          fillColor: Colors.red.withOpacity(0.2),
          strokeWidth: 4,
          strokeColor: Colors.deepOrange,
          geodesic: true,

        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
                initialCameraPosition: _cameraPosition,
              onMapCreated: (GoogleMapController controller){
                _controller.complete(controller);
              },
            polygons: _polygone,
            ),
          ),
        ],
      ),
    );
  }
}
