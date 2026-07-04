import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';

/// A premium, animated logo for Bookia Store inspired by LottieFiles' fluid,
/// looping shapes — reimagined as overlapping book pages with creative gradients.
class AppLogo extends StatefulWidget {
  final double size;
  final bool animate;
  final bool showText;

  const AppLogo({
    super.key,
    this.size = 100.0,
    this.animate = true,
    this.showText = false,
  });

  @override
  State<AppLogo> createState() => _AppLogoState();
}

class _AppLogoState extends State<AppLogo> with TickerProviderStateMixin {
  late final AnimationController _breatheController;
  late final AnimationController _rotateController;
  late final Animation<double> _breatheAnimation;
  late final Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();

    _breatheController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );
    _breatheAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _breatheController, curve: Curves.easeInOut),
    );

    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 8000),
    );
    _rotateAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(
      CurvedAnimation(parent: _rotateController, curve: Curves.linear),
    );

    if (widget.animate) {
      _breatheController.repeat(reverse: true);
      _rotateController.repeat();
    }
  }

  @override
  void dispose() {
    _breatheController.dispose();
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_breatheAnimation, _rotateAnimation]),
      builder: (context, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Animated Logo Icon ──
            Transform.scale(
              scale: widget.animate ? _breatheAnimation.value : 1.0,
              child: SizedBox(
                width: widget.size,
                height: widget.size,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // ── Outer glow ring (rotating) ──
                    if (widget.animate)
                      Transform.rotate(
                        angle: _rotateAnimation.value,
                        child: CustomPaint(
                          size: Size(widget.size, widget.size),
                          painter: _GlowRingPainter(),
                        ),
                      ),

                    // ── Main logo shape ──
                    CustomPaint(
                      size: Size(widget.size * 0.75, widget.size * 0.75),
                      painter: _BookiaLogoPainter(),
                    ),
                  ],
                ),
              ),
            ),

            // ── Optional Text Under Logo ──
            if (widget.showText) ...[
              SizedBox(height: widget.size * 0.15),
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [
                    Color(0xFFFFD700),
                    Color(0xFFF5D07A),
                    Color(0xFFFFD700),
                  ],
                ).createShader(bounds),
                child: Text(
                  'BOOKIA',
                  style: TextStyle(
                    fontSize: widget.size * 0.25,
                    fontWeight: FontWeight.w900,
                    letterSpacing: widget.size * 0.06,
                    color: Colors.white, // Required for ShaderMask
                    height: 1.0,
                  ),
                ),
              ),
              Text(
                'STORE',
                style: TextStyle(
                  fontSize: widget.size * 0.1,
                  fontWeight: FontWeight.w300,
                  letterSpacing: widget.size * 0.12,
                  color: AppColors.textSecondary,
                  height: 1.2,
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

/// Draws the outer gradient glow ring (like LottieFiles' continuous loop)
class _GlowRingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.46;

    final paint = Paint()
      ..shader = SweepGradient(
        colors: const [
          Color(0xFF7C3AED),
          Color(0xFFFF2E93),
          Color(0xFFFFD700),
          Color(0xFF00D2D3),
          Color(0xFF7C3AED),
        ],
        stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Draws the main Bookia "B" logo with overlapping fluid book pages
class _BookiaLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // ── Layer 1: Back page (teal/cyan) ──
    final backPagePaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF00D2D3), Color(0xFF00B4D8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, w, h))
      ..style = PaintingStyle.fill;

    final backPage = Path()
      ..moveTo(w * 0.18, h * 0.10)
      ..lineTo(w * 0.18, h * 0.88)
      ..quadraticBezierTo(w * 0.22, h * 0.92, w * 0.30, h * 0.88)
      ..lineTo(w * 0.68, h * 0.55)
      ..quadraticBezierTo(w * 0.78, h * 0.48, w * 0.72, h * 0.35)
      ..lineTo(w * 0.40, h * 0.10)
      ..quadraticBezierTo(w * 0.30, h * 0.05, w * 0.18, h * 0.10)
      ..close();

    canvas.drawPath(backPage, backPagePaint);

    // ── Layer 2: Middle page (hot pink) ──
    final midPagePaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFFF2E93), Color(0xFFDB2777)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, w, h))
      ..style = PaintingStyle.fill;

    final midPage = Path()
      ..moveTo(w * 0.22, h * 0.15)
      ..lineTo(w * 0.22, h * 0.83)
      ..quadraticBezierTo(w * 0.30, h * 0.90, w * 0.42, h * 0.82)
      ..quadraticBezierTo(w * 0.58, h * 0.72, w * 0.70, h * 0.58)
      ..quadraticBezierTo(w * 0.82, h * 0.43, w * 0.70, h * 0.28)
      ..lineTo(w * 0.45, h * 0.15)
      ..quadraticBezierTo(w * 0.35, h * 0.10, w * 0.22, h * 0.15)
      ..close();

    canvas.drawPath(midPage, midPagePaint);

    // ── Layer 3: Front page (primary purple — the dominant "B" shape) ──
    final frontPagePaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF7C3AED), Color(0xFF5B21B6)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, w, h))
      ..style = PaintingStyle.fill;

    final frontPage = Path()
      ..moveTo(w * 0.26, h * 0.12)
      ..lineTo(w * 0.26, h * 0.88);

    // Lower B curve
    frontPage.quadraticBezierTo(w * 0.26, h * 0.92, w * 0.35, h * 0.88);
    frontPage.quadraticBezierTo(w * 0.55, h * 0.88, w * 0.65, h * 0.75);
    frontPage.quadraticBezierTo(w * 0.75, h * 0.62, w * 0.60, h * 0.52);

    // Upper B curve
    frontPage.quadraticBezierTo(w * 0.72, h * 0.48, w * 0.68, h * 0.35);
    frontPage.quadraticBezierTo(w * 0.64, h * 0.20, w * 0.48, h * 0.15);
    frontPage.lineTo(w * 0.35, h * 0.12);
    frontPage.quadraticBezierTo(w * 0.30, h * 0.10, w * 0.26, h * 0.12);
    frontPage.close();

    canvas.drawPath(frontPage, frontPagePaint);

    // ── Gold accent line on the spine ──
    final spinePaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFFFD700), Color(0xFFF5D07A)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, w, h))
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.03
      ..strokeCap = StrokeCap.round;

    final spinePath = Path()
      ..moveTo(w * 0.26, h * 0.16)
      ..lineTo(w * 0.26, h * 0.84);

    canvas.drawPath(spinePath, spinePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}