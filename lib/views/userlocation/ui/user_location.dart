import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart' as geo;

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shoptoken/widgets/text_style.dart';

class UserLocation extends StatefulWidget {
  @override
  _UserLocationState createState() => _UserLocationState();
}

class _UserLocationState extends State<UserLocation> {
  Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};

  double zoomlevel = 11.0;

  LatLng pinPosition = LatLng(24.7136, 46.6753);

  geo.Position _lastKnownPosition;
  geo.Position _currentPosition;

  Map<String, double> userLocation;

  String _useraddress = 'Select your location..';

  @override
  void initState() {
    super.initState();

    setCustomMapPin();
    _initLastKnownLocation();
    _initCurrentLocation();
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);

    setState(() {
      _lastKnownPosition = null;
      _currentPosition = null;
    });

    _initLastKnownLocation().then((_) => _initCurrentLocation());
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/marker_1.png');
  }

// Platform messages are asynchronous, so we initialize in an async method.
  Future<void> _initLastKnownLocation() async {
    geo.Position position;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final geo.Geolocator geolocator = geo.Geolocator()
        ..forceAndroidLocationManager = true;
      position = await geolocator.getLastKnownPosition(
          desiredAccuracy: geo.LocationAccuracy.best);
    } on PlatformException {
      position = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return;
    }

    setState(() {
      _lastKnownPosition = position;
      getAddressFromLalLong(
          _lastKnownPosition.latitude, _lastKnownPosition.longitude);
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  _initCurrentLocation() {
    geo.Geolocator()
      ..forceAndroidLocationManager = true
      ..getCurrentPosition(
        desiredAccuracy: geo.LocationAccuracy.medium,
      ).then((position) {
        if (mounted) {
          setState(() {
            _currentPosition = position;
            getAddressFromLalLong(
                _currentPosition.latitude, _currentPosition.longitude);
            print(_currentPosition.longitude);
          });
        }
      }).catchError((e) {
        //
      });
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);

    setState(() {
      addMarker();
    });
  }

  void addMarker() {
    _markers.clear();
    _markers.add(Marker(
        markerId: MarkerId('marker_2'),
        draggable: true,
        position: pinPosition,
        infoWindow: InfoWindow(title: 'Title'),
        icon: pinLocationIcon,
        onDragEnd: ((value) {
          setState(() {
            getAddressFromLalLong(value.latitude, value.longitude);
          });
        })));
  }

  Future<void> getAddressFromLalLong(double latitude, double longitude) async {
    List<geo.Placemark> placemark =
        await geo.Geolocator().placemarkFromCoordinates(latitude, longitude);

    setState(() {
      animateCamera(latitude, longitude);

      pinPosition = LatLng(latitude, longitude);

      _useraddress = placemark[0].name +
          ' ,' +
          placemark[0].subAdministrativeArea +
          '  ' +
          placemark[0].administrativeArea +
          ' ,' +
          placemark[0].country;
    });
  }

  Future<void> animateCamera(double latitude, double longitude) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: pinPosition, zoom: zoomlevel),
      ),
    );
  }

  void _onGeoChanged(CameraPosition position) {
    zoomlevel = position.zoom;
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition _myLocation = CameraPosition(
      target: pinPosition,
      zoom: zoomlevel,
    );

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('User location'),
      ),
      body: FutureBuilder<geo.GeolocationStatus>(
          future: geo.Geolocator().checkGeolocationPermissionStatus(),
          builder: (BuildContext context,
              AsyncSnapshot<geo.GeolocationStatus> snapshot) {
            print('FutureBuilder has data -- ${snapshot.hasData}');

            if (snapshot.hasData) {
              print('FutureBuilder data -- ${snapshot.data}');
              if (snapshot.data == geo.GeolocationStatus.denied) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('Access to location denied',
                          style: const TextStyle(
                              fontSize: 32.0, color: Colors.black54),
                          textAlign: TextAlign.center),
                      Text(
                          'Allow access to the location services for this App using the device settings.',
                          style: const TextStyle(
                              fontSize: 16.0, color: Colors.black54),
                          textAlign: TextAlign.center),
                    ],
                  ),
                );
              }

              return Stack(
                children: [
                  GoogleMap(
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: _myLocation,
                    markers: _markers,
                    onCameraMove: _onGeoChanged,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 10, bottom: 10),
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.brown, width: 2)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            margin: const EdgeInsets.only(right: 10.0),
                            child: new Icon(Icons.add_location)),
                        Flexible(
                          child: new Text(
                            _useraddress,
                            style: getTextStyle()
                                .copyWith(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    ));
  }
}
