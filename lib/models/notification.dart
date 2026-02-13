import 'package:google_maps_flutter/google_maps_flutter.dart';

class NotificationModel {
  final int? id;
  final List<String> target;
  final String type;
  final String title;
  final String body;
  final LatLng? location;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  NotificationModel({
    this.id,

    required this.target,
    required this.type,
    required this.title,
    required this.body,

    this.location,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    print('=================created_at : ${json['created_at']}');
    return NotificationModel(
      id: json['id'],

      target: [json['target']],
      type: json['type'],
      title: json['title'],
      body: json['body'],

      location: json['location'],
      createdAt: DateTime.parse(json['created_at']).toLocal(),
      updatedAt:
          DateTime.tryParse(json['updated_at'].toString()) ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson(String topic) {
    return {

      'target': topic,
      'type': type,
      'title': title,
      'body': body,

      'latitude': location?.latitude,
      'longitude': location?.longitude,
    };
  }

  static List<NotificationModel> fromJsonList(List<dynamic> list) {
    return list.map((item) => NotificationModel.fromJson(item)).toList();
  }
}
