import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/classes.dart';
import '../../component/iwr_tab_indicator.dart';
import '../../l10n.dart';
import '../../widgets/reloadable_image.dart';
import '../../widgets/video_preview.dart';
import '../video_detail_page/user_comment.dart';

class UploaderProfilePage extends StatefulWidget {
  const UploaderProfilePage({Key? key}) : super(key: key);

  @override
  State<UploaderProfilePage> createState() => _UploaderProfilePageState();
}

class _UploaderProfilePageState extends State<UploaderProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    _tabController.addListener(() {
      print(_tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final uploaderProfile =
        ModalRoute.of(context)!.settings.arguments as UploaderProfile;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(CupertinoIcons.back, size: 30)),
        title: Text(uploaderProfile.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Theme.of(context).canvasColor,
            padding: EdgeInsets.only(top: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(children: [
                  ClipOval(
                    child: ReloadableImage(
                      imageUrl:
                          'https://cravatar.cn/avatar/245467ef31b6f0addc72b039b94122a4.png',
                      width: 60,
                      height: 60,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    uploaderProfile.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                ]),
                ButtonBar(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(L10n.of(context).follow),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(L10n.of(context).friend),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(L10n.of(context).direct_message),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
              color: Theme.of(context).canvasColor,
              alignment: Alignment.centerLeft,
              child: TabBar(
                isScrollable: true,
                indicator: IwrTabIndicator(),
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.blue,
                tabs: [
                  Tab(text: L10n.of(context).videos),
                  Tab(
                    text: L10n.of(context).images,
                  ),
                  Tab(
                    text: L10n.of(context).comments,
                  ),
                  Tab(
                    text: L10n.of(context).user_details,
                  )
                ],
                controller: _tabController,
              )),
          Expanded(
              child: TabBarView(controller: _tabController, children: [
            Container(),
            Container(),
            Column(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    UserComment(
                      avatarUrl:
                          'https://cravatar.cn/avatar/245467ef31b6f0addc72b039b94122a4.png',
                      name: 'John Smith',
                      comment: 'This is a great app!',
                      likeCount: 10,
                      time: DateTime.now(),
                    )
                  ],
                )),
                Container(
                    color: Theme.of(context).canvasColor,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius:
                              BorderRadius.all(Radius.circular(1000))),
                      child: Text(
                        "test",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )),
              ],
            ),
            Container(
              color: Theme.of(context).canvasColor,
              child: Column(children: []),
            )
          ])),
        ],
      ),
    );
  }
}
