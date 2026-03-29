import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moona/screens/main/ui/main_screen.dart';
import 'package:moona/utils/helper/navigation/push_replacement.dart';

import '../managers/cash_manager.dart';
import '../managers/network_manager.dart';
import '../managers/notification/notification_manager.dart';
import '../models/user/user_model.dart';
import '../state-managment/bloc/auth/auth_cubit.dart';
import 'no_connection_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> checkLogeUser() async {
    if (await NetworkService.hasInternet()) {
      CacheManager cacheManager = CacheManager.getInstance()!;
      NotificationManager.initNotification();
      if (!kIsWeb) {
        FirebaseMessaging.instance.subscribeToTopic('App');
      }

      if (cacheManager.isLogged()) {
        UserModel user = cacheManager.getUserModelData();
        AuthCubit.user = user;
        if (!kIsWeb) {
          FirebaseMessaging.instance.subscribeToTopic('User-${user.id}');
        }

        if (user.phoneNumber == null) {
          await AuthCubit.login();
        } else {
          print('============phoneNumber${user.phoneNumber}');
          await AuthCubit.login(phoneNumber: user.phoneNumber);
        }
      } else {
        await AuthCubit().register();
      }
      Future.delayed(const Duration(seconds: 5), () {
        pushReplacement(context, MainScreen());
      });
    } else {
      pushReplacement(context, NoConnectionScreen());
    }
    setState(() {});
  }

  @override
  void initState() {
    checkLogeUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Image.asset('assets/gifs/logo.gif')));
  }
}
