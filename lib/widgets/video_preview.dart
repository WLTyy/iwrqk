import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/global.dart';
import '../common/theme.dart';
import 'reloadable_image.dart';

class VideoPreview extends StatefulWidget {
  final String imageSrc;
  final String title;
  final String uploaderName;
  final String plays;
  final String likes;
  final String duration;

  const VideoPreview(
      {required this.imageSrc,
      required this.title,
      required this.uploaderName,
      required this.plays,
      required this.likes,
      required this.duration,
      Key? key})
      : super(key: key);

  @override
  State<VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
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
                width: 190,
                height: 170,
                child: Column(children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      ReloadableImage(
                        imageUrl: widget.imageSrc,
                        width: 190,
                        height: 100,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.transparent, Colors.black45],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)),
                        width: 200,
                        height: 25,
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          margin: EdgeInsets.fromLTRB(7.5, 0, 7.5, 5),
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
                                      margin:
                                          EdgeInsets.only(left: 2, right: 5),
                                      child: Text(
                                        widget.plays,
                                        style: TextStyle(
                                            fontSize: 12.5,
                                            color: Colors.white),
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
                                            fontSize: 12.5,
                                            color: Colors.white),
                                      ))
                                ],
                              ),
                              Text(
                                widget.duration,
                                style: TextStyle(
                                    fontSize: 12.5, color: Colors.white),
                              )
                            ],
                          ),
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
                            margin: EdgeInsets.fromLTRB(5, 7.5, 0, 0),
                            child: SizedBox(
                              width: 180,
                              child: Text(
                                widget.title,
                                style: TextStyle(
                                  fontSize: 12.5,
                                ),
                              ),
                            )),
                        Container(
                            margin: EdgeInsets.fromLTRB(7.5, 0, 0, 7.5),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
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
                                ]))
                      ]))
                ]))));
  }
}
