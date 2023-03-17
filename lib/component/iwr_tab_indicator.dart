import 'package:flutter/material.dart';

class IwrTabIndicator extends Decoration {
  final BuildContext context;
  const IwrTabIndicator(this.context);

  @override
  IwrTabPainter createBoxPainter([VoidCallback? onChanged]) {
    return IwrTabPainter(onChanged, context);
  }
}

class IwrTabPainter extends BoxPainter {
  final BuildContext context;
  IwrTabPainter(VoidCallback? onChanged, this.context);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Rect rect = Offset(offset.dx, (configuration.size!.height - 3.5)) &
        Size(configuration.size!.width, 3.5);
    Paint paint = Paint();
    paint.color = Theme.of(context).primaryColor;
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
        RRect.fromRectAndCorners(rect,
            topRight: Radius.circular(8), topLeft: Radius.circular(8)),
        paint);
  }
}
