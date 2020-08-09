import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shoptoken/widgets/text_style.dart';

class UserLocation extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<UserLocation> {
  Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};

  LatLng pinPosition = LatLng(24.7241504, 46.2620616);

  var location = new Location();

  Map<String, double> userLocation;

  String _useraddress = 'Select your location..';

  @override
  void initState() {
    super.initState();
    setCustomMapPin();
  }

  Future<Map<String, double>> _getLocation() async {
    var currentLocation = <String, double>{};
    try {
      currentLocation = (await location.getLocation()) as Map<String, double>;
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/marker_1.png');
  }

  void _updatePosition(CameraPosition _position) {
    pinPosition = _position.target;
    CameraPosition newPos = CameraPosition(target: _position.target);
    Marker marker = _markers.first;
    setState(() {
      _markers.first.copyWith(positionParam: newPos.target);
      _useraddress = 'pos ${pinPosition.latitude} ${pinPosition.longitude}';
    });
    // setState(() {
    //   _useraddress =
    //       'updatePosition ${_position.target.latitude} ${_position.target.longitude}';
    // });
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);

    setState(() {
      _markers.add(Marker(
          markerId: MarkerId('marker_2'),
          draggable: true,
          position: pinPosition,
          infoWindow: InfoWindow(title: 'Title'),
          icon: pinLocationIcon));
    });
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition _myLocation = CameraPosition(
      target: pinPosition,
      zoom: 11,
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('User location'),
        ),
        body: Stack(
          children: [
            GoogleMap(
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onMapCreated: _onMapCreated,
              initialCameraPosition: _myLocation,
              markers: _markers,
              onCameraMove: _updatePosition,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(
                  left: 40.0, right: 40.0, top: 10, bottom: 10),
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.brown, width: 2)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.only(right: 10.0),
                      child: new Icon(Icons.add_location)),
                  new Text(
                    _useraddress,
                    style: getTextStyle().copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
