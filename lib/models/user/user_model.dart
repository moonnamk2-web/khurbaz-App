import 'dart:convert';

import '../../screens/addresses/data/entities/address_entity.dart';

class UserModel {
  dynamic id;
  dynamic token;
  dynamic deviceId;
  dynamic fullName;
  dynamic email;
  dynamic phoneNumber;
  dynamic birthdate;
  dynamic gender;
  dynamic governorate;
  dynamic profilePicture;
  AddressEntity? address;

  UserModel({
    this.id,
    this.deviceId,
    this.token,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.birthdate,
    this.gender,
    this.governorate,
    this.profilePicture,
    this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      deviceId: json['device_id'],
      token: json['token'],
      fullName: json['full_name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      birthdate: json['birthdate'],
      gender: json['gender'],
      governorate: json['governorate'],
      profilePicture: json['profile_picture'],
      address: json['default_address'] != null
          ? AddressEntity.fromJson(json['default_address'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'device_id': deviceId,
      'token': token,
      'full_name': fullName,
      'email': email,
      'phone_number': phoneNumber,
      'birthdate': birthdate,
      'gender': gender,
      'governorate': governorate,
      'profile_picture': profilePicture,
    };
  }

  @override
  String toString() {
    return json.encoder.convert(toJson());
  }

  factory UserModel.fomString(String data) =>
      UserModel.fromJson(json.decoder.convert(data));
}
