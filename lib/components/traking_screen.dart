import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'constants.dart';

class TrackingPage extends StatefulWidget {
  const TrackingPage({Key? key}) : super(key: key);

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng sourceLocation = LatLng(37.33500925, -122.03272188);
  static const LatLng destination = LatLng(37.333429383, -122.0660055);
  List<LatLng> polylineCoordinates = [];

  void getPolyPointsbetweenSAndD() async {
    print(
        "object1==============================================================================================");
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      google_api_key,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );
    print(
        "object1===================================$result===========================================================");

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng points) =>
          polylineCoordinates.add(LatLng(points.latitude, points.longitude)));
      setState(() {});
      print(
          "object1===================================${result.points}===========================================================");
    }
  }

  @override
  void initState() {
    getPolyPointsbetweenSAndD();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
            child: Text(
          'Order Tracking',
          style: TextStyle(color: Colors.black54),
        )),
      ),
      body: GoogleMap(
        initialCameraPosition:
            CameraPosition(target: sourceLocation, zoom: 11.5),
        polylines: {
          Polyline(
              polylineId: PolylineId("route"),
              points: polylineCoordinates,
              color: primaryColor),
        },
        markers: {
          Marker(markerId: MarkerId("Source"), position: sourceLocation),
          Marker(markerId: MarkerId("Destination"), position: destination)
        },
      ),
    );
  }
}
