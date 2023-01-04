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
  GoogleMapController? myController;
  // final Completer<GoogleMapController> _controller = Completer();
  // static const LatLng sourceLocation = LatLng(37.33500925, -122.03272188);
  // static const LatLng destination = LatLng(37.333429383, -122.0660055);

  CameraPosition position =
      const CameraPosition(target: LatLng(23.81129, 90.422783), zoom: 6);
  final Set<Marker> markers = Set();
  final Set<Polyline> polylines = Set();
  List latLongList = [
    {"lat": "23.81206110396834", "long": "90.42234273263065"},
    {"lat": "23.812105608772733", "long": "90.42292209380655"},
    {"lat": "23.81204916837568", "long": "90.42324664109576"},
    {"lat": "23.812222777839313", "long": "90.42401442651439"},
    {"lat": "23.812314185208137", "long": "90.42432153938812"},
  ];
  // List<LatLng> polylineCoordinates = [];

  // void getPolyPointsbetweenSAndD() async {
  //   print(
  //       "object1==============================================================================================");
  //   PolylinePoints polylinePoints = PolylinePoints();
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //     google_api_key,
  //     PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
  //     PointLatLng(destination.latitude, destination.longitude),
  //   );
  //   print(
  //       "object1===================================${result.errorMessage}===========================================================");
  //
  //   if (result.points.isNotEmpty) {
  //     result.points.forEach((PointLatLng points) =>
  //         polylineCoordinates.add(LatLng(points.latitude, points.longitude)));
  //     setState(() {});
  //     print(
  //         "object1===================================${result.errorMessage}===========================================================");
  //   }
  // }

  @override
  void initState() {
    // getPolyPointsbetweenSAndD();
    super.initState();
    initMap();
  }

  void initMap() async {
    // membs = await Members().populate(widget.tm.teamCode!);
    double avgLat = 0;
    double avgLong = 0;
    for (var mem in latLongList) {
      LatLng newLatLng = LatLng(
        double.parse(mem["lat"]),
        double.parse(mem["long"]),
      );

      //
      //
      //
      avgLat += newLatLng.latitude;
      avgLong += newLatLng.longitude;

      Marker mark = Marker(
        markerId: MarkerId("Delivery Woman-1"),
        position: newLatLng,
        infoWindow: InfoWindow(
          title: "Tahmina Bristy",
          snippet: 'Activity: ${mem["lat"]} ${mem["long"]} ',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
      );
      //print(mark);
      markers.add(mark);
      // Polyline polyline =
      //     Polyline(polylineId: PolylineId('1'), points: {newLatLng});
      // polylines.add(polyline);

      setState(() {});
    }

    // for (var mem in length1) {
    //   print(mem.name);
    //
    //   LatLng cpos = LatLng(
    //     double.parse(mem.latestActivity.lat),
    //     double.parse(mem.latestActivity.long),
    //   );
    //   avgLat += cpos.latitude;
    //   avgLong += cpos.longitude;
    //
    //   Marker mark = Marker(
    //     markerId: MarkerId(mem.mobile),
    //     position: cpos,
    //     infoWindow: InfoWindow(
    //       title: mem.name,
    //       snippet: 'Activity: ${mem.latestActivity.activityType}',
    //     ),
    //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
    //   );
    //   //print(mark);
    //   markers.add(mark);
    // }
    avgLat = (avgLat / latLongList.length);
    avgLong = (avgLong / latLongList.length);
    position = CameraPosition(
      target: LatLng(avgLat, avgLong),
      zoom: 14.5,
    );
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
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: position,
          markers: markers,
          polylines: polylines,

          onMapCreated: (controller) {
            myController = controller;
            setState(() {});
          },

          // polylines: {
          //   // Polyline(
          //   //     polylineId: PolylineId("route"),
          //   //     points: polylineCoordinates,
          //   //     color: primaryColor),
          // },
        ),
      ),
    );
  }
}
