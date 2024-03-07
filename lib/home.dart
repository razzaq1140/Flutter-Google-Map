import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScree extends StatefulWidget {
  const HomeScree({super.key});

  @override
  State<HomeScree> createState() => _HomeScreeState();
}

class _HomeScreeState extends State<HomeScree> {

  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(29.3544, 71.6911), zoom: 14.4746);

  final List<Marker> _marker = [];
  final List<Marker> _list = [
    const Marker (
      markerId: MarkerId("1"),
      position: LatLng(29.3544, 71.6911),
      infoWindow: InfoWindow(
        title: "My hostel location",
      ),
    ),
    const Marker(
        markerId: MarkerId("2"),
        position: LatLng(31.5204, 74.3587),
        infoWindow: InfoWindow(
          title: "My Lahore",
        )),
    const Marker(
        markerId: MarkerId("3"),
        position: LatLng(33.6844, 73.0479),
        infoWindow: InfoWindow(
          title: "My Islamabad",
        )),
    const Marker(
        markerId: MarkerId("4"),
        position: LatLng(29.5069, 70.8536),
        infoWindow: InfoWindow(title: "My Ali pur")),
  ];

  @override
  void initState() {
    super.initState();
    _marker.addAll(_list);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        mapType: MapType.normal,
        myLocationEnabled: true,
        compassEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(_marker),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(CupertinoIcons.location),
        onPressed: () async {

          GoogleMapController controller = await _controller.future;
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              const CameraPosition(
                target: LatLng(29.5069, 70.8536),
                zoom: 14,
              ),
            ),
          );

          setState(() {});
        },
      ),
    );
  }
}



