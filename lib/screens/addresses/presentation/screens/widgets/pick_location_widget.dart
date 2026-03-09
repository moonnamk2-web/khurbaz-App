import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../utils/helper/navigation/push_to.dart';
import '../../../../../utils/resources/app_colors.dart';
import '../pick_location_map_screen.dart';

class PickLocationWidget extends StatefulWidget {
  PickLocationWidget({super.key, required this.onTap, this.location});

  final Function(LatLng?) onTap;
  LatLng? location;

  @override
  State<PickLocationWidget> createState() => _PickLocationWidgetState();
}

class _PickLocationWidgetState extends State<PickLocationWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 12,
      children: [
        Row(
          spacing: 4,

          children: [
            SvgPicture.asset('assets/icons/location.svg'),
            Text(
              'الموقع على الخريطة',
              style: TextStyle(
                fontFamily: 'DINNextLT',
                color: const Color(0xFF1C1C1C),
                fontSize: 14,
                fontWeight: FontWeight.w600,
                height: 1.43,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () async {
            widget.location = await pushTo(
              context,
              PickLocationMapScreen(view: false, location: widget.location),
            );
            widget.onTap(widget.location);
            setState(() {});
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 2,
                  color: widget.location == null
                      ? Colors.transparent
                      : kMainColor,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 8,
              children: [
                SvgPicture.asset(
                  'assets/icons/marker.svg',
                  color: widget.location == null ? Colors.black : kMainColor,
                ),
                Text(
                  widget.location == null ? 'تحديد الموقع' : "تم تحديد الموقع",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'DINNextLT',
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
