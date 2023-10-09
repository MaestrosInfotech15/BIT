import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:google_fonts/google_fonts.dart';

class NeumorphismWidget extends StatelessWidget {
  const NeumorphismWidget({
    super.key,
    required this.child,
    required this.padding,
  });

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 10.0,
            offset: const Offset(4.0, 4.0),
          ),
          const BoxShadow(
            color: Colors.white,
            blurRadius: 10.0,
            offset: Offset(-4.0, -4.0),
          ),
        ],
      ),
      child: child,
    );
  }
}

class InnerNeumorphismWidget extends StatelessWidget {
  const InnerNeumorphismWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
              color: Colors.white,
              blurRadius: 5.0,
              offset: -const Offset(10.0, 10.0),
              inset: true),
          BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 5.0,
              offset: const Offset(10.0, 10),
              inset: true),
        ],
      ),
      child: child,
    );
  }
}
