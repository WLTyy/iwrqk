import 'package:flutter/material.dart';

class IwrTabIndicator extends Decoration {
  const IwrTabIndicator();

  @override
  IwrTabPainter createBoxPainter([VoidCallback? onChanged]) {
    return IwrTabPainter(onChanged);
  }
}

class IwrTabPainter extends BoxPainter {
  IwrTabPainter(VoidCallback? onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Rect rect = Offset(offset.dx, (configuration.size!.height - 3.5)) &
        Size(configuration.size!.width, 3.5);
    Paint paint = Paint();
    paint.color = Colors.blue;
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
        RRect.fromRectAndCorners(rect,
            topRight: Radius.circular(8), topLeft: Radius.circular(8)),
        paint);
  }
}
