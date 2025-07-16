import 'package:flutter/material.dart';

double scaleText(BuildContext context, double baseSize) {
  final screenWidth = MediaQuery.of(context).size.width;
  return baseSize * (screenWidth / 1200);
}