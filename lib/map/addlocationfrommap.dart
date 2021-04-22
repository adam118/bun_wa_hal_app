import 'package:bun_wa_hal/style/styli.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

// ignore: camel_case_types
class addlocationfrommap extends StatefulWidget {
  @override
  _addlocationfrommapState createState() => _addlocationfrommapState();
}

Position position;
String pos;
GoogleMapController mapController;

// ignore: camel_case_types
class _addlocationfrommapState extends State<addlocationfrommap> {
  LatLng _initialcameraposition = LatLng(31.9539, 35.9106);
  GoogleMapController _controller;
  Location _location = Location();
  bool _gohint = false;

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    // _location.onLocationChanged.listen((l) {
    //   _controller.animateCamera(
    //     CameraUpdate.newCameraPosition(
    //       CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 15),
    //     ),
    //   );
    // });
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colora().green,
          onPressed: () {},
        ),
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: _initialcameraposition, zoom: 50),
              mapType: MapType.normal,
              onCameraMove: (CameraPosition position) {
                setState(() {
                  pos =
                      "${position.target.latitude}, ${position.target.longitude}";
                });
              },
              onMapCreated: _onMapCreated,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
            ),
            Positioned(
                top: 20,
                left: 200,
                child: Visibility(
                  visible: _gohint,
                  child: Tab(
                    icon: Icon(Icons.arrow_right_alt),
                    text: "انقر هنا لذهاب لموقعك الحالي",
                  ),
                )),
            Center(
              child: Icon(
                Icons.location_on,
                size: 30,
                color: Colora().green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
