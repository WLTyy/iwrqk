import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iwrqk/common/classes.dart';
import 'package:iwrqk/l10n.dart';
import 'package:iwrqk/pages/uploader_profile_page/uploader_profile_page.dart';

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
  Widget _buildViewsAndLikes(Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          CupertinoIcons.play_fill,
          size: 12.5,
          color: color,
        ),
        Container(
            margin: EdgeInsets.only(left: 2, right: 5),
            child: Text(
              "${widget.data.views}",
              style: TextStyle(fontSize: 12.5, color: color),
            )),
        Icon(
          CupertinoIcons.heart_fill,
          size: 12.5,
          color: color,
        ),
        Container(
            margin: EdgeInsets.only(left: 2),
            child: Text(
              "${widget.data.likes}",
              style: TextStyle(fontSize: 12.5, color: color),
            ))
      ],
    );
  }

  List<Widget> _buildFullVerison() {
    return [
      Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(7.5)),
              child: Container(
                alignment: Alignment.center,
                child: widget.data.thumbnailLength != null
                    ? widget.data.thumbnailLength != 0
                        ? ReloadableImage(
                            imageUrl:"https://files.iwara.tv/image/thumbnail/${widget.data.fileId}/thumbnail-00.jpg",
                            aspectRatio: 16 / 9,
                            fit: BoxFit.cover,
                          )
                        : AspectRatio(aspectRatio: 16 / 9)
                    : AspectRatio(aspectRatio: 16 / 9),
              )),
          Container(
            padding: EdgeInsets.fromLTRB(7.5, 2.5, 7.5, 2.5),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black45],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildViewsAndLikes(Colors.white),
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
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (context, animation,
                                    secondaryAnimation) =>
                                UploaderProfilePage(
                                    homePageUrl:
                                        "https://www.iwara.tv/profile/${widget.data.uploader.userName}"),
                          ));
                        },
                        child: Row(children: [
                          Icon(CupertinoIcons.person_fill,
                              size: 12.5, color: Colors.grey),
                          Container(
                              margin: EdgeInsets.only(left: 2),
                              child: Text(widget.data.uploader.nickName,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.grey)))
                        ]),
                      ),
                      Text(
                        widget.data.type == MediaType.video
                            ? L10n.of(context).videos
                            : L10n.of(context).images,
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
          child: Column(
              children: _buildFullVerison())),
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              VideoDetailPage(
                  videoUrl: "https://www.iwara.tv/video/${widget.data.id}"),
        ));
      },
    );
  }
}
