import 'dart:convert';
import 'package:http/http.dart' as http;

Future<double> getRouteDistance(String startPoint, String endPoint) async {
  final apiKey = '5b3ce3597851110001cf6248d151f39e03c644f7a2b76f1a962dbdd1';
  final url =
      'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$apiKey&start=$startPoint&end=$endPoint';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final jsonResult = json.decode(response.body);
    final distance =
        jsonResult['features'][0]['properties']['segments'][0]['distance'];
    return distance / 1000.0; // Convert distance from meters to kilometers
  } else {
    throw Exception('Failed to load route data');
  }
}
