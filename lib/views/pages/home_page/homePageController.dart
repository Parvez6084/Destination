import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:destination/model/history_model.dart';
import 'package:destination/services/location_repository.dart';
import 'package:destination/views/widgets/row_widget.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;
import 'package:destination/consts/app_const.dart';
import 'package:destination/consts/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

class HomePageController extends GetxController {
  var currentLat = 0.0.obs;
  var currentLon = 0.0.obs;
  var destinationLatLon = const LatLng(0.0, 0.0).obs;

  final sessionToken = '12345'.obs;
  var marker = <Marker>[].obs;
  var polyline = <Polyline>[].obs;
  var placeList = <dynamic>[].obs;

  var isEditTextEnable = false.obs;

  var uuid = Uuid();
  var searchController = TextEditingController();

  Set<Polyline> polylineDir = Set<Polyline>();
  int polylineIdCounter = 1;



  final Completer<GoogleMapController> mapController = Completer();
  final CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(23.6850, 90.3563),
    zoom: 8,
  );


  @override
  void onInit() async {
    super.onInit();
    loadCurrentLocation();
    searchController.addListener(() {
     // onChangeDestination();
      });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void loadCurrentLocation() async {
    await getCurrentLocation().then((value) async {
      currentLat.value = value.latitude;
      currentLon.value = value.longitude;
      print('my location = ${value.latitude}, ${value.longitude}');
      var cameraPosition = CameraPosition(
          zoom: 15, target: LatLng(value.latitude, value.longitude));

      final GoogleMapController control = await mapController.future;
      control.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      //If  Directions API Work then comment out setCameraWithBounds
      //   setCameraWithBounds(control, boundsNe, boundsSw);
    });

    setPinMarker();
  }

  void setCameraWithBounds(
      Map<String, dynamic> boundsNe,
      Map<String, dynamic> boundsSw) async{

    final GoogleMapController control = await mapController.future;
    control.animateCamera(
      CameraUpdate.newLatLngBounds(
          LatLngBounds(
              southwest: LatLng(boundsSw['lat'], boundsSw['lng']),
              northeast: LatLng(boundsNe['lat'], boundsNe['lng'])),
          25),
    );
  }

  void setPinMarker() async {
    final Uint8List markerIcon = await getBytesFromAsset(AppImages.pin, 100);
    var list = <Marker>[
      Marker(
          icon: BitmapDescriptor.fromBytes(markerIcon),
          markerId: const MarkerId('1'),
          position: LatLng(currentLat.value, currentLon.value),
          infoWindow: const InfoWindow(title: 'Current Place')),
    ];
    marker.addAll(list);
  }

  Future<Position> getCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print('error$error');
    });
    return await Geolocator.getCurrentPosition();
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void addDestinationMarker(LatLng position) async {
    destinationLatLon.value = LatLng(position.latitude, position.longitude);
    if (marker.isNotEmpty) {
      var list = <Marker>[Marker(
            markerId: const MarkerId('2'),
            position: position,
            infoWindow: const InfoWindow(title: 'Destination'))];
      marker.addAll(list);

      var poly = <Polyline>[Polyline(
            polylineId: const PolylineId('polyline_12'),
            color: Colors.blueAccent,
            width: 3,
            points: [
              LatLng(currentLat.value, currentLon.value),
              destinationLatLon.value
            ])];

      polyline.addAll(poly);

      //  if  Directions API will worked
      /* var directions = await LocationRepository().getDirection('CurrentLocation', 'DestinationLocation');
       setCameraWithBounds(directions['bounds_ne'], directions['bounds_sw']);
       var distance = directions['distance'];
       var duration = directions['duration'];
       setPolylineDirections(directions['polyline_decoded']);*/
    }
  }

  void onChangeDestination() {
    if (sessionToken.value.isEmpty) {
      sessionToken.value = uuid.v4();
    } else {
      LocationRepository()
          .getAutoCompletedLocation(searchController.text, sessionToken.value);
    }
  }

  void setPolylineDirections(List<PointLatLng> points) {
    final String polylineIdVal = 'polyline_$polylineIdCounter';
    polylineIdCounter++;
    polylineDir.add(
      Polyline(
        polylineId: PolylineId(polylineIdVal),
        color: Colors.blueAccent,
        width: 3,
        points: points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList(),
      ),
    );
  }

  TableRow buildRowHeader(List<String>cells)=>TableRow(
    children: cells.map((value) {
      return Padding(
        padding: const EdgeInsets.all(4),
        child:  Text(value, style: const TextStyle(color: Colors.white),),
      );

    } ).toList()
  );

  final historyList = <HistoryModel>[].obs;
  TableRow buildRow(List<String>cells)=>TableRow(
    children: cells.map((value) {
      return Padding(
        padding: const EdgeInsets.all(4),
        child:  Text(value, style: const TextStyle(color: Colors.white30),),
      );

    } ).toList()
  );

  List<DataRow> getHistoryData(List<HistoryModel> history) {
   return  historyList.map((item) => DataRow(
       cells:[
            DataCell(RowWidget(value: item.no)),
            DataCell(RowWidget(value: item.searchedLocation)),
            DataCell(RowWidget(value: item.distance)),
            DataCell(RowWidget(value: item.estimatedTime)),
            DataCell(RowWidget(value: item.timestamp)),
        ])).toList();
    
  }


}
