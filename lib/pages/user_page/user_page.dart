import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
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
      backgroundColor: IwrTheme.backColor4,
      body: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Theme(
                      data: ThemeData(
                          splashColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent),
                      child: MaterialButton(
                          minWidth: 20.w,
                          height: 20.w,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.close_rounded,
                              color: IwrTheme.fontColor, size: 35.sp)))
                ],
              ),
              Theme(
                  data: ThemeData(
                      splashColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent),
                  child: MaterialButton(
                      onPressed: () {},
                      child: Container(
                        height: 100.h,
                        width: 360.w,
                        margin: REdgeInsets.only(top: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: IwrTheme.backColor3,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(5.r, 5.r),
                                blurRadius: 10.r,
                                color: IwrTheme.shadowColor,
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
                                          color: IwrTheme.fontColor),
                                    ),
                                  )
                                ]),
                              ),
                              Container(
                                  margin: REdgeInsets.only(right: 15),
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: IwrTheme.fontColor3,
                                  ))
                            ]),
                      ))),
              Container(
                margin: REdgeInsets.only(top: 20),
                child: Column(children: [
                  UserItem(
                      title: L10n.of(context).friends,
                      icon: Icon(
                        FluentIcons.people_16_filled,
                        size: 30.sp,
                        color: IwrTheme.fontColor3,
                      ),
                      routeName: "/"),
                  UserItem(
                      title: L10n.of(context).history,
                      icon: Icon(
                        FluentIcons.history_16_filled,
                        size: 30.sp,
                        color: IwrTheme.fontColor3,
                      ),
                      routeName: "/"),
                  UserItem(
                      title: L10n.of(context).download,
                      icon: Icon(
                        FluentIcons.arrow_download_16_filled,
                        size: 30.sp,
                        color: IwrTheme.fontColor3,
                      ),
                      routeName: "/"),
                  UserItem(
                      title: L10n.of(context).favorite,
                      icon: Icon(
                        FluentIcons.heart_16_filled,
                        size: 30.sp,
                        color: IwrTheme.fontColor3,
                      ),
                      routeName: "/"),
                  UserItem(
                      title: L10n.of(context).playlists,
                      icon: Icon(
                        FluentIcons.video_clip_multiple_16_filled,
                        size: 30.sp,
                        color: IwrTheme.fontColor3,
                      ),
                      routeName: "/"),
                ]),
              ),
            ]),
            Row(
              children: [
                Theme(
                    data: ThemeData(
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: MaterialButton(
                            padding: REdgeInsets.symmetric(vertical: 15),
                            onPressed: () {},
                            child: Container(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      FluentIcons.settings_16_filled,
                                      size: 35.sp,
                                      color: IwrTheme.fontColor3,
                                    ),
                                    Container(
                                      margin: REdgeInsets.only(top: 5),
                                      child: Text(
                                        L10n.of(context).settings,
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          color: IwrTheme.fontColor,
                                        ),
                                      ),
                                    )
                                  ]),
                            ))))
              ],
            )
          ])),
    );
  }
}
