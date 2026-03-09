import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:moona/screens/addresses/presentation/cubit/addresses_cubit.dart';
import 'package:moona/screens/main/ui/main_screen.dart';
import 'package:moona/screens/splash_screen.dart';
import 'package:moona/state-managment/bloc/auth/auth_cubit.dart';
import 'package:moona/state-managment/bloc/loading/loading_cubit.dart';
import 'package:moona/utils/resources/app_theme.dart';

import 'managers/cash_manager.dart';

const Color mainColor = Color(0xFF2D6251);

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await CacheManager.getInstance()!.init();
  await initializeDateFormatting('ar', null);
  FlutterNativeSplash.remove();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AddressesCubit()),
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => LoadingCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: AppThemes.dark,
        theme: AppThemes.light,
        routes: {'main': (context) => MainScreen()},
        home: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => AddressesCubit()),
            BlocProvider(create: (_) => AuthCubit()),
            BlocProvider(create: (_) => LoadingCubit()),
          ],
          child: const SplashScreen(),
        ),
      ),
    );
  }
}
