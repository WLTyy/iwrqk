import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../l10n.dart';
import '../../widgets/reloadable_image.dart';
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
        child: Column(children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.circular(15)),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Row(children: [
                          ClipOval(
                            child: ReloadableImage(
                              imageUrl:
                                  'https://cravatar.cn/avatar/245467ef31b6f0addc72b039b94122a4.png',
                              width: 60,
                              height: 60,
                            ),
                          ),
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
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Column(children: [
              UserItem(
                  title: L10n.of(context).user_friends,
                  icon: Icon(
                    CupertinoIcons.person_2_fill,
                    size: 30,
                  ),
                  routeName: "/"),
              UserItem(
                  title: L10n.of(context).user_history,
                  icon: Icon(
                    CupertinoIcons.time,
                    size: 30,
                  ),
                  routeName: "/"),
              UserItem(
                  title: L10n.of(context).user_downloads,
                  icon: Icon(
                    CupertinoIcons.arrow_down_to_line,
                    size: 30,
                  ),
                  routeName: "/"),
              UserItem(
                  title: L10n.of(context).user_favorites,
                  icon: Icon(
                    CupertinoIcons.heart_fill,
                    size: 30,
                  ),
                  routeName: "/"),
              UserItem(
                  title: L10n.of(context).user_playlists,
                  icon: Icon(
                    CupertinoIcons.list_dash,
                    size: 30,
                  ),
                  routeName: "/"),
              Padding(
                padding: EdgeInsets.only(top: 25),
                child: UserItem(
                    title: L10n.of(context).user_settings,
                    icon: Icon(
                      CupertinoIcons.gear_solid,
                      size: 30,
                    ),
                    routeName: "/settings"),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
