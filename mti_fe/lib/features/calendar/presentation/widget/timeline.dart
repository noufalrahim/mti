import 'package:flutter/material.dart';
import 'package:timeline_list/timeline_list.dart';

class TimelineWidget extends StatelessWidget {
  const TimelineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [
      const Color(0xFFF8BBD0),
      const Color(0xFFAED581),
      const Color(0xFF80DEEA),
    ];

    return Timeline.builder(
      context: context,
      markerCount: 10,
      properties: TimelineProperties(
        iconAlignment: MarkerIconAlignment.center,
        iconSize: 48,
        timelinePosition: TimelinePosition.center,
        lineWidth: 6,
        lineColor: Colors.grey,
      ),
      markerBuilder: (context, index) {
        Color markerColor = Theme.of(context).primaryColor;
        return Marker(
          child: CustomPaint(
            painter: MarkerContainerPainter(color: markerColor),
            child: Container(
              width: 250,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              child: const Text(
                'I started to walk!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          icon: Material(
            elevation: 4,
            shape: const CircleBorder(),
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors[index % colors.length],
              ),
              child: Center(
                child: Text(
                  '2\nFeb',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
          position: index % 2 == 0 ? MarkerPosition.left : MarkerPosition.right,
        );
      },
    );
  }
}

class MarkerContainerPainter extends CustomPainter {
  final Color color;

  MarkerContainerPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(8));

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
