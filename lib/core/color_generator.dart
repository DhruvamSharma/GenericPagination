import 'package:flutter/material.dart';

extension ColorToHex on Color {
  /// Converts the color to a 6-digit hexadecimal string representation (without alpha).
  String toHex({bool leadingHash = false}) {
    return '${leadingHash ? '#' : ''}'
        '${red.toRadixString(16).padLeft(2, '0')}'
        '${green.toRadixString(16).padLeft(2, '0')}'
        '${blue.toRadixString(16).padLeft(2, '0')}';
  }
}

class ColorGenerator {
  /// Generates a pseudo-random color based on the provided index.
  ///
  /// This function uses a simple hash function to map the index to a unique
  /// color. It's not cryptographically secure, but it's sufficient for
  /// generating distinct colors for UI elements.
  ///
  /// The generated color will always have full opacity (alpha = 0xFF).
  static Color generateColor(int index) {
    // A simple hash function to distribute the index across the color space.
    int hash = index * 0x9E3779B9; // A large prime number
    hash = (hash ^ (hash >> 16)) & 0xFFFFFFFF; // Ensure 32-bit unsigned

    // Extract color components from the hash.
    int r = (hash >> 16) & 0xFF;
    int g = (hash >> 8) & 0xFF;
    int b = hash & 0xFF;

    return Color(0xFF000000 + (r << 16) + (g << 8) + b); // Full opacity
  }
}
