import 'dart:ffi';

class HistoryModel {
  String no;
  String searchedLocation;
  String distance;
  String estimatedTime;
  String travel;
  String timestamp;

  HistoryModel({
    required this.no,
    required this.searchedLocation,
    required this.distance,
    required this.estimatedTime,
    required this.travel,
    required this.timestamp,
  });
}
