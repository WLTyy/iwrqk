import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../l10n.dart';
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
      body: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Column(children: [
              Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(CupertinoIcons.xmark, size: 35),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  )),
              GestureDetector(
                onTap: (){},
                child: Container(
                  height: 100,
                  width: 360,
                  margin: EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).shadowColor,
                          offset: Offset(5, 5),
                          blurRadius: 10,
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
                                ),
                              ),
                            )
                          ]),
                        ),
                        Container(
                            margin: EdgeInsets.only(right: 15),
                            child: Icon(
                              CupertinoIcons.forward,
                            ))
                      ]),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Column(children: [
                  UserItem(
                      title: L10n.of(context).friends,
                      icon: Icon(
                        CupertinoIcons.person_2_fill,
                        size: 30,
                      ),
                      routeName: "/"),
                  UserItem(
                      title: L10n.of(context).history,
                      icon: Icon(
                        CupertinoIcons.time,
                        size: 30,
                      ),
                      routeName: "/"),
                  UserItem(
                      title: L10n.of(context).download,
                      icon: Icon(
                        CupertinoIcons.arrow_down_to_line,
                        size: 30,
                      ),
                      routeName: "/"),
                  UserItem(
                      title: L10n.of(context).favorite,
                      icon: Icon(
                        CupertinoIcons.heart_fill,
                        size: 30,
                      ),
                      routeName: "/"),
                  UserItem(
                      title: L10n.of(context).playlists,
                      icon: Icon(
                        CupertinoIcons.list_dash,
                        size: 30,
                      ),
                      routeName: "/"),
                ]),
              ),
            ]),
            Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: MaterialButton(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        onPressed: () {
                          Navigator.pushNamed(context, "/settings");
                        },
                        child: Container(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  CupertinoIcons.gear_alt_fill,
                                  size: 35,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    L10n.of(context).settings,
                                    style: TextStyle(
                                      fontSize: 15,
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
