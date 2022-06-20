import 'dart:convert'as convert;
import 'dart:convert';
import 'package:destination/consts/app_const.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;

class LocationRepository {

  Future<Map<String, dynamic>> getDirection( String origin, String destination)async{
    final String url = '${AppConst.baseURLDirections}?origin=$origin&destination=$destination&key=${AppConst.googleMapApiKey}';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    print('destination =$json');
    var result = {
      'bounds_ne':json['routes'][0]['bounds']['northeast'],
      'bounds_sw':json['routes'][0]['bounds']['southwest'],
      'distance':json['routes'][0]['legs'][0]['distance'],
      'duration':json['routes'][0]['legs'][0]['duration'],
      'start_location':json['routes'][0]['legs'][0]['start_location'],
      'end_location':json['routes'][0]['legs'][0]['end_location'],
      'polyline':json['routes'][0]['overview_polyline']['points'],
      'polyline_decoded':PolylinePoints()
          .decodePolyline(json['routes'][0]['overview_polyline']['points']),
    };

    print('destination =$result');
    return result;
  }

  Future<List> getAutoCompletedLocation(String input, String sessionToken)async{
    var placeList = <dynamic>[];
    String request = '${AppConst.baseURLAutoComplete}?input=$input&key=${AppConst.googleMapApiKey}&sessiontoken=$sessionToken';
    var response = await http.get(Uri.parse(request));
    print('autoCompleted = ${response.body}');
    if (response.statusCode == 200) {
     placeList =  jsonDecode(response.body.toString())['predictions'];
    } else {
      throw Exception('Fail to load data');
    }
    return placeList;
  }

}
