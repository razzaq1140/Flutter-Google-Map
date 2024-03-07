import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomeWindowInfo extends StatefulWidget {
  const CustomeWindowInfo({super.key});

  @override
  State<CustomeWindowInfo> createState() => _CustomeWindowInfoState();
}

class _CustomeWindowInfoState extends State<CustomeWindowInfo> {

  CustomInfoWindowController customInfoWindowController = CustomInfoWindowController();

  List<Marker> _marker = [];
  List<LatLng> latlng = <LatLng>[
    LatLng(29.3544,71.6911),LatLng(24.8607,67.0011),LatLng(30.1575,71.5249)
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData(){
    for(int i=0; i<latlng.length; i++){
      if(i%2 == 0){
        _marker.add(Marker(markerId: MarkerId(i.toString()),
            icon: BitmapDescriptor.defaultMarker,
            position: latlng[i],
            onTap: (){
              customInfoWindowController.addInfoWindow!(
                Container(
                  height: 300,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100,
                        width: 300,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/animal.jpg"),
                            fit: BoxFit.fitWidth,
                            filterQuality: FilterQuality.high,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("The lion is a wild terrestrial animal called the king of the forest. The lion is a strong animal with a strong body, a big head, a majestic mane, and two fierce eyes."),
                      ),
                    ],
                  ),
                ),
                latlng[i],
              );

            }
        ));
      }
      else{
        _marker.add(Marker(markerId: MarkerId(i.toString()),
            icon: BitmapDescriptor.defaultMarker,
            position: latlng[i],
            onTap: (){
              customInfoWindowController.addInfoWindow!(
                Container(
                  height: 300,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100,
                        width: 300,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/Lion.jpg"),
                            fit: BoxFit.fitWidth,
                            filterQuality: FilterQuality.high,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("The lion is a wild terrestrial animal called the king of the forest. The lion is a strong animal with a strong body, a big head, a majestic mane, and two fierce eyes."),
                      ),
                    ],
                  ),
                ),
                latlng[i],
              );

            }
        ));
      }
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custome Window Info"),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GoogleMap(
              initialCameraPosition: CameraPosition(
            target: LatLng(29.3544,71.6911),
            zoom: 14,
          ),
          markers: Set<Marker>.of(_marker),
          onMapCreated: (GoogleMapController controller){
                customInfoWindowController.googleMapController = controller;
          },
            onTap: (position){
              customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position){
                customInfoWindowController.onCameraMove!();
            },
          ),
          CustomInfoWindow(
              controller: customInfoWindowController,
            height: 200,
            width: 300,
            offset: 35,
          ),
        ],
      ),
    );
  }
}
