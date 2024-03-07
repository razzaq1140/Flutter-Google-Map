import 'package:flutter/material.dart';
import 'package:google_map/covert_latlang_to_address.dart';
import 'package:google_map/current_location.dart';
import 'package:google_map/custom_windowinfo.dart';
import 'package:google_map/custome_marker.dart';
import 'package:google_map/google_place_api.dart';
import 'package:google_map/home.dart';
import 'package:google_map/network_image_marker.dart';
import 'package:google_map/polygone.dart';
import 'package:google_map/polyline.dart';
import 'package:google_map/practices/custom.dart';
import 'package:google_map/practices/first.dart';
import 'package:google_map/practices/geolocator.dart';
import 'package:google_map/style_google_map_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  StyleGoogleMap(),
      // home:  CustomeMarker(),
    );
  }
}

