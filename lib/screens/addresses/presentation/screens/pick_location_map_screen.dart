import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../managers/location_maneger.dart';
import '../../../../utils/resources/app_colors.dart';

class PickLocationMapScreen extends StatefulWidget {
  const PickLocationMapScreen({
    super.key,
    required this.location,
    required this.view,
  });

  final bool view;
  final LatLng? location;

  @override
  State<PickLocationMapScreen> createState() => _PickLocationMapScreenState();
}

class _PickLocationMapScreenState extends State<PickLocationMapScreen> {
  CameraPosition? initialCameraPosition;
  LatLng target = LatLng(0, 0);
  Set<Marker> markers = {};
  dynamic icon;

  @override
  void initState() {
    getCurrentLocation();
    // TODO: implement initState
    super.initState();
  }

  Future<void> createMarker() async {
    icon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(5, 5)),
      Platform.isIOS ? "assets/images/pin-32.png" : 'assets/images/pin.png',
    );
    // markers.add();
  }

  getCurrentLocation() async {
    if (widget.location == null) {
      print('======== 1');
      LocationManager locationManager = LocationManager();
      target = await locationManager.getLocation();
    } else {
      print('======== 2');
      target = widget.location!;
    }
    await createMarker();

    print('========latitude : ${target.latitude}');
    print('========longitude : ${target.longitude}');

    initialCameraPosition = CameraPosition(target: target, zoom: 12);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: !widget.view
            ? SizedBox()
            : IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back, color: Colors.white),
              ),
        title: Text(
          'select on map',
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: initialCameraPosition == null && icon == null
          ? Center(child: CircularProgressIndicator(color: kMainColor))
          : SafeArea(
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: initialCameraPosition!,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    markers: {
                      Marker(
                        markerId: MarkerId('1'),
                        position: target,
                        icon: icon,
                      ),
                    },
                    onCameraMove: (CameraPosition position) {
                      setState(() {
                        target = position.target;
                      });
                    },
                    onCameraIdle: () {
                      setState(() {});
                    },
                  ),
                  if (!widget.view)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 40.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context, target);
                          },
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            margin: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: kMainColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                'select',
                                style: GoogleFonts.cairo(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}
