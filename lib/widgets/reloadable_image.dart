import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReloadableImage extends StatefulWidget {
  final String imageUrl;
  final Size size;

  const ReloadableImage({required this.imageUrl, Key? key, required this.size})
      : super(key: key);

  @override
  State<ReloadableImage> createState() => _ReloadableImageState();
}

class _ReloadableImageState extends State<ReloadableImage> {
  @override
  Widget build(BuildContext context) {
    bool successLoad = true;
    double minDistance = widget.size.width > widget.size.height
        ? widget.size.height / 2
        : widget.size.width / 2;
    return CachedNetworkImage(
      key: ValueKey<String>(
        successLoad ? widget.imageUrl : new DateTime.now().toString(),
      ),
      height: widget.size.height,
      width: widget.size.width,
      imageUrl: widget.imageUrl,
      progressIndicatorBuilder: (context, url, progress) {
        successLoad = progress.downloaded == progress.totalSize;
        return Center(
            child: SizedBox(
          width: minDistance * 0.75,
          height: minDistance * 0.75,
          child: const CircularProgressIndicator(
            strokeWidth: 3,
          ),
        ));
      },
      errorWidget: (_, __, dynamic ___) {
        return MaterialButton(
          onPressed: () {},
          child: Center(
            child: Icon(
              CupertinoIcons.arrow_clockwise,
              size: 45,
              color: Colors.blue,
            ),
          ),
        );
      },
      fit: BoxFit.cover,
    );
  }
}
