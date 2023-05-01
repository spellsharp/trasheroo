import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MapScreenWidget extends StatefulWidget {
  final markerPoint;
  MapScreenWidget({Key? key, this.markerPoint}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MapState();
}

class _MapState extends State<MapScreenWidget> {
  late MapController controller;
  GeoPoint? userLocation;

  double longitude = 0.0;
  double latitude = 0.0;

  @override
  void initState() {
    super.initState();
    controller = MapController(
      initMapWithUserPosition: true,
    );
    List<String> coordinates = widget.markerPoint.split(",");
    longitude = double.parse(coordinates[0]);
    latitude = double.parse(coordinates[1]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            const Text(
              'Map',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'NTR',
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
            ),
          ],
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        ),
        toolbarHeight: 73,
      ),
      body: Center(
        child: OSMFlutter(
          onMapIsReady: (bool value) async {
            if (value) {
              Future.delayed(const Duration(seconds: 1), () async {
                await controller.currentLocation();

                // Create a custom marker at the specified longitude and latitude
                final customMarker = await controller.addMarker(
                  GeoPoint(latitude: latitude, longitude: longitude),
                  markerIcon: MarkerIcon(
                    icon: Icon(
                      Icons.delete,
                      color: Color.fromARGB(255, 20, 44, 0),
                      size: 48,
                    ),
                  ),
                  angle: pi / 3,
                );
              });
            }
          },
          controller: controller,
          trackMyPosition: true,
          initZoom: 16,
          minZoomLevel: 6,
          maxZoomLevel: 19,
          stepZoom: 1.0,
          userLocationMarker: UserLocationMaker(
            personMarker: MarkerIcon(
              icon: Icon(
                Icons.location_history_rounded,
                color: Colors.red,
                size: 48,
              ),
            ),
            directionArrowMarker: MarkerIcon(
              icon: Icon(
                Icons.double_arrow,
                size: 48,
              ),
            ),
          ),
          markerOption: MarkerOption(
            defaultMarker: MarkerIcon(
              icon: Icon(
                Icons.person_pin_circle,
                color: Colors.blue,
                size: 56,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
