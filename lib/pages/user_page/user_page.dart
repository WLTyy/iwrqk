import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iwrqk/common/theme.dart';
import 'package:iwrqk/l10n.dart';

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
      backgroundColor: IwrTheme.barBackColor,
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
                          minWidth: 20,
                          height: 20,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.close_rounded,
                            color: IwrTheme.fontColor,
                          )))
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
                        height: 100,
                        width: 360,
                        margin: EdgeInsets.only(top: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: IwrTheme.boxBackColor,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(5, 5),
                                blurRadius: 10,
                                color: IwrTheme.shadowColor,
                              )
                            ]),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Row(children: [
                                  ClipOval(
                                      child: Image.network(
                                          "https://cravatar.cn/avatar/245467ef31b6f0addc72b039b94122a4.png",
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover)),
                                  Container(
                                    margin: EdgeInsets.only(left: 15),
                                    child: Text(
                                      "Futo",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                          color: IwrTheme.fontColor),
                                    ),
                                  )
                                ]),
                              ),
                              Container(
                                  margin: EdgeInsets.only(right: 15),
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: IwrTheme.fontColor2,
                                  ))
                            ]),
                      ))),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Column(children: [
                  UserItem(
                      title: L10n.of(context).friends,
                      icon: Icon(
                        Icons.people_rounded,
                        size: 27.5,
                        color: IwrTheme.fontColor2,
                      ),
                      routeName: "/"),
                  UserItem(
                      title: L10n.of(context).history,
                      icon: Icon(
                        Icons.history_rounded,
                        size: 30,
                        color: IwrTheme.fontColor2,
                      ),
                      routeName: "/"),
                  UserItem(
                      title: L10n.of(context).download,
                      icon: Icon(
                        Icons.file_download_rounded,
                        size: 30,
                        color: IwrTheme.fontColor2,
                      ),
                      routeName: "/"),
                  UserItem(
                      title: L10n.of(context).favorite,
                      icon: Icon(
                        Icons.favorite,
                        size: 25,
                        color: IwrTheme.fontColor2,
                      ),
                      routeName: "/"),
                  UserItem(
                      title: L10n.of(context).playlists,
                      icon: Icon(
                        Icons.playlist_play_rounded,
                        size: 35,
                        color: IwrTheme.fontColor2,
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
                        borderRadius: BorderRadius.circular(10),
                        child: MaterialButton(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            onPressed: () {},
                            child: Container(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.settings_rounded,
                                      size: 35,
                                      color: IwrTheme.fontColor2,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: Text(
                                        L10n.of(context).settings,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: IwrTheme.fontColor2,
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
