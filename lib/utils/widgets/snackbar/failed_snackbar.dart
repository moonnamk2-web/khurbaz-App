import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../resources/app_theme.dart';
import '../slide_animation_widget.dart';

void showFailedTopSnackBar({
  required BuildContext context,
  required String title,
  required String content,
}) {
  final overlay = Overlay.of(context);
  late OverlayEntry overlayEntry;
  final size = MediaQuery.of(context).size;

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      left: size.width - 400,
      right: 20,
      child: SlideAnimationWidget(
        position: 0,
        horizontalOffset: 25,
        child: Material(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppThemes.isLightMode() ? Colors.white : null,
              border: const Border(
                left: BorderSide(color: Colors.red, width: 2),
              ),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.error, color: Colors.red, size: 28),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.cairo(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(content, style: GoogleFonts.cairo(fontSize: 14)),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey),
                  onPressed: () {
                    overlayEntry.remove();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  Future.delayed(const Duration(seconds: 3), () {
    overlayEntry.remove();
  });
}
