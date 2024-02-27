import 'package:flutter/material.dart';

class Skeleton extends StatelessWidget {
  final double width;
  final double height;

  const Skeleton({
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}
