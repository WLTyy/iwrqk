import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    Rect rect = Offset(offset.dx, (configuration.size!.height - 3.5)) &
        Size(configuration.size!.width, 3.5);
    Paint paint = Paint();
    paint.color = Colors.blue;
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
        RRect.fromRectAndCorners(rect,
            topRight: Radius.circular(8.r), topLeft: Radius.circular(8.r)),
        paint);
  }
}
