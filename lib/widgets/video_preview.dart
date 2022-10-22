import 'dart:ui';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common/global.dart';
import '../common/theme.dart';

class VideoPreview extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
        decoration: Global.isDarkMode
            ? null
            : BoxDecoration(boxShadow: [
                BoxShadow(
                  offset: Offset(2.5.r, 2.5.r),
                  blurRadius: 10.r,
                  color: IwrTheme.gray,
                )
              ]),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: SizedBox(
                width: 180.w,
                height: 160.h,
                child: Column(children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      SizedBox(
                          width: 180.w,
                          height: 95.h,
                          child: Image.network(
                            imageSrc,
                            fit: BoxFit.cover,
                          )),
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
                                        plays,
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
                                        likes,
                                        style: TextStyle(
                                            fontSize: 12.5.sp,
                                            color: Colors.white),
                                      ))
                                ],
                              ),
                              Text(
                                duration,
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
                      child: Container(
                    color: IwrTheme.backColor4,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: REdgeInsets.fromLTRB(7.5, 5, 0, 0),
                            child: Text(
                              title,
                              style: TextStyle(
                                  fontSize: 12.5.sp, color: IwrTheme.fontColor),
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
                                      color: IwrTheme.fontColor2,
                                    ),
                                    Container(
                                        margin: REdgeInsets.only(left: 2),
                                        child: Text(uploaderName,
                                            style: TextStyle(
                                                fontSize: 10.sp,
                                                color: IwrTheme.fontColor2)))
                                  ]))
                        ]),
                  ))
                ]))));
  }
}
