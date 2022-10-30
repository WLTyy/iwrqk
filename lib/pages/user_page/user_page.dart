import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:iwrqk/common/global.dart';
import 'package:iwrqk/common/theme.dart';
import 'package:iwrqk/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'user_item.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Column(children: [
              Container(
                  margin: EdgeInsets.only(bottom: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MaterialButton(
                          minWidth: 20.w,
                          height: 20.w,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.close_rounded, size: 35.sp))
                    ],
                  )),
              MaterialButton(
                  onPressed: () {},
                  child: Container(
                    height: 100.h,
                    width: 360.w,
                    margin: REdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).shadowColor,
                            offset: Offset(5.r, 5.r),
                            blurRadius: 10.r,
                          )
                        ]),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: REdgeInsets.only(left: 20),
                            child: Row(children: [
                              ClipOval(
                                  child: Image.network(
                                      "https://cravatar.cn/avatar/245467ef31b6f0addc72b039b94122a4.png",
                                      width: 60.w,
                                      height: 60.w,
                                      fit: BoxFit.cover)),
                              Container(
                                margin: REdgeInsets.only(left: 15),
                                child: Text(
                                  "Futo",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30.sp,
                                  ),
                                ),
                              )
                            ]),
                          ),
                          Container(
                              margin: REdgeInsets.only(right: 15),
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                              ))
                        ]),
                  )),
              Container(
                margin: REdgeInsets.only(top: 20),
                child: Column(children: [
                  UserItem(
                      title: L10n.of(context).friends,
                      icon: Icon(
                        FluentIcons.people_16_filled,
                        size: 30.sp,
                      ),
                      routeName: "/"),
                  UserItem(
                      title: L10n.of(context).history,
                      icon: Icon(
                        FluentIcons.history_16_filled,
                        size: 30.sp,
                      ),
                      routeName: "/"),
                  UserItem(
                      title: L10n.of(context).download,
                      icon: Icon(
                        FluentIcons.arrow_download_16_filled,
                        size: 30.sp,
                      ),
                      routeName: "/"),
                  UserItem(
                      title: L10n.of(context).favorite,
                      icon: Icon(
                        FluentIcons.heart_16_filled,
                        size: 30.sp,
                      ),
                      routeName: "/"),
                  UserItem(
                      title: L10n.of(context).playlists,
                      icon: Icon(
                        FluentIcons.video_clip_multiple_16_filled,
                        size: 30.sp,
                      ),
                      routeName: "/"),
                ]),
              ),
            ]),
            Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: MaterialButton(
                        padding: REdgeInsets.symmetric(vertical: 15),
                        onPressed: () {
                          Navigator.pushNamed(context, "/settings");
                        },
                        child: Container(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  FluentIcons.settings_16_filled,
                                  size: 35.sp,
                                ),
                                Container(
                                  margin: REdgeInsets.only(top: 5),
                                  child: Text(
                                    L10n.of(context).settings,
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                )
                              ]),
                        )))
              ],
            )
          ])),
    );
  }
}
