import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iwrqk/widgets/Iwr_progress_indicator.dart';

class ReloadableImage extends StatefulWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final double? aspectRatio;
  final BoxFit? fit;

  const ReloadableImage(
      {Key? key,
      required this.imageUrl,
      this.width,
      this.height,
      this.fit,
      this.aspectRatio})
      : super(key: key);

  @override
  State<ReloadableImage> createState() => _ReloadableImageState();
}

class _ReloadableImageState extends State<ReloadableImage> {
  GlobalKey _imageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final errorWidget = GestureDetector(
        onTap: () {
          setState(() {
            _imageKey = GlobalKey();
          });
        },
        child: Center(
          child: Icon(
            CupertinoIcons.arrow_clockwise,
            color: Theme.of(context).primaryColor,
          ),
        ));

    return widget.aspectRatio != null
        ? AspectRatio(
            aspectRatio: widget.aspectRatio!,
            child: CachedNetworkImage(
              key: _imageKey,
              imageUrl: widget.imageUrl,
              fit: widget.fit,
              progressIndicatorBuilder: (context, url, progress) {
                return Center(
                    child: Container(
                  margin: EdgeInsets.all(5),
                  child: IwrProgressIndicator(),
                ));
              },
              errorWidget: (_, __, ___) {
                return errorWidget;
              },
            ))
        : CachedNetworkImage(
            key: _imageKey,
            imageUrl: widget.imageUrl,
            width: widget.width,
            height: widget.height,
            fit: widget.fit,
            progressIndicatorBuilder: (context, url, progress) {
              return Center(
                  child: Container(
                margin: EdgeInsets.all(5),
                child: IwrProgressIndicator(),
              ));
            },
            errorWidget: (_, __, ___) {
              return errorWidget;
            },
          );
  }
}
