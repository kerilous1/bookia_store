import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppGradients {
  // ── Primary Gradient (Buttons, Logo glow) ──
  static const LinearGradient primary = LinearGradient(
    colors: [Color(0xFF7C3AED), Color(0xFFDB2777)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ── Gold Accent Gradient ──
  static const LinearGradient gold = LinearGradient(
    colors: [Color(0xFFFFD700), Color(0xFFBF9B30), Color(0xFFFFD700)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ── LottieFiles-inspired Creative Gradient ──
  static const LinearGradient creative = LinearGradient(
    colors: [Color(0xFF7C3AED), Color(0xFFFF2E93), Color(0xFFFF6B6B), Color(0xFFFFD700),],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ── Teal-to-Purple ──
  static const LinearGradient tealPurple = LinearGradient(
    colors: [Color(0xFF00D2D3), Color(0xFF7C3AED)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ── Background overlay gradient ──
  static const LinearGradient backgroundOverlay = LinearGradient(
    colors: [
      Color(0xFF0F0A1A),
      Color(0xFF1A1040),
      Color(0xFF0F0A1A),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // ── Glass surface gradient ──
  static const LinearGradient glass = LinearGradient(
    colors: [
      Color(0x1AFFFFFF),
      Color(0x0DFFFFFF),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class AppShadows {
  static List<BoxShadow> get glowPurple => [
    BoxShadow(
      color: AppColors.primary.withOpacity(0.3),
      blurRadius: 20,
      spreadRadius: 2,
    ),
  ];

  static List<BoxShadow> get glowGold => [
    BoxShadow(
      color: AppColors.accent.withOpacity(0.2),
      blurRadius: 20,
      spreadRadius: 2,
    ),
  ];

  static List<BoxShadow> get soft => [
    BoxShadow(
      color: Colors.black.withOpacity(0.3),
      blurRadius: 15,
      offset: const Offset(0, 5),
    ),
  ];

  static List<BoxShadow> get elevated => [
    BoxShadow(
      color: AppColors.primary.withOpacity(0.15),
      blurRadius: 30,
      offset: const Offset(0, 10),
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.2),
      blurRadius: 10,
      offset: const Offset(0, 5),
    ),
  ];
}
