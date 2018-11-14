import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

void main() => runApp(new MaterialApp(home: new MyApp(),));

class MyApp extends StatefulWidget{
  @override
  _State createState() => new _State();
}

class _State extends State<MyApp>{

  MapController mapController;
  Map<String, LatLng> coords;
  List<Marker> markers;

  @override
  void initState() {
    // TODO: implement initState
    mapController = new MapController();

    coords = new Map<String, LatLng>();

    coords.putIfAbsent("Lima", () => new LatLng(-12.052056, -77.045738));
    coords.putIfAbsent("Trujillo", () => new LatLng(-8.106723, -79.028543));
    coords.putIfAbsent("Arequipa", () => new LatLng(-16.403237, -71.537232));

    markers = new List<Marker>();

    for(int i = 0; i < coords.length; i++){
      markers.add(
          new Marker(
              width: 80.0,
              height: 80.0,
              point: coords.values.elementAt(i),
              builder: (ctx) => new Icon(Icons.pin_drop, color: Colors.red,)
          )
      );
    }
  }

  void _mostrarCoordenadas(int index){
    mapController.move(coords.values.elementAt(index), 10.0);
  }

  List<Widget> _crearBotones(){
    List<Widget> list = new List<Widget>();

    for(int i = 0; i < coords.length; i++){
      list.add(new RaisedButton(onPressed: ()=>_mostrarCoordenadas(i), child: new Text(coords.keys.elementAt(i)),));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Mapas"),
        backgroundColor: Colors.blueGrey,
      ),
      body: new Container(
        padding: new EdgeInsets.all(0.0),
        child: Center(
          child: Column(
            children: <Widget>[
              new Row(
                children: _crearBotones(),
              ),
              new Flexible(
                child: new FlutterMap(
                  options: new MapOptions(
                      center: new LatLng(-12.052056, -77.045738),
                      zoom: 10.0
                  ),
                  mapController: mapController,
                  layers: [
                    new TileLayerOptions(
                      urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a','b','c'],
                    ),
                    new MarkerLayerOptions(markers: markers)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}