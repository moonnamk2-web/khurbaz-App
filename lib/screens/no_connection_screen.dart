import 'package:flutter/material.dart';
import 'package:moona/screens/splash_screen.dart';

import '../utils/helper/navigation/push_replacement.dart';

class NoConnectionScreen extends StatefulWidget {
  const NoConnectionScreen({super.key});

  @override
  State<NoConnectionScreen> createState() => _NoConnectionScreenState();
}

class _NoConnectionScreenState extends State<NoConnectionScreen> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// icon
                const Icon(
                  Icons.wifi_off_rounded,
                  size: 90,
                  color: Colors.grey,
                ),

                const SizedBox(height: 20),

                /// title
                const Text(
                  "لا يوجد اتصال بالإنترنت",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                /// description
                const Text(
                  "يُرجى التحقق من اتصالك بالإنترنت والمحاولة مرة أخرى.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),

                const SizedBox(height: 30),

                /// retry button
                ElevatedButton(
                  onPressed: () async {
                    pushReplacement(context, SplashScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 12,
                    ),
                  ),
                  child: const Text("إعادة المحاولة"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
