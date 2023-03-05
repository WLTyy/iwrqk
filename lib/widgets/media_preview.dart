import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iwrqk/common/classes.dart';
import 'package:iwrqk/l10n.dart';

import '../common/global.dart';
import '../common/theme.dart';
import '../pages/video_detail_page/video_detail_page.dart';
import 'reloadable_image.dart';

class MediaPreview extends StatefulWidget {
  final MediaPreviewData data;

  const MediaPreview({Key? key, required this.data}) : super(key: key);

  @override
  State<MediaPreview> createState() => _MediaPreviewState();
}

class _MediaPreviewState extends State<MediaPreview> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ClipRRect(
          child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).shadowColor, width: 0.5),
                borderRadius: BorderRadius.circular(7.5),
                color: Theme.of(context).canvasColor,
              ),
              child: Column(
                  children: widget.data.uploaderName == null
                      ? [
                          ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(7.5)),
                              child: Container(
                                alignment: Alignment.center,
                                child: widget.data.coverImageUrl == null
                                    ? AspectRatio(aspectRatio: 16 / 9)
                                    : ReloadableImage(
                                        imageUrl: widget.data.coverImageUrl!,
                                        aspectRatio: 16 / 9,
                                        fit: BoxFit.cover,
                                      ),
                              )),
                          Expanded(
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Container(
                                    padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                                    child: SizedBox(
                                      child: Text(
                                        widget.data.title,
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: 12.5,
                                        ),
                                      ),
                                    )),
                                Container(
                                    padding:
                                        EdgeInsets.fromLTRB(7.5, 0, 7.5, 5),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                CupertinoIcons.play_fill,
                                                size: 12.5,
                                                color: Colors.white,
                                              ),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      left: 2, right: 5),
                                                  child: Text(
                                                    widget.data.views,
                                                    style: TextStyle(
                                                        fontSize: 12.5,
                                                        color: Colors.white),
                                                  )),
                                              Icon(
                                                CupertinoIcons
                                                    .hand_thumbsup_fill,
                                                size: 12.5,
                                                color: Colors.white,
                                              ),
                                              Container(
                                                  margin:
                                                      EdgeInsets.only(left: 2),
                                                  child: Text(
                                                    widget.data.likes,
                                                    style: TextStyle(
                                                        fontSize: 12.5,
                                                        color: Colors.white),
                                                  ))
                                            ],
                                          ),
                                          Text(
                                            widget.data.type == MediaType.video
                                                ? L10n.of(context).videos
                                                : L10n.of(context).images,
                                            style: TextStyle(
                                              fontSize: 10,
                                            ),
                                          )
                                        ]))
                              ]))
                        ]
                      : [
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(7.5)),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: widget.data.coverImageUrl == null
                                        ? AspectRatio(aspectRatio: 16 / 9)
                                        : ReloadableImage(
                                            imageUrl:
                                                widget.data.coverImageUrl!,
                                            aspectRatio: 16 / 9,
                                            fit: BoxFit.cover,
                                          ),
                                  )),
                              Container(
                                padding:
                                    EdgeInsets.fromLTRB(7.5, 2.5, 7.5, 2.5),
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                      Colors.transparent,
                                      Colors.black45
                                    ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          CupertinoIcons.play_fill,
                                          size: 12.5,
                                          color: Colors.white,
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(
                                                left: 2, right: 5),
                                            child: Text(
                                              widget.data.views,
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
                                              widget.data.likes,
                                              style: TextStyle(
                                                  fontSize: 12.5,
                                                  color: Colors.white),
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Expanded(
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Container(
                                    padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                                    child: SizedBox(
                                      child: Text(
                                        widget.data.title,
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: 12.5,
                                        ),
                                      ),
                                    )),
                                Container(
                                    padding:
                                        EdgeInsets.fromLTRB(7.5, 0, 7.5, 5),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(children: [
                                            Icon(
                                              CupertinoIcons.person_fill,
                                              size: 12.5,
                                            ),
                                            Container(
                                                margin:
                                                    EdgeInsets.only(left: 2),
                                                child: Text(
                                                    widget.data.uploaderName!,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                    )))
                                          ]),
                                          Text(
                                            widget.data.type == MediaType.video
                                                ? L10n.of(context).videos
                                                : L10n.of(context).images,
                                            style: TextStyle(
                                              fontSize: 10,
                                            ),
                                          )
                                        ]))
                              ]))
                        ]))),
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              VideoDetailPage(
                  videoUrl: "https://www.iwara.tv${widget.data.url}"),
        ));
      },
    );
  }
}