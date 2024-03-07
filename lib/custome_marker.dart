import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';

class CustomeMarker extends StatefulWidget {
  const CustomeMarker({super.key});

  @override
  State<CustomeMarker> createState() => _CustomeMarkerState();
}

class _CustomeMarkerState extends State<CustomeMarker> {
  Uint8List? markerImage;
  final Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _cameraPosition =
  const CameraPosition(target: LatLng(29.3544, 71.6911), zoom: 14);

  List<String> images = ["assets/images/bicycle.png","assets/images/car.png","assets/images/map.png"];
  final List<LatLng> _latlng = <LatLng>[const LatLng(29.3544,71.6911),const LatLng(24.8607,67.0011),const LatLng(30.1575,71.5249)];

  List<Marker> marker = <Marker>[];


  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async{
    for(int i = 0; i<images.length; i++) {
      final Uint8List markerIcon = await getBytesFromAsset(images[i], 100);
      marker.add(
          Marker(
              markerId: MarkerId(i.toString()),
              position: _latlng[i],
              icon: BitmapDescriptor.fromBytes(markerIcon),
              infoWindow: InfoWindow(
                title: "This title is: "+i.toString(),
              )
          )
      );
    }
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async{
    // ByteData data = await rootBundle.load(path);
    // ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),targetHeight: width);
    // ui.FrameInfo fi = await codec.getNextFrame();
    // return(await fi.image.toByteData(format: ui.ImageByteFormat.png,))!.buffer.asUint8List();

    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return(await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: _cameraPosition,
              markers: Set<Marker>.of(marker),
              onMapCreated: (GoogleMapController controller){
                _controller.complete(controller);
              },

            ),
          ),
        ],
      ),
    );
  }
}
