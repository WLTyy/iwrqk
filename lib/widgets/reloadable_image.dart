import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  bool _errorOccurred = false;
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
            color: Colors.blue,
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
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    value: progress.progress,
                  ),
                ));
              },
              errorWidget: (_, __, ___) {
                _errorOccurred = true;
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
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  value: progress.progress,
                ),
              ));
            },
            errorWidget: (_, __, ___) {
              _errorOccurred = true;
              return errorWidget;
            },
          );
  }
}
