import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwrqk/widgets/reloadable_image.dart';

import '../common/global.dart';
import '../common/theme.dart';

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
            offset: Offset(2.5.r, 2.5.r),
            blurRadius: 7.5.r,
          )
        ]),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(7.5.r),
            child: Container(
                color: Theme.of(context).cardColor,
                width: 180.w,
                height: 160.h,
                child: Column(children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      ReloadableImage(
                        imageUrl: widget.imageSrc,
                        size: Size(180.w, 95.h),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.transparent, Colors.black45],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)),
                        width: 180.w,
                        height: 25.h,
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          margin: REdgeInsets.fromLTRB(7.5, 0, 7.5, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    FluentIcons.play_16_filled,
                                    size: 12.5.sp,
                                    color: Colors.white,
                                  ),
                                  Container(
                                      margin:
                                          REdgeInsets.only(left: 2, right: 5),
                                      child: Text(
                                        widget.plays,
                                        style: TextStyle(
                                            fontSize: 12.5.sp,
                                            color: Colors.white),
                                      )),
                                  Icon(
                                    FluentIcons.thumb_like_16_filled,
                                    size: 12.5.sp,
                                    color: Colors.white,
                                  ),
                                  Container(
                                      margin: REdgeInsets.only(left: 2),
                                      child: Text(
                                        widget.likes,
                                        style: TextStyle(
                                            fontSize: 12.5.sp,
                                            color: Colors.white),
                                      ))
                                ],
                              ),
                              Text(
                                widget.duration,
                                style: TextStyle(
                                    fontSize: 12.5.sp, color: Colors.white),
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
                          margin: REdgeInsets.fromLTRB(7.5, 5, 0, 0),
                          child: Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: 12.5.sp,
                            ),
                          ),
                        ),
                        Container(
                            margin: REdgeInsets.fromLTRB(7.5, 0, 0, 7.5),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Icon(
                                    FluentIcons.person_16_filled,
                                    size: 12.5.sp,
                                  ),
                                  Container(
                                      margin: REdgeInsets.only(left: 2),
                                      child: Text(widget.uploaderName,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                          )))
                                ]))
                      ]))
                ]))));
  }
}
