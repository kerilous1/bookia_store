import 'dart:math';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

/// A premium animated background with floating orbs and gradient mesh,
/// inspired by LottieFiles' dynamic, creative aesthetics.
class AnimatedBackground extends StatefulWidget {
  final Widget child;

  const AnimatedBackground({super.key, required this.child});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
      ),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _BackgroundPainter(_controller.value),
            child: widget.child,
          );
        },
      ),
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  final double progress;
  _BackgroundPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    // ── Orb 1: Large purple orb (top-right, drifting) ──
    final orb1X = size.width * (0.75 + 0.08 * sin(progress * 2 * pi));
    final orb1Y = size.height * (0.15 + 0.05 * cos(progress * 2 * pi));
    final orb1Paint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF7C3AED).withOpacity(0.25),
          const Color(0xFF7C3AED).withOpacity(0.0),
        ],
      ).createShader(
        Rect.fromCircle(center: Offset(orb1X, orb1Y), radius: size.width * 0.4),
      );
    canvas.drawCircle(Offset(orb1X, orb1Y), size.width * 0.4, orb1Paint);

    // ── Orb 2: Pink orb (bottom-left) ──
    final orb2X = size.width * (0.2 + 0.06 * cos(progress * 2 * pi + 1.5));
    final orb2Y = size.height * (0.75 + 0.04 * sin(progress * 2 * pi + 1.5));
    final orb2Paint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFDB2777).withOpacity(0.15),
          const Color(0xFFDB2777).withOpacity(0.0),
        ],
      ).createShader(
        Rect.fromCircle(center: Offset(orb2X, orb2Y), radius: size.width * 0.35),
      );
    canvas.drawCircle(Offset(orb2X, orb2Y), size.width * 0.35, orb2Paint);

    // ── Orb 3: Gold accent orb (center-ish) ──
    final orb3X = size.width * (0.5 + 0.1 * sin(progress * 2 * pi + 3.0));
    final orb3Y = size.height * (0.45 + 0.06 * cos(progress * 2 * pi + 3.0));
    final orb3Paint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFFFD700).withOpacity(0.08),
          const Color(0xFFFFD700).withOpacity(0.0),
        ],
      ).createShader(
        Rect.fromCircle(center: Offset(orb3X, orb3Y), radius: size.width * 0.25),
      );
    canvas.drawCircle(Offset(orb3X, orb3Y), size.width * 0.25, orb3Paint);

    // ── Orb 4: Teal orb (bottom-right, subtle) ──
    final orb4X = size.width * (0.85 + 0.05 * cos(progress * 2 * pi + 4.5));
    final orb4Y = size.height * (0.9 + 0.03 * sin(progress * 2 * pi + 4.5));
    final orb4Paint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF00D2D3).withOpacity(0.10),
          const Color(0xFF00D2D3).withOpacity(0.0),
        ],
      ).createShader(
        Rect.fromCircle(center: Offset(orb4X, orb4Y), radius: size.width * 0.2),
      );
    canvas.drawCircle(Offset(orb4X, orb4Y), size.width * 0.2, orb4Paint);
  }

  @override
  bool shouldRepaint(covariant _BackgroundPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
