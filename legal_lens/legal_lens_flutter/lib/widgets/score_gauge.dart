import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/theme/app_theme.dart';

class ScoreGauge extends StatelessWidget {
  final int score;
  final String label;
  final String description;
  final Color accentColor;

  const ScoreGauge({
    super.key,
    required this.score,
    required this.label,
    required this.description,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 150,
          width: 200,
          child: CustomPaint(
            painter: _GaugePainter(score: score, color: accentColor),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '$score',
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                          TextSpan(
                            text: '/100',
                            style: TextStyle(
                              fontSize: 20,
                              color: AppColors.textGrey.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: accentColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.textGrey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _GaugePainter extends CustomPainter {
  final int score;
  final Color color;

  _GaugePainter({required this.score, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.8);
    final radius = size.width / 2 - 10;
    final strokeWidth = 14.0;

    // Background Arc
    final bgPaint = Paint()
      ..color = Colors.grey.shade200
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      math.pi,
      false,
      bgPaint,
    );

    // Foreground Arc
    final fgPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = color;

    // Calculate angle based on score (0-100 maps to 0-Pi)
    final sweepAngle = (score / 100) * math.pi;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      sweepAngle,
      false,
      fgPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
