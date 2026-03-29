import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/resources/app_colors.dart';
import '../utils/resources/app_container_decoration.dart';

class NetworkService {
  static final NetworkService _instance = NetworkService._internal();

  factory NetworkService() {
    return _instance;
  }

  NetworkService._internal();

  StreamSubscription? _subscription;

  bool _dialogShowing = false;

  static Future<bool> hasInternet() async {
    final connectivity = await Connectivity().checkConnectivity();

    if (connectivity == ConnectivityResult.none) {
      return false;
    }

    try {
      final result = await InternetAddress.lookup('google.com');

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } catch (_) {
      return false;
    }

    return false;
  }

  /// Start listening network changes
  void start(BuildContext context) {
    _subscription = Connectivity().onConnectivityChanged.listen((event) async {
      bool hasInternet = await checkInternet();

      if (!hasInternet) {
        if (!_dialogShowing) {
          _dialogShowing = true;

          _showNoInternetDialog(context);
        }
      } else {
        if (_dialogShowing) {
          Navigator.of(context, rootNavigator: true).pop();

          _dialogShowing = false;
        }
      }
    });
  }

  /// Stop listening
  void stop() {
    _subscription?.cancel();
  }

  /// Check real internet
  Future<bool> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');

      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  /// Show dialog
  void _showNoInternetDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return ConnectionDialog(
          text: 'ليس لديك اتصال بالإنترنت',
          textButton: 'إعادة المحاولة',
          onCheck: () async {
            await checkInternet();
            return true;
          },
        );
      },
    );
  }
}

class ConnectionDialog extends StatefulWidget {
  const ConnectionDialog({
    super.key,
    required this.text,
    required this.onCheck,
    required this.textButton,
  });

  final String text;
  final String textButton;
  final Future<bool> Function() onCheck;

  @override
  State<ConnectionDialog> createState() => _ConnectionDialogState();
}

class _ConnectionDialogState extends State<ConnectionDialog> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            width: 350,
            height: loading ? 300 : null,
            padding: EdgeInsets.all(16),
            decoration: mainDecoration,
            child: Material(
              child: loading
                  ? Center(child: CircularProgressIndicator(color: kMainColor))
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SvgPicture.asset(
                            'assets/images/alert.svg',
                            width: 100,
                            color: Colors.red,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            widget.text,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF1C1C1C),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 8,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    loading = true;
                                  });
                                  await widget.onCheck();
                                  setState(() {
                                    loading = false;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    color: kMainColor.withOpacity(0.1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    widget.textButton,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: kMainColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      height: 1.50,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
