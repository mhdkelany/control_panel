import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double height;
  final double width;
  final ShapeBorder shapeBorder;
  ShimmerWidget.rectangular({
    this.width=double.infinity,
    required this.height,
  }):this.shapeBorder=RoundedRectangleBorder();
  ShimmerWidget.circular({
    required this.height,
    required this.width,
    this.shapeBorder=const CircleBorder(),
  }

      );
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[300]!,

      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
            color: Colors.grey[400],
            shape: shapeBorder
        ),
      ),
    );
  }
}
