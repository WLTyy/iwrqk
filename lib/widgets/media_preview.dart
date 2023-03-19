import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iwrqk/common/classes.dart';
import 'package:iwrqk/common/util.dart';
import 'package:iwrqk/l10n.dart';
import 'package:iwrqk/pages/uploader_profile_page/uploader_profile_page.dart';

import '../common/global.dart';
import '../common/theme.dart';
import '../pages/media_detail_page/media_detail_page.dart';
import 'reloadable_image.dart';

class MediaPreview extends StatefulWidget {
  final MediaPreviewData data;

  const MediaPreview({Key? key, required this.data}) : super(key: key);

  @override
  State<MediaPreview> createState() => _MediaPreviewState();
}

class _MediaPreviewState extends State<MediaPreview> {
  Widget _buildViewsAndRating() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 7.5, vertical: 2.5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.5),
            color: Colors.black.withAlpha(175),
          ),
          height: 25,
          child: Row(
            children: [
              Icon(
                CupertinoIcons.eye_fill,
                size: 12.5,
                color: Colors.white,
              ),
              Container(
                  margin: EdgeInsets.only(left: 2),
                  child: Text(
                    compactBigNumber(context, widget.data.views),
                    style: TextStyle(fontSize: 12.5, color: Colors.white),
                  ))
            ],
          ),
        ),
        if (widget.data.ratingType == "ecchi")
          Container(
            padding: EdgeInsets.symmetric(horizontal: 7.5, vertical: 2.5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.5),
              color: Colors.red.withAlpha(175),
            ),
            height: 25,
            child: Center(
                child: Text(
              "R-18",
              style: TextStyle(fontSize: 12.5, color: Colors.white),
            )),
          ),
      ],
    );
  }

  Widget _buildLikesAndGallery() {
    Duration? duration;

    if (widget.data.duration != null) {
      duration = Duration(seconds: widget.data.duration!);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 7.5, vertical: 2.5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.5),
            color: Colors.black.withAlpha(175),
          ),
          height: 25,
          child: Row(
            children: [
              Icon(
                CupertinoIcons.heart_fill,
                size: 12.5,
                color: Colors.white,
              ),
              Container(
                  margin: EdgeInsets.only(left: 2),
                  child: Text(
                    compactBigNumber(context, widget.data.likes),
                    style: TextStyle(fontSize: 12.5, color: Colors.white),
                  ))
            ],
          ),
        ),
        if (duration != null)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 7.5, vertical: 2.5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.5),
              color: Colors.black.withAlpha(175),
            ),
            height: 25,
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.play_fill,
                  size: 12.5,
                  color: Colors.white,
                ),
                Container(
                    margin: EdgeInsets.only(left: 2),
                    child: Text(
                      "${duration.inMinutes}:${(duration.inSeconds.remainder(60)).toString().padLeft(2, '0')}",
                      style: TextStyle(fontSize: 12.5, color: Colors.white),
                    ))
              ],
            ),
          ),
        if (widget.data.galleryLength != null)
          if (widget.data.galleryLength! > 1)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 7.5, vertical: 2.5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.5),
                color: Colors.black.withAlpha(175),
              ),
              height: 25,
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.photo_fill_on_rectangle_fill,
                    size: 12.5,
                    color: Colors.white,
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 2),
                      child: Text(
                        "${widget.data.galleryLength}",
                        style: TextStyle(fontSize: 12.5, color: Colors.white),
                      ))
                ],
              ),
            ),
      ],
    );
  }

  List<Widget> _buildFullVerison() {
    return [
      Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(7.5)),
              child: Container(
                alignment: Alignment.center,
                child: widget.data.hasCover()
                    ? ReloadableImage(
                        imageUrl: widget.data.getCoverUrl(),
                        aspectRatio: 16 / 9,
                        fit: BoxFit.cover,
                      )
                    : AspectRatio(aspectRatio: 16 / 9),
              )),
          Positioned(left: 5, top: 5, bottom: 5, child: _buildViewsAndRating()),
          Positioned(
              right: 5, top: 5, bottom: 5, child: _buildLikesAndGallery()),
          if (widget.data.isPrivate)
            Container(
              color: Colors.black,
              alignment: Alignment.center,
              height: 35,
              child: Text(
                L10n.of(context).meida_private,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
      Expanded(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                padding: EdgeInsets.fromLTRB(7.5, 0, 7.5, 5),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder: (context, animation,
                                      secondaryAnimation) =>
                                  UploaderProfilePage(
                                      userName: widget.data.uploader.userName),
                            ));
                          },
                          child: Row(children: [
                            Icon(CupertinoIcons.person_fill,
                                size: 12.5, color: Colors.grey),
                            Flexible(
                                child: Container(
                                    margin: EdgeInsets.only(left: 2),
                                    child: Text(widget.data.uploader.nickName,
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey,
                                          overflow: TextOverflow.ellipsis,
                                        ))))
                          ]),
                        ),
                      ),
                      Text(
                        getDisplayDate(context, widget.data.createDate),
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      )
                    ]))
          ]))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
          color: Theme.of(context).canvasColor,
          child: Column(children: _buildFullVerison())),
      onTap: () {
        if (widget.data.isPrivate) return;
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              MediaDetailPage(
            id: widget.data.id,
            type: widget.data.type,
          ),
        ));
      },
    );
  }
}
