import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

class NetworkImageMarker extends StatefulWidget {
  const NetworkImageMarker({super.key});

  @override
  State<NetworkImageMarker> createState() => _NetworkImageMarkerState();
}

class _NetworkImageMarkerState extends State<NetworkImageMarker> {

  final CameraPosition _cameraPosition = const CameraPosition(
    target: LatLng(29.3544, 71.6911),
    zoom: 14,
  );
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _marker = {};
  
  final List<LatLng> point = [
    const LatLng(29.3544, 71.6911),
    const LatLng(29.1459, 71.2518),
    const LatLng(29.2367, 71.0676)
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async{
    for(int i=0; i<point.length; i++){
      Uint8List? image = await loadNetworkImage("https://www.iconfinder.com/search?q=location&price=free");
      final ui.Codec markerImageCodec = await ui.instantiateImageCodec(
          image!.buffer.asUint8List(),
        targetHeight: 100,
        targetWidth: 100,
      );

      final ui.FrameInfo frameInfo = await markerImageCodec.getNextFrame();
      final ByteData? byteData = await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List resizedImageMarked = byteData!.buffer.asUint8List();

      _marker.add(
        Marker(
            markerId: MarkerId(i.toString()),
            position: point[i],
            icon: BitmapDescriptor.fromBytes(resizedImageMarked),
            infoWindow: const InfoWindow(
              title: "This is title",
            )
        ),
      );
      setState(() {

      });
    }
  }

  Future<Uint8List?> loadNetworkImage(String path) async{
  final completer = Completer<ImageInfo>();
  var image = NetworkImage(path);

  image.resolve(
      const ImageConfiguration())
      .addListener(ImageStreamListener((info,_)=>completer.complete(info)));

  final imageInfo = await completer.future;
  final byteData = await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);
  return byteData!.buffer.asUint8List();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          Expanded(child: GoogleMap(
            initialCameraPosition: _cameraPosition,
            markers: Set<Marker>.of(_marker),
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
            },
          ))
        ],
      ),
    );
  }
}
