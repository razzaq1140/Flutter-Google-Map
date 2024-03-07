import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeoLocator extends StatefulWidget {
  const GeoLocator({super.key});

  @override
  State<GeoLocator> createState() => _GeoLocatorState();
}

class _GeoLocatorState extends State<GeoLocator> {
  static Completer _completer = Completer();
  CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(29.3544, 71.6911),
    zoom: 12,
  );

  // List<Marker> _marker = [];
  List<Marker> _marker = [
    Marker(
        markerId: MarkerId("1"),
        position: LatLng(29.3544, 71.6911),
        infoWindow: InfoWindow(
          title: "My location",
        )),
  ];

  Future<Position> getusercurrentLocation() async {
    await Geolocator.requestPermission().then((value){}).onError((error, stackTrace){
      print("Error "+ error.toString());
    });
    return Geolocator.getCurrentPosition();
  }

  // @override
  // void initState() {
  //   _marker.addAll(list);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _cameraPosition,
        markers: Set<Marker>.of(_marker),
        onMapCreated: (GoogleMapController controller) {
          _completer.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_on_outlined),
        onPressed: () async {
          // getusercurrentLocation().then((value) async {
          //   print(value.latitude.toString() + " " + value.longitude.toString());
          //
          //   _marker.add(Marker(
          //     markerId: MarkerId("2"),
          //     position: LatLng(value.latitude, value.longitude),
          //     infoWindow: InfoWindow(
          //       title: "My Current location",
          //     ),
          //   ));
          //   CameraPosition cameraPosition = CameraPosition(
          //       target: LatLng(value.latitude, value.longitude), zoom: 12);
          //   GoogleMapController _controller = await _completer.future;
          //   _controller
          //       .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
          //   setState(() {});
          // });
          getusercurrentLocation().then((value) async{
            _marker.add(
                Marker(markerId: MarkerId("2"),
                    position: LatLng(value.latitude , value.longitude),
                    infoWindow: InfoWindow(
                        title: "My current location"
                    )
                ),
            );
            GoogleMapController controller = await _completer.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(value.latitude,value.longitude))));
          });
        },
      ),
    );
  }
}
