import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MapScreenWidget extends StatefulWidget {
  MapScreenWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MapState();
}

class _MapState extends State<MapScreenWidget> {
  late MapController controller;

  @override
  void initState() {
    super.initState();
    controller = MapController(
      initMapWithUserPosition: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: OSMFlutter(
        onMapIsReady: (bool value) async {
          if (value) {
            Future.delayed(const Duration(seconds: 1), () async {
              await controller.currentLocation();
            });
          }
        },
        controller: controller,
        onLocationChanged: (GeoPoint point) {
          print('lat: ${point.latitude}, lon: ${point.longitude}');
        },
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
        )),
      ),
    ));
  }
}
