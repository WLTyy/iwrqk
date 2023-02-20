import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iwrqk/l10n.dart';

import '../common/global.dart';
import '../common/theme.dart';
import 'reloadable_image.dart';

class MediaPreview extends StatefulWidget {
  final bool isVideo;
  final String imageSrc;
  final String title;
  final String uploaderName;
  final String plays;
  final String likes;
  final String? duration;

  const MediaPreview({
    required this.imageSrc,
    required this.title,
    required this.uploaderName,
    required this.plays,
    required this.likes,
    this.duration,
    required this.isVideo,
    Key? key,
  }) : super(key: key);

  @override
  State<MediaPreview> createState() => _MediaPreviewState();
}

class _MediaPreviewState extends State<MediaPreview> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            offset: Offset(2.5, 2.5),
            blurRadius: 7.5,
          )
        ]),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(7.5),
            child: Container(
                color: Theme.of(context).canvasColor,
                child: Column(children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      ReloadableImage(
                        imageUrl: widget.imageSrc,
                        aspectRatio: 16 / 9,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(7.5, 2.5, 7.5, 5),
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.transparent, Colors.black45],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.play_fill,
                                  size: 12.5,
                                  color: Colors.white,
                                ),
                                Container(
                                    margin: EdgeInsets.only(left: 2, right: 5),
                                    child: Text(
                                      widget.plays,
                                      style: TextStyle(
                                          fontSize: 12.5, color: Colors.white),
                                    )),
                                Icon(
                                  CupertinoIcons.hand_thumbsup_fill,
                                  size: 12.5,
                                  color: Colors.white,
                                ),
                                Container(
                                    margin: EdgeInsets.only(left: 2),
                                    child: Text(
                                      widget.likes,
                                      style: TextStyle(
                                          fontSize: 12.5, color: Colors.white),
                                    ))
                              ],
                            ),
                            Text(
                              widget.duration ?? "",
                              style: TextStyle(
                                  fontSize: 12.5, color: Colors.white),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Container(
                            padding: EdgeInsets.fromLTRB(5, 7.5, 5, 0),
                            child: SizedBox(
                              child: Text(
                                widget.title,
                                style: TextStyle(
                                  fontSize: 12.5,
                                ),
                              ),
                            )),
                        Container(
                            padding: EdgeInsets.fromLTRB(7.5, 0, 7.5, 7.5),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Icon(
                                          CupertinoIcons.person_fill,
                                          size: 12.5,
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(left: 2),
                                            child: Text(widget.uploaderName,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                )))
                                      ]),
                                  Text(
                                    widget.isVideo
                                        ? L10n.of(context).videos
                                        : L10n.of(context).images,
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  )
                                ]))
                      ]))
                ]))));
  }
}
