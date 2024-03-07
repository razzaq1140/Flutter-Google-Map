import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class GooglePlace extends StatefulWidget {
  const GooglePlace({super.key});

  @override
  State<GooglePlace> createState() => _GooglePlaceState();
}

class _GooglePlaceState extends State<GooglePlace> {

  final TextEditingController _controller = TextEditingController();

  var uuid = Uuid();
  String _sessionToken = "122344";
  List<dynamic> _playList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      onChange();
    });
  }

  onChange() {
    if(_sessionToken == null){
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
      getSuggestion(_controller.text);
  }

  getSuggestion(String input) async{
    String kPlaces_Api = "AIzaSyCICMJRt-pqrMXohC84WQOfAvF8gmnEC2o";
    String baseURL ='https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$input&key=$kPlaces_Api&sessiontoken=$_sessionToken';

    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();

    print("data");
    print(data);

    if(response.statusCode == 200){
      setState(() {
        _playList = jsonDecode(response.body.toString())['predictions'];
      });
    }
    else
      {
        throw Exception("Failed the load data");
      }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Search Place Api"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextFormField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: "Search place with name",
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: _playList.length,
                  itemBuilder: (context,index){
                    return ListTile(
                      title: Text(_playList[index]["description"]),
                    );
          }))
        ],
      ),
    );
  }
}
