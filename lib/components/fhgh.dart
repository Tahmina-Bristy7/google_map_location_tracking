import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerScreeen extends StatefulWidget {
  const MarkerScreeen({super.key});

  @override
  State<MarkerScreeen> createState() => _MarkerScreeenState();
}

class _MarkerScreeenState extends State<MarkerScreeen> {
  GoogleMapController? myController;

  CameraPosition position = const CameraPosition(
    target: LatLng(23.811129, 90.422783),
    zoom: 6,
  );
  final Set<Marker> markers = Set();

  List latLongs = [
    {"lat": "23.81206110396834", "long": "90.42234273263065"},
    {"lat": "23.812105608772733", "long": "90.42292209380655"},
    {"lat": "23.81204916837568", "long": "90.42324664109576"},
    {"lat": "23.812222777839313", "long": "90.42401442651439"},
    {"lat": "23.812314185208137", "long": "90.42432153938812"},
  ];

  @override
  void initState() {
    super.initState();
    initMap();
  }

  void initMap() async {
    // membs = await Members().populate(widget.tm.teamCode!);
    double avgLat = 0;
    double avgLong = 0;
    for (var mem in latLongs) {
      LatLng cpos = LatLng(
        double.parse(mem["lat"]),
        double.parse(mem["long"]),
      );
      avgLat += cpos.latitude;
      avgLong += cpos.longitude;

      Marker mark = Marker(
        markerId: const MarkerId('01726621610'),
        position: cpos,
        infoWindow: InfoWindow(
          title: 'Tuhin',
          snippet: 'Activity: ${avgLat.toString()}${avgLong.toString()}',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
      );
      //print(mark);
      markers.add(mark);
      // print(markers);

    }

    avgLat = (avgLat / latLongs.length);
    avgLong = (avgLong / latLongs.length);

    position = CameraPosition(
      target: LatLng(avgLat, avgLong),
      zoom: 16,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffD7CB9F),
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              zoomControlsEnabled: false,
              initialCameraPosition: position,
              markers: markers,
              onMapCreated: (controller) {
                myController = controller;
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
