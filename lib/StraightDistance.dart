import 'dart:math';

double calculateDistance(String start, String end) {
  const earthRadius = 6371; // km

  final startLatLon =
      start.split(',').map((coord) => double.parse(coord)).toList();
  final endLatLon = end.split(',').map((coord) => double.parse(coord)).toList();

  final latDistance = toRadians(endLatLon[0] - startLatLon[0]);
  final lonDistance = toRadians(endLatLon[1] - startLatLon[1]);
  final a = pow(sin(latDistance / 2), 2) +
      (cos(toRadians(startLatLon[0])) *
          cos(toRadians(endLatLon[0])) *
          pow(sin(lonDistance / 2), 2));
  final c = 2 * atan2(sqrt(a), sqrt(1 - a));
  final distance = earthRadius * c;

  return distance;
}

double toRadians(double degree) {
  return degree * pi / 180;
}
