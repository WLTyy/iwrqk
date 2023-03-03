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
  bool _unexpectedErrorOccurred = false;

  @override
  Widget build(BuildContext context) {
    if (_unexpectedErrorOccurred) {
      return Center(
        child: Icon(
          CupertinoIcons.xmark_octagon_fill,
          size: 45,
          color: Colors.red,
        ),
      );
    }

    try {
      return _errorOccurred
          ? GestureDetector(
              onTap: () {
                setState(() {
                  _errorOccurred = false;
                });
              },
              child: Center(
                child: Icon(
                  CupertinoIcons.arrow_clockwise,
                  size: 45,
                  color: Colors.blue,
                ),
              ),
            )
          : widget.aspectRatio != null
              ? AspectRatio(
                  aspectRatio: widget.aspectRatio!,
                  child: CachedNetworkImage(
                    imageUrl: widget.imageUrl,
                    fit: widget.fit,
                    progressIndicatorBuilder: (context, url, progress) {
                      return Center(
                          child: SizedBox(
                        child: const CircularProgressIndicator(
                          strokeWidth: 3,
                        ),
                      ));
                    },
                    errorWidget: (_, __, ___) {
                      setState(() {
                        _errorOccurred = true;
                      });
                      return Container();
                    },
                  ))
              : CachedNetworkImage(
                  imageUrl: widget.imageUrl,
                  width: widget.width,
                  height: widget.height,
                  fit: widget.fit,
                  progressIndicatorBuilder: (context, url, progress) {
                    return Center(
                        child: SizedBox(
                      child: const CircularProgressIndicator(
                        strokeWidth: 3,
                      ),
                    ));
                  },
                  errorWidget: (_, __, ___) {
                    setState(() {
                      _errorOccurred = true;
                    });
                    return Container();
                  },
                );
    } catch (e) {
      _unexpectedErrorOccurred = true;
      return Center(
        child: Icon(
          CupertinoIcons.xmark_octagon_fill,
          size: 45,
          color: Colors.red,
        ),
      );
    }
  }
}
