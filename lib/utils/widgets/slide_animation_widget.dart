import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SlideAnimationWidget extends StatefulWidget {
  const SlideAnimationWidget(
      {super.key,
      required this.child,
      required this.position,
      this.verticalOffset,
      this.horizontalOffset,
      this.milliseconds});

  final Widget child;
  final int position;
  final double? verticalOffset;
  final double? horizontalOffset;
  final int? milliseconds;

  @override
  State<SlideAnimationWidget> createState() => _SlideAnimationWidgetState();
}

class _SlideAnimationWidgetState extends State<SlideAnimationWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      duration: Duration(milliseconds: widget.milliseconds ?? 900),
      position: widget.position,
      child: SlideAnimation(
        verticalOffset: widget.verticalOffset,
        horizontalOffset: widget.horizontalOffset ?? -75,
        child: FadeInAnimation(
          child: widget.child,
        ),
      ),
    );
  }
}
