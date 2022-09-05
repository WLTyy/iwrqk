import 'package:flutter/material.dart';

class TabIndicator extends Decoration {
  const TabIndicator();

  @override
  TabPainter createBoxPainter([VoidCallback? onChanged]) {
    return TabPainter(onChanged);
  }
}

class TabPainter extends BoxPainter {
  TabPainter(VoidCallback? onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Rect rect = Offset(offset.dx, (configuration.size!.height - 2)) &
        Size(configuration.size!.width, 3);
    Paint paint = Paint();
    paint.color = Colors.blue;
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
        RRect.fromRectAndCorners(rect,
            topRight: Radius.circular(8), topLeft: Radius.circular(8)),
        paint);
  }
}
