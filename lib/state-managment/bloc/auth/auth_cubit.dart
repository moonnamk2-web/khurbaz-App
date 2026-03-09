import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../../managers/cash_manager.dart';
import '../../../models/user/user_model.dart';
import '../../../utils/network/network_routes.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(LoginStateInitial());

  static AuthCubit instance(BuildContext context) => BlocProvider.of(context);

  static UserModel? user;

  static updateToken(String token) {
    headersWithToken = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  void loginStateInitial() {
    emit(LoginStateInitial());
  }

  void registerState() {
    emit(RegisterState());
  }

  void oTPSent({required String phoneNumber}) {
    emit(OTPSent(phoneNumber: phoneNumber));
  }

  static Future<String> getDeviceId() async {
    final prefs = await SharedPreferences.getInstance();

    String? savedId = prefs.getString('device_id');

    if (savedId != null) {
      return savedId;
    }

    final newId = const Uuid().v4();
    await prefs.setString('device_id', newId);

    return newId;
  }

  Future<dynamic> register({String? phoneNumber, String? fullName}) async {
    String? deviceId;
    deviceId = await getDeviceId();

    final url = Uri.parse(registerApi);
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({
        'device_id': deviceId,
        'phone_number': phoneNumber,
        'full_name': fullName,
      }),
    );

    final map = json.decode(response.body);

    if (response.statusCode == 200) {
      print('==========login: $map');

      if (map['status'] == "success") {
        user = UserModel.fromJson(map['user']);
        user!.token = map['access_token'];
        updateToken(map['access_token']);
        await CacheManager.getInstance()!.storeUserModelData(user!);

        // if (!kIsWeb) {
        //   FirebaseMessaging.instance.subscribeToTopic(
        //     'Customer-${AuthCubit.user!.id.toString()}',
        //   );
        // }
        return null;
      } else {
        print('==========login Failed: $map');
        return map;
      }
    } else {
      print('==========login: $map');

      return map;
    }
  }

  static Future<dynamic> login({String? phoneNumber}) async {
    String? deviceId;
    deviceId = await getDeviceId();

    final url = Uri.parse(loginApi);

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({'phone_number': phoneNumber, 'device_id': deviceId}),
    );

    final map = json.decode(response.body);

    if (response.statusCode == 200) {
      print('==========login: $map');

      if (map['status'] == "success") {
        user = UserModel.fromJson(map['user']);

        user!.token = map['access_token'];
        updateToken(map['access_token']);
        await CacheManager.getInstance()!.storeUserModelData(user!);

        // if (!kIsWeb) {
        //   FirebaseMessaging.instance.subscribeToTopic(
        //     'Customer-${AuthCubit.user!.id.toString()}',
        //   );
        // }
        return null;
      } else {
        print('==========login Failed: $map');
        return map;
      }
    } else {
      print('==========login: $map');

      return map;
    }
  }

  static Future<bool> refreshToken() async {
    final url = Uri.parse(refreshTokenApi);

    final response = await http.post(url, headers: headersWithToken);
    print('==========refreshToken ${user!.token}');

    if (response.statusCode == 200) {
      dynamic map = jsonDecode(response.body);
      print('==========refreshToken Success $map');

      if (map['status'].toString() == "success") {
        print('==========status Success ${map['status']}');
        user = UserModel.fromJson(map['user']);
        user!.token = map['access_token'];
        updateToken(map['access_token']);
        await CacheManager.getInstance()!.logout();
        await CacheManager.getInstance()!.storeUserModelData(user!);
        return true;
      } else {
        // The token has been blacklisted
        print('==========refreshToken Failed: $map');
        await CacheManager.getInstance()!.logout();

        return false;
      }
    } else {
      print('==========refreshToken Failed: ${response.body}');
      await CacheManager.getInstance()!.logout();

      return false;
    }
  }
}
