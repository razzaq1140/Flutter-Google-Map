import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StyleGoogleMap extends StatefulWidget {
  const StyleGoogleMap({super.key});

  @override
  State<StyleGoogleMap> createState() => _StyleGoogleMapState();
}

class _StyleGoogleMapState extends State<StyleGoogleMap> {

  String mapTheme = "";

  Completer<GoogleMapController> _contorller = Completer();
  Set<Marker> marker = {
    Marker(
      markerId: MarkerId("1"),
      position: LatLng(29.3544, 71.6911),
      infoWindow: InfoWindow(
        title: "This is a title",
      )
    )
  };

  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   DefaultAssetBundle.of(context).loadString("assets/maptheme/dark.json").then((value){
  //     mapTheme = value;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map Theme",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        actions: [
          PopupMenuButton(
            iconColor: Colors.white,
              itemBuilder: (context)=>[
              PopupMenuItem(
                onTap: (){
                _contorller.future.then((value){
                  DefaultAssetBundle.of(context).loadString("assets/maptheme/silver.json").then((string){
                    value.setMapStyle(string);
                  });
                });
                },
                  child: Text("Silver"),
              ),
                PopupMenuItem(
                  onTap: (){
                  _contorller.future.then((value) => {
                    DefaultAssetBundle.of(context).loadString("assets/maptheme/retro.json").then((string){
                     value.setMapStyle(string);
                    })
                  });
                  },
                  child: Text("Retro"),
                ),
                PopupMenuItem(
                  onTap: (){
                    _contorller.future.then((value){
                      DefaultAssetBundle.of(context).loadString("assets/maptheme/dark.json").then((string){
                        value.setMapStyle(string);
                      });
                    });
                  },
                  child: Text("Dark"),
                ),
                PopupMenuItem(
                  onTap: (){
                    _contorller.future.then((value){
                      DefaultAssetBundle.of(context).loadString("assets/maptheme/night.json").then((string){
                        value.setMapStyle(string);
                      });
                    });
                  },
                  child: Text("Night"),
                ),
                PopupMenuItem(
                  onTap: (){
                    _contorller.future.then((value){
                      DefaultAssetBundle.of(context).loadString("assets/maptheme/aubergine.json").then((string){
                        value.setMapStyle(string);
                      });
                    });
                  },
                  child: Text("Aubergine"),
                ),
              ]
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(29.3544, 71.6911),
              zoom: 14,
            ),
            onMapCreated: (GoogleMapController controller){
              controller.setMapStyle(mapTheme);
              _contorller.complete(controller);
            },
            markers: Set<Marker>.of(marker),

          ))
        ],
      ),
    );
  }
}
