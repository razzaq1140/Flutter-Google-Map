import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';


class CovertLatLangToAddress extends StatefulWidget {
  const CovertLatLangToAddress({super.key});

  @override
  State<CovertLatLangToAddress> createState() => _CovertLatLangToAddressState();
}

class _CovertLatLangToAddressState extends State<CovertLatLangToAddress> {

  String stAdress = '', stAdd = " ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Map",style: TextStyle(fontSize: 25,color: Colors.white),),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Text(stAdress),
          Text(stAdd),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () async{
                List<Location> locations = await locationFromAddress("Multan");
                List<Placemark> placemarks = await placemarkFromCoordinates(29.5069, 70.8536);


                setState(() {
                  stAdress = locations.last.latitude.toString() + " " + locations.last.longitude.toString();
                  stAdd = placemarks.last.country.toString() + " " + placemarks.last.locality.toString() ;
                });
              },
              child: Container(
                child: Center(child: Text("Covert",style: TextStyle(fontSize: 20),)),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.green
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
