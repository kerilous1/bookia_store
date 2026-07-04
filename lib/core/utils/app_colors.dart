import 'dart:ui';

class AppColors {
  // ── Primary Palette (Deep Luxury Purple) ──
  static const Color primary = Color(0xFF7C3AED);        // Vibrant purple
  static const Color primaryDark = Color(0xFF5B21B6);     // Deep purple
  static const Color primaryLight = Color(0xFFA78BFA);    // Soft lavender
  static const Color primarySurface = Color(0xFF1E1033);  // Dark purple surface

  // ── Accent (Premium Gold) ──
  static const Color accent = Color(0xFFFFD700);          // Pure gold
  static const Color accentSoft = Color(0xFFF5D07A);      // Soft gold
  static const Color accentDark = Color(0xFFBF9B30);      // Dark gold

  // ── Creative Pops (LottieFiles inspired) ──
  static const Color coral = Color(0xFFFF6B6B);           // Warm coral
  static const Color teal = Color(0xFF00D2D3);            // Creative teal
  static const Color hotPink = Color(0xFFFF2E93);         // Hot pink
  static const Color electric = Color(0xFF00F5FF);        // Electric cyan

  // ── Background & Surfaces (Dark Theme) ──
  static const Color background = Color(0xFF0F0A1A);     // Deep dark background
  static const Color surface = Color(0xFF1A1230);         // Card surface
  static const Color surfaceLight = Color(0xFF241B3A);    // Elevated surface
  static const Color surfaceGlass = Color(0x1AFFFFFF);    // Glass effect 10%

  // ── Text ──
  static const Color textPrimary = Color(0xFFF5F3FF);    // Almost white
  static const Color textSecondary = Color(0xFF9CA3AF);   // Muted grey
  static const Color textMuted = Color(0xFF6B7280);       // Very muted

  // ── Borders ──
  static const Color border = Color(0xFF2D2547);          // Subtle border
  static const Color borderFocus = Color(0xFF7C3AED);     // Focus border

  // ── Status ──
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);

  // ── Legacy compatibility ──
  static const Color primaryBlue = primary;
  static const Color lightBlue = primaryLight;
  static const Color textDark = textPrimary;
  static const Color textGrey = textSecondary;
}