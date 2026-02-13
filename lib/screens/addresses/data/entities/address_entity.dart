// domain/entities/address_entity.dart
class AddressEntity {
  final int id;
  final String receiverName;
  final String phoneNumber;
  final String addressName;
  final String locationName;
  final String? buildingName;
  final String? floor;
  final double latitude;
  final double longitude;
  final bool isDefault;

  AddressEntity({
    required this.id,
    required this.receiverName,
    required this.phoneNumber,
    required this.addressName,
    required this.locationName,
    this.buildingName,
    this.floor,
    required this.latitude,
    required this.longitude,
    required this.isDefault,
  });

  // --------------------------
  // FROM JSON
  // --------------------------
  factory AddressEntity.fromJson(Map<String, dynamic> json) {
    return AddressEntity(
      id: json['id'] as int,
      receiverName: json['receiver_name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      addressName: json['address_name'] ?? '',
      locationName: json['location_name'] ?? '',
      buildingName: json['building_name'],
      floor: json['floor'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      isDefault: json['is_default'] == true || json['is_default'] == 1,
    );
  }

  // --------------------------
  // TO JSON
  // --------------------------
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'receiver_name': receiverName,
      'phone_number': phoneNumber,
      'address_name': addressName,
      'location_name': locationName,
      'building_name': buildingName,
      'floor': floor,
      'latitude': latitude,
      'longitude': longitude,
      'is_default': isDefault,
    };
  }

  // --------------------------
  // COPY WITH
  // --------------------------
  AddressEntity copyWith({
    int? id,
    String? receiverName,
    String? phoneNumber,
    String? addressName,
    String? locationName,
    String? buildingName,
    String? floor,
    double? latitude,
    double? longitude,
    bool? isDefault,
  }) {
    return AddressEntity(
      id: id ?? this.id,
      receiverName: receiverName ?? this.receiverName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      addressName: addressName ?? this.addressName,
      locationName: locationName ?? this.locationName,
      buildingName: buildingName ?? this.buildingName,
      floor: floor ?? this.floor,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
