import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocation extends StatefulWidget {
  const CurrentLocation({super.key});

  @override
  State<CurrentLocation> createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {

  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex =
  CameraPosition(target: LatLng(29.3544, 71.6911), zoom: 14.4746);

  List<Marker> _marker = [
    Marker(
        markerId: MarkerId("1"),
        infoWindow:InfoWindow(
      title: "My location"
    )),
  ];

  Future<Position> getuserLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print("error" + error.toString());
    });

    return await Geolocator.getCurrentPosition();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        mapType: MapType.hybrid,
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
          getuserLocation().then((value) async {
            print("MY hostal location");
            print(value.latitude.toString() + " " + value.longitude.toString());
            _marker.add(
              Marker(
                  markerId: MarkerId("4"),
                  position: LatLng(value.latitude, value.longitude),
                  infoWindow: InfoWindow(
                    title: "My Currnet location",
                  )),
            );
            CameraPosition cameraPosition = CameraPosition(
                zoom: 14,
                target: LatLng(value.latitude, value.longitude));
            final GoogleMapController controller = await _controller.future;
            controller.animateCamera(
              CameraUpdate.newCameraPosition(
                  cameraPosition
              ),
            );
          });

          setState(() {});
        },
      ),
    );
  }
}
