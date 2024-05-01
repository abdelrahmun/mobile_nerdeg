import 'package:flutter/material.dart';

class AppStyles {
  static defaultBoxShadow() => BoxShadow(
        color: const Color(0x17403B24).withOpacity(0.14),
        blurRadius: 12,
        spreadRadius: 0,
        offset: const Offset(0, 0),
      );

  static defaultCardDecoration({required BuildContext context, Color? color, double radius = 10, Border? border}) {
    return BoxDecoration(
      color: color ?? Theme.of(context).colorScheme.onSecondary,
      borderRadius: BorderRadius.circular(radius),
      border: border,
      boxShadow: [AppStyles.defaultBoxShadow()],
    );
  }
}
